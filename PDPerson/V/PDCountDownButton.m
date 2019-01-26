//
//  PDCountDownButton.m
//  ChuanRen
//
//  Created by qingye on 2018/12/22.
//  Copyright © 2018 qingye. All rights reserved.
//

#import "PDCountDownButton.h"

@implementation PDCountDownButton

-(instancetype)initWithTitle:(NSString *)title{
    
    if (self = [super init]) {
        
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}


-(void)btnBeginCountDownWithTime:(NSInteger)timeInterval{
    
    __block NSInteger time = timeInterval;  // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);   // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){   // 倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 设置按钮的样式
                [self setTitle:self.finishedText forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            // int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 设置按钮显示读秒效果
                //[_downBtn setTitle:[NSString stringWithFormat:@"%@(%.2d)", btnText,time] forState:UIControlStateNormal];
                [self setTitle:[NSString stringWithFormat:@"%@(%zd)", self.showText,time] forState:UIControlStateNormal];
                if (!self.showText) {
                    self.userInteractionEnabled = NO;
                }
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


@end
