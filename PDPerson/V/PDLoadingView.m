//
//  PDLoadingView.m
//  PDPerson
//
//  Created by mac on 2018/11/30.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDLoadingView.h"

// 图片下载进度指示器 内部控件间的间距
#define viewItemMargin 2

@implementation PDLoadingView


- (id)initWithLoadingType:(PDLoadingViewType)type{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(SCREEN_W/2-50, SCREEN_H/2, 100, 100);
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 50;
        self.clipsToBounds = YES;
        
        self.type = type;
    }
    return self;
}


-(void)setProgress:(double)progress{
    _progress = progress;
    
    //重绘放置在主线程，解决自动布局控制台报错的问题
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
        if (progress >= 1) {
            [self removeFromSuperview];
        }
    });
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    [[UIColor whiteColor] set];
    
    switch (self.type) {
            //饼形
        case PDLoadingViewTypePieDiagram:
        {
            //扇形的半径
            CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - viewItemMargin;
            
            CGFloat w = radius * 2;
            CGFloat h = w;
            CGFloat x = (rect.size.width - w) * 0.5;
            CGFloat y = (rect.size.height - h) * 0.5;
            CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
            CGContextFillPath(ctx);
            
            //扇形的背景颜色
            [[UIColor lightGrayColor]set];
            
            CGContextMoveToPoint(ctx, xCenter, yCenter);
            CGContextAddLineToPoint(ctx, xCenter, 0);
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 初始值
            CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 1);
            CGContextClosePath(ctx);
            
            CGContextFillPath(ctx);
        }
            break;
            //环形
        default:
        {
            CGContextSetLineWidth(ctx, 10);    // 环的宽度
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
            CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - viewItemMargin;
            CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
            CGContextStrokePath(ctx);
        }
            break;
    }
}


@end
