//
//  UIImage+PD.m
//  PDPerson
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "UIImage+PD.h"

@implementation UIImage (PD)


- (UIImage *)drawCircleImage{
    
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
