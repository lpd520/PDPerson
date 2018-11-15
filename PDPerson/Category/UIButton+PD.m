//
//  UIButton+PD.m
//  AnYue
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIButton+PD.h"

@implementation UIButton (PD)


-(void)setImageWithImgURL:(NSString *)imgUrl{
    
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrl] forState:UIControlStateNormal placeholderImage:nil];
    
}

+(UIButton *)borderButtonWithRadius:(float)radius bgColor:(UIColor *)bgColor Fontsize:(float)fontsize Text:(NSString *)text{
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundColor:bgColor];
    btn2.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    [btn2 setTitle:text forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2.layer setCornerRadius:radius];
    [btn2.layer setMasksToBounds:YES];
    
    return btn2;
}

-(void)setBorderColorWith:(UIColor *)color{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:1.];
}

+(UIButton *)buttonWithText:(NSString *)text txtColor:(UIColor *)txtColor Fontsize:(float)fontsize{
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    btn2.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    [btn2 setTitle:text forState:UIControlStateNormal];
    [btn2 setTitleColor:txtColor forState:UIControlStateNormal];
    btn2.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    return btn2;
}




@end
