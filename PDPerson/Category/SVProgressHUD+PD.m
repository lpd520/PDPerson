//
//  SVProgressHUD+PD.m
//  HaiTian
//
//  Created by mini on 2018/4/19.
//  Copyright © 2018年 wyj. All rights reserved.
//

#import "SVProgressHUD+PD.h"

@implementation SVProgressHUD (PD)



+(void)showYESmessage:(NSString *)mesg{
    
//    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
//    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"redTik"]];
    
    [SVProgressHUD showSuccessWithStatus:mesg];   // tik + 提示
    float s = mesg.length/4>1?mesg.length/4:1;

    [SVProgressHUD dismissWithDelay:s];
}

+(void)showNOmessage:(NSString *)mesg{
    
//    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"iii"]];
    
    [SVProgressHUD showInfoWithStatus:mesg];     // ！ + 提示
    float s = mesg.length/4>1?mesg.length/4:1;
    
    [SVProgressHUD dismissWithDelay:s];
}

+(void)showStatesMsge:(NSString *)mesg time:(float)second{
    
    [SVProgressHUD showWithStatus:mesg];    //转圈 + 提示
    
    if (second > 0) {
        [SVProgressHUD dismissWithDelay:second];
    }
}


+(void)showStatesMsge:(NSString *)mesg time:(float)second dismissWithBlock:(void (^)(void))aBlock{
    
    [SVProgressHUD showWithStatus:mesg];    //转圈 + 提示 + 1.5s 隐藏  block
    
    [SVProgressHUD dismissWithDelay:second completion:^{
        aBlock();    // 确定的相关处理
    }];
}


@end
