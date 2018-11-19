//
//  PDReachability.m
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDReachability.h"
#import <AFNetworking.h>

@implementation PDReachability

+(void)checkNetworkStatusOn:(void (^)(NSString * status))CallBack{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    // 网络状态检测
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                CallBack(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                CallBack(@"无法联网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                CallBack(@"当前在WIFI网络下");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                CallBack(@"当前使用的是蜂窝网络");
                break;
            default:
                CallBack(@"xxxxx");
        }
    }];
    
}

@end
