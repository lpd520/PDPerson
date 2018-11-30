//
//  UIImageView+PD.h
//  PDPro
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (PD)


+(UIImageView *)imageViewWithNormalType;

+(UIImageView *)radiusImageViewWithRadius:(float)radius;

/**
 * 设置网络图片
 */
-(void)setImageWithImgURL:(NSString *)imgUrl needDrawRadius:(BOOL)flag;




@end
