//
//  UINavigationBar+bg.h
//  PDPerson
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (bg)

//设置背景颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor;
//设置leftItem、rightItem、titleView的alpha
- (void)setElementsAlpha:(CGFloat)alpha;
//重置回原来的样式
- (void)reset;

@end
