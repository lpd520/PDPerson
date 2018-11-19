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
                CallBack ? CallBack(@"未知网络") : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                CallBack ? CallBack(@"网络处于断开状态") : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                CallBack ? CallBack(@"当前在WIFI网络下") : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                CallBack ? CallBack(@"当前使用的是蜂窝网络") : nil;
                break;
            default:
                CallBack(@"xxxxx");
//                CallBack ? CallBack(@"未知网络") : nil;
        }
    }];
    
}

@end
