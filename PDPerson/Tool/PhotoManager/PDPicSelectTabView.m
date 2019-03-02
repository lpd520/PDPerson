//
//  PDPicTabView.m
//  JinShan
//
//  Created by qingye on 2018/1/2.
//  Copyright © 2018 qingye. All rights reserved.
//

#import "PDPicSelectTabView.h"
#import "PDImageItem.h"
 #import "PDPhotoManagerVC.h"

@interface PDPicSelectTabView()<UICollectionViewDelegate,UICollectionViewDataSource,
                            PDImageItemSelectDelegate>

@property(nonatomic,strong)UICollectionView *picsView;
@property(nonatomic,strong)UIView *coverView;

@property(nonatomic,strong)PDPhotoManagerVC *picManager;

@end

@implementation PDPicSelectTabView{
    UIImageView *showImgv;  // 预览view
    
    NSInteger picsCount;   //  记录图片数（不含 placeHolder img）
    float viewH ;

}


-(instancetype)initWithTabTitle:(NSString *)text SelectEnableType:(PDSelectEnableType)type{
    if (self = [super init]) {
        self.selectEnableType = type;
        [self setBackgroundColor:[UIColor whiteColor]];
        viewH = (SCREEN_W-80)/3+50;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(SCREEN_W));
            make.height.equalTo(@(self->viewH));
        }];
        
        UILabel *lab = [[UILabel alloc] init];
        
        lab.frame = CGRectMake(20, 0, SCREEN_W/2, 40);
        [self addSubview:lab];
        
        [self addSubview:self.picsView];
        [_picsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(40, 20, 10, 20));
        }];
        
    }
    return self;
}


#pragma mark - delegate

-(void)didDeletedImageItemOnCell:(PDImageItem *)cell atIndex:(NSUInteger)row{
    if(self.selectEnableType==PDSelectEnableTypeShow)  return ;   // 无法编辑，删除

    [self.imgUrlArray removeObjectAtIndex:row];
    [self reloadViewData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    PDImageItem *cell = (PDImageItem *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.imageUrl) {
        [APPKeyWindow addSubview:self.coverView];
        [showImgv setImageWithImgURL:cell.imageUrl placeHolder:nil];
        return ;
    }
    
    if (self.imgUrlArray.count>6) {
        [SVProgressHUD showNOmessage:@"最多选择6张图片"];
    }else{
        if(self.selectEnableType==PDSelectEnableTypeShow)  return ;
        
        // 拉起相机
        [[self currentViewController] presentViewController:self.picManager animated:YES completion:^{}];
        [self.picManager beginTakePhotoWithCamera];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.imgUrlArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PDImageItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PDImageItem" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    NSString *url = [self.imgUrlArray objectAtIndex:indexPath.row];
    cell.imageUrl = [url isEqualToString:@"temp"]? nil:url;
    cell.hideDeleted = self.selectEnableType == PDSelectEnableTypeShow || [url isEqualToString:@"temp"];

    return cell;
}

#pragma mark - action
-(void)reloadViewData{

    if (self.imgUrlArray.count>3) {
        viewH = (SCREEN_W-80)/1.5+60;
    }else
        viewH = (SCREEN_W-80)/3+50;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self->viewH));
    }];
    
    if (self.imgUrlArray.count==0 || self.imgUrlArray==nil) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
        }];
    }

    [self.picsView reloadData];
}

-(void)tapImage{
    
    [self.coverView removeFromSuperview];
}

#pragma mark - getter

-(NSMutableArray *)imgUrlArray{

    if (!_imgUrlArray) {
        _imgUrlArray = [NSMutableArray array];
        
        if (self.selectEnableType==PDSelectEnableTypeSelect)
            [_imgUrlArray addObject:@"temp"];
    }
    return _imgUrlArray;
}

-(NSString *)imgUrlStrings{
    //  todo...
    
//    NSString *str = [[NSString stringFromArray:self.imgUrlArray] stringByReplacingOccurrencesOfString:@",temp" withString:@""];
//    return str.length>10? str:nil;
    return nil;
}


-(UICollectionView *)picsView{
    if (!_picsView) {
        float w = (SCREEN_W-80)/3;

        UICollectionViewFlowLayout * _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 5;
        _layout.minimumLineSpacing      = 5;
        _layout.itemSize        = CGSizeMake(w, w);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _picsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _picsView.backgroundColor = [UIColor whiteColor];
        _picsView.showsVerticalScrollIndicator = NO;   // 是否显示滚动条
        _picsView.scrollEnabled = NO;     // 滚动使能
        _picsView.delegate    = self;
        _picsView.dataSource  = self;
        _picsView.contentSize = CGSizeMake(SCREEN_W, w*2 + 60);
        
        [_picsView registerClass:[PDImageItem class] forCellWithReuseIdentifier:@"PDImageItem"];
        
    }
    return _picsView;
}


-(PDPhotoManagerVC *)picManager{
    if (!_picManager) {
        _picManager = [[PDPhotoManagerVC alloc] init];
        WEAKSELF
        _picManager.imgURLCallbackBlock = ^(NSString *url) {
            [wself finishSelectedPicWithURL:url];
        };
    }
    return _picManager;
}

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _coverView.backgroundColor = [UIColor darkGrayColor];
        
        showImgv = [UIImageView imageViewWithNormalType];
        
        [_coverView addSubview:showImgv];
        [showImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self->_coverView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_W, SCREEN_W));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        [_coverView addGestureRecognizer:tap];
        
    }
    return _coverView;
}

-(void)finishSelectedPicWithURL:(NSString *)url{
    if (url) {
        [self.imgUrlArray insertObject:url atIndex:0];
    }
    [self reloadViewData];
    NSLog(@"==>=: %@",self.imgUrlStrings);
    [self.picManager dismissViewControllerAnimated:NO completion:^{  }];
}

- (UIViewController *)currentViewController{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

+(NSMutableArray *)arrayFromString:(NSString *)urls{
    
    if (urls.length==0 || urls==nil)    return nil;
    
    
    if ([urls containsString:@","]) {
        return [NSMutableArray arrayWithArray:[urls componentsSeparatedByString:@","]];
    }else{
        return [NSMutableArray arrayWithObject:urls];
    }
    
}


@end
