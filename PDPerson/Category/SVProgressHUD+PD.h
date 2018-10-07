//
//  SVProgressHUD+PD.h
//  HaiTian
//
//  Created by mini on 2018/4/19.
//  Copyright © 2018年 wyj. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (PD)



+(void)showYESmessage:(NSString *)mesg;
+(void)showNOmessage:(NSString *)mesg;

+(void)showStatesMsge:(NSString *)mesg time:(float)second;

+(void)showStatesMsge:(NSString *)mesg time:(float)second dismissWithBlock:(void (^)(void))aBlock;

@end
