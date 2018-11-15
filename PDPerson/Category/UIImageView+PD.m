//
//  UIImageView+PD.m
//  PDPro
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIImageView+PD.h"


@implementation UIImageView (PD)

+(UIImageView *)imageViewWithNormalType{
    
    UIImageView *imgv = [[UIImageView alloc] init];
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    imgv.layer.masksToBounds = YES;
    
    return imgv;
}

+(UIImageView *)radiusImageViewWithRadius:(float)radius{
    UIImageView *imgv = [self imageViewWithNormalType];
    imgv.layer.cornerRadius = radius;
    
    return imgv;
}

-(void)setImageWithImgURL:(NSString *)imgUrl{
    
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
}

@end
