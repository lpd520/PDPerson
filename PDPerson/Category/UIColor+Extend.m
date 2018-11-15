//
//  UIColor+Extend.m
//  PDPro
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIColor+Extend.h"

@implementation UIColor (Extend)


#pragma mark  十六进制颜色
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString{
    
    return [self colorWithHexColorString:hexColorString alpha:1.0f];
}


#pragma mark  十六进制颜色
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha{
    
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length =2;
    
    range.location =0;
    
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&red];
    
    range.location =2;
    
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&green];
    
    range.location =4;
    
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&blue];
    
    UIColor *color = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:alpha];
    
    return color;
}



@end
