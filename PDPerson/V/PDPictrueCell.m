//
//  PDPictrueCell.m
//  JinShan
//
//  Created by qingye on 2019/2/13.
//  Copyright © 2019 qingye. All rights reserved.
//

#import "PDPictrueCell.h"

@implementation PDPictrueCell{
    UIImageView *imgv;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        imgv = [UIImageView imageViewWithNormalType];
        imgv.image = [UIImage imageNamed:@"camera"];
        [self.contentView addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
         
    }
    return self;
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



@end
