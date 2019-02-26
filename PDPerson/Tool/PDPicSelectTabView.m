//
//  PDPicTabView.m
//  JinShan
//
//  Created by qingye on 2018/1/2.
//  Copyright © 2018 qingye. All rights reserved.
//

#import "PDPicSelectTabView.h"
#import "PDImageItem.h"
#import "PDUploadParam.h"
#import <HXPhotoPicker.h>

@interface PDPicSelectTabView()<UICollectionViewDelegate,UICollectionViewDataSource,
                            PDImageItemSelectDelegate,HXAlbumListViewControllerDelegate>

@property(nonatomic,strong)UICollectionView *picsView;

@property(nonatomic,strong)HXPhotoManager *picManager;

@end

@implementation PDPicSelectTabView{
    NSInteger picsCount;   //记录图片数（不含 placeHolder img）
}


-(instancetype)initWithTabTitle:(NSString *)text{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *lab = [UILabel labelWithText:text Font:16 TextColor:[UIColor blackColor]];
        lab.frame = CGRectMake(20, 0, SCREEN_W/2, 40);
        [self addSubview:lab];
        
        [self addSubview:self.picsView];
        [_picsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(40, 20, 10, 20));
        }];
        
        
    }
    return self;
}

#pragma mark - http
-(void)uploadImgs:(NSMutableArray *)imgs{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (UIImage *img in imgs) {
        PDUploadParam *pm = [[PDUploadParam alloc] initWithImage:img Type:PDUploadQuantityCategoryMulti];
        [arr addObject:pm];
    }
    
//    [[PDNetworking sharedInstance] uploadWithURLString:[PDRequestURL URL_ForAPIUploadMutliImages] parameters:nil uploadParam:arr success:^(id responseObject) {
//
//        self.imgUrlStrings = responseObject[@"data"];
//        self.imgUrls = [NSMutableArray arrayWithArray:[responseObject[@"data"] componentsSeparatedByString:@","]];
//        NSLog(@"-->>%@",self.imgUrlStrings);
//    } failure:^(NSError *error) {
//        [SVProgressHUD showNOmessage:@"上传失败，请稍后再试"];
//    }];
}

-(void)uploadVideoWithFileURL:(NSURL *)fileURL{
    
}

#pragma mark - delegate

-(void)didDeletedImageItemOnCell:(PDImageItem *)cell atIndex:(NSUInteger)row{
    [self.imgUrls removeObjectAtIndex:row];
    
    [self.picsView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    if (self.onlyRead)
        return ;

    HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
    vc.delegate = self;
    vc.manager = self.picManager;
    [[self currentViewController] presentViewController:[[HXCustomNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgUrls.count==0?1:self.imgUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PDImageItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PDImageItem" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    if (self.imgUrls.count>0) {
        cell.imageUrl = [self.imgUrls objectAtIndex:indexPath.row];
    }else
        cell.image = [UIImage imageNamed:@"camera"];
    
    cell.canDelete = picsCount<indexPath.row+1;
    
    return cell;
}

// 通过 HXPhotoViewControllerDelegate 代理返回选择的图片以及视频
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original{
    
    if (self.type==0) {
        NSMutableArray *arr = [NSMutableArray array];
        for (HXPhotoModel *mo in photoList) {
            [arr addObject:mo.thumbPhoto];
        }
//        self.imgs = arr;
        [self uploadImgs:arr];
    }else{
        // 只有一个视频
        for (HXPhotoModel *mo in videoList) {
            
//            [self uploadVideoWithFileURL:mo.fileURL];    //  todo....
        }
    }
}

// 点击取消
- (void)albumListViewControllerDidCancel:(HXAlbumListViewController *)albumListViewController{
    
    
}


#pragma mark - getter
-(void)setImgUrls:(NSMutableArray *)imgUrls{
    picsCount = imgUrls.count;

    _imgUrls = imgUrls;
    
    if (imgUrls.count<3)
        [_imgUrls addObject:@""];
    
    [self.picsView reloadData];

}

-(void)setImgs:(NSMutableArray *)imgs{
    picsCount = imgs.count;

    _imgs = imgs;
    
    if (imgs.count<3)
        [_imgs addObject:[UIImage imageNamed:@"camera"]];
    
    [self.picsView reloadData];
}

-(UICollectionView *)picsView{
    if (!_picsView) {
        float w = (SCREEN_W-80)/3;

        UICollectionViewFlowLayout * _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 5;
        _layout.minimumLineSpacing      = 5;
        _layout.itemSize        = CGSizeMake(w, w);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _picsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _picsView.backgroundColor = [UIColor whiteColor];
        _picsView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
        _picsView.scrollEnabled = NO;  //滚动使能
        _picsView.delegate    = self;
        _picsView.dataSource  = self;
        _picsView.contentSize = CGSizeMake(SCREEN_W*1.5, w);
        
        [_picsView registerClass:[PDImageItem class] forCellWithReuseIdentifier:@"PDImageItem"];
    }
    return _picsView;
}

-(HXPhotoManager *)picManager{
    if (!_picManager) {
        
        if (self.type==0) {
            _picManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
            _picManager.configuration.maxNum = 3;
            _picManager.configuration.photoMaxNum = 3;
        }else{
            _picManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypeVideo];
            _picManager.configuration.videoMaxNum = 1;
        }
    }
    return _picManager;
}

-(void)setOnlyRead:(BOOL)onlyRead{
    _onlyRead = onlyRead;
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
@end
