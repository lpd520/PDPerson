//
//  UILabel+PD.h
//  HaiTian
//
//  Created by mini on 2018/4/16.
//  Copyright © 2018年 wyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (PD)

+ (UILabel *)labelWithText:(NSString *)text
                      Font:(float)fontSize
                 TextColor:(UIColor *)color;


-(void)setAttributedString:(NSUInteger)loc1 to:(NSUInteger )loc2 color:(UIColor *)color font:(float)fontsize;

@end
