//
//  UILabel+PD.m
//  HaiTian
//
//  Created by mini on 2018/4/16.
//  Copyright © 2018年 wyj. All rights reserved.
//

#import "UILabel+PD.h"

@implementation UILabel (PD)

+ (UILabel *)labelWithText:(NSString *)text Font:(float)fontSize TextColor:(UIColor *)color{
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = text;
    lb.font = [UIFont systemFontOfSize:fontSize];
    lb.textColor = color;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.numberOfLines = 2;
    lb.backgroundColor = [UIColor whiteColor];

//    lb.adjustsFontSizeToFitWidth = YES;
//    lb.lineBreakMode = NSLineBreakByTruncatingTail;   //   xxx...
    
    return lb;
}



-(void)setAttributedString:(NSUInteger )loc1 to:(NSUInteger )loc2 color:(UIColor *)color font:(float)fontsize{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSRange range = NSMakeRange(loc1, loc2 - loc1);
    
    // 改变颜色
    [text addAttribute:NSForegroundColorAttributeName value:mainThemeRed range:range];
    
    // 改变字体大小及类型
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.] range:range];
    
    [self setAttributedText:text];
    
}


@end
