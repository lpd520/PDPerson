//
//  PDImageItem.m
//  JinShan
//
//  Created by qingye on 2018/1/2.
//  Copyright © 2018 qingye. All rights reserved.
//

#import "PDImageItem.h"
#import "UIButton+PD.h"


@interface PDImageItem()
{
    UIButton *xBtn;
    UIImageView *imgv;
}

@end

@implementation PDImageItem


-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        imgv = [UIImageView imageViewWithNormalType];
        imgv.image = [UIImage imageNamed:@"camera"];
        [self.contentView addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];

        xBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [xBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
        [self.contentView addSubview:xBtn];
        [xBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        [xBtn addTarget:self action:@selector(clickX) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)clickX{
    if ([self.delegate respondsToSelector:@selector(didDeletedImageItemOnCell:atIndex:)]) {
        [self.delegate didDeletedImageItemOnCell:self atIndex:self.tag];
    }
}


-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    if (imageUrl.length>0) {
        [imgv setImageWithImgURL:imageUrl placeHolder:[UIImage imageNamed:@"camera"]];
    }else{
        imgv.image = [UIImage imageNamed:@"camera"];
    }
}

-(void)setImage:(UIImage *)image{
    imgv.image = image?image:[UIImage imageNamed:@"camera"];
}

-(void)setCanDelete:(BOOL)canDelete{
    [xBtn setHidden:canDelete];
}
                                 

@end
