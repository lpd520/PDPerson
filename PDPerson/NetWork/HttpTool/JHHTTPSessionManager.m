
//
//  POHTTPSessionManager.m
//  Yacht
//
//  Created by Jonphy on 2018/11/8.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHHTTPSessionManager.h"
#import "JHHTTPResponseSerializer.h"
#import "JHNetworkConstant.h"
#import "SVProgressHUD.h"
#import "YCNotificationConst.h"

@implementation JHHTTPSessionManager

static JHHTTPSessionManager *manager = nil;

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:ApiMainUrlBase]];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10.0;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                    case AFNetworkReachabilityStatusNotReachable:     // 无连线
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:PONetworkDidDisConnectedNotification object:nil];
                        [SVProgressHUD showErrorWithStatus:@"网络连接异常，请检查"];
                    });
                    break;
                    case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    DLog(@"AFNetworkReachability Reachable via WWAN");
                    [[NSNotificationCenter defaultCenter] postNotificationName:PONetworkDidConnectedNotification object:nil];
                    break;
                    case AFNetworkReachabilityStatusReachableViaWiFi: // WiFi
                    DLog(@"AFNetworkReachability Reachable via WiFi");
                    [[NSNotificationCenter defaultCenter] postNotificationName:PONetworkDidConnectedNotification object:nil];
                    break;
                    case AFNetworkReachabilityStatusUnknown:          // 未知网络
                default:
                    DLog(@"AFNetworkReachability Unknown");
                    break;
            }
        }];
        manager.responseSerializer = [JHHTTPResponseSerializer serializer];
        [manager.reachabilityManager startMonitoring];
    });
    return manager;
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                            completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler{
    void (^errorProcessBlock)(NSURLResponse *, id, NSError *) = ^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSLog(@"NSHTTPCookieStorage COOKIE %@ ",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
        NSLog(@"AF response headers %@ ",request.allHTTPHeaderFields);
        
        NSError *processError = error;
        if ([error.domain isEqualToString:NSURLErrorDomain]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            });
            NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
            userInfo[NSLocalizedDescriptionKey] = ApiErrorMsgResponseParseError;
            processError = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:userInfo];
        }
       
        completionHandler(response, responseObject, processError);
    };
    
    NSURLSessionDataTask *dataTask =  [super dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:errorProcessBlock];
    return dataTask;
}


@end
