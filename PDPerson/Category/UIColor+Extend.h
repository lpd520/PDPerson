//
//  UIColor+Extend.h
//  PDPro
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)

/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

/**
 *  十六进制颜色:含alpha
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;

@end
