//
//  UIButton+larger.h
//  JinJing
//
//  Created by mac on 2018/9/25.
//  Copyright © 2018年 QingYe. All rights reserved.

//  扩大按钮点击范围

#import <UIKit/UIKit.h>

@interface UIButton (larger)

- (void)setEnlargeEdgeWithTop:(CGFloat) top
                        right:(CGFloat) right
                       bottom:(CGFloat) bottom
                         left:(CGFloat) left;


- (void)setEnlargeEdge:(CGFloat) size;



@end
