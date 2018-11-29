//
//  PDLoadingProgress.m
//  PDPerson
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDLoadingProgress.h"

@interface PDLoadingProgress()

@property(nonatomic,strong)CALayer *progressLayer;

@end


static NSInteger progressHeight = 2;

@implementation PDLoadingProgress

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.frame = frame;
        [self.layer addSublayer:self.progressLayer];

    }
    return self;
}


-(void)setProgress:(float)progress{
    _progress = progress;   // 0 -> 1
    
    self.progressLayer.opacity = 1;
    self.progressLayer.frame = CGRectMake(0, 0, SCREEN_W * progress, progressHeight);
    if (progress == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressLayer.opacity = 0;
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressLayer.frame = CGRectMake(0, 0, 0, progressHeight);
        });
    }
    
}
-(void)setBgColor:(UIColor *)bgColor{
    _progressLayer.backgroundColor = bgColor.CGColor;
}

-(CALayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 0, progressHeight);
        _progressLayer.backgroundColor = [UIColor cyanColor].CGColor;
    }
    return _progressLayer;
}

@end
