//
//  UIButton+PD.h
//  AnYue
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (PD)


+(UIButton *)borderButtonWithRadius:(float)radius
                            bgColor:(UIColor *)bgColor
                           Fontsize:(float)fontsize
                               Text:(NSString *)text;

+(UIButton *)buttonWithText:(NSString *)text
                   txtColor:(UIColor *)txtColor
                   Fontsize:(float)fontsize ;

/**
 * 设置网络图片
 */
-(void)setImageWithImgURL:(NSString *)imgUrl;

-(void)setBorderColorWith:(UIColor *)color;


@end
