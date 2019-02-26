//
//  PDPicShowTabView.m
//  JinShan
//
//  Created by qingye on 2019/2/13.
//  Copyright © 2019 qingye. All rights reserved.
//

#import "PDPicShowTabView.h"
#import "PDPictrueCell.h"

@interface PDPicShowTabView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *picsView;
@property(nonatomic,strong)UIView *coverView;


@end

@implementation PDPicShowTabView{
    UIImageView *showImgv;
    
    float cellWidth;
}

-(instancetype)initWithTabTitle:(NSString *)text{
    if (self = [super init]) {
        cellWidth = (SCREEN_W-80)/3;

        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *lab = [UILabel labelWithText:text Font:16 TextColor:[UIColor blackColor]];
        
        lab.frame = CGRectMake(20, 0, SCREEN_W/2, 40);
        [self addSubview:lab];
        
        [self addSubview:self.picsView];
        [_picsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(40);
            make.bottom.equalTo(self).offset(-20);
            make.size.mas_equalTo(CGSizeMake(self->cellWidth*3+10, self->cellWidth));
        }];
        
    }
    return self;
}


#pragma mark - delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    [APPKeyWindow addSubview:self.coverView];
    [showImgv setImageWithImgURL:[self.imgUrls objectAtIndex:indexPath.item] placeHolder:nil];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgUrls.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PDPictrueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PDPictrueCell" forIndexPath:indexPath];
    cell.imageUrl = [self.imgUrls objectAtIndex:indexPath.item];
    
    return cell;
}


#pragma mark - action
-(void)tapImage{
    
    [self.coverView removeFromSuperview];
}


-(void)setImgUrls:(NSMutableArray *)imgUrls{
    
    _imgUrls = imgUrls;
    
    [self.picsView reloadData];
    
}

-(UICollectionView *)picsView{
    if (!_picsView) {
        float w = cellWidth;
        
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
        
        [_picsView registerClass:[PDPictrueCell class] forCellWithReuseIdentifier:@"PDPictrueCell"];
    }
    return _picsView;
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

@end
