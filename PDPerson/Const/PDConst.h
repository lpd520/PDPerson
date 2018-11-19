//
//  PDConst.h
//  PDPerson
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <Foundation/Foundation.h>


// 全局常量
static NSString *const picBaseURL = @"http://....";

// 通知key
static NSString *const kNotificationKeyForLogin = @"kNotificationKeyForLogin";


@interface PDConst : NSObject

#pragma 网络相关
extern NSString *const currentBaseURL;

#pragma 其他
extern NSString *const weixinAPP_ID;

@end
