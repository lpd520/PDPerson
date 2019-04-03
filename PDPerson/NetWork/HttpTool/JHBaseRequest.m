
//
//  POBaseRequest.m
//  Yacht
//
//  Created by Jonphy on 2018/11/8.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseRequest.h"
#import "JHHTTPSessionManager.h"
#import "SVProgressHUD.h"
#import "JHNetworkConstant.h"
#import "JHCacheManager.h"
#import "YCAccountManager.h"
//#import "RSAUtil.h"
//#import "CRSA.h"
//#import "MJRefresh.h"

@interface JHBaseRequest ()
{
    NSString* AES_KEY;
}

@end

@implementation JHBaseRequest

- (void)setHeaderToken {
    if(![[YCAccountManager shared] isLogin]) {
        return;
    };
    NSString *token = [YCAccountManager shared].token;
    [[JHHTTPSessionManager shareManager].requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                 downProgress:(void (^)(NSProgress *progress))downProgress
                      success:(JHNetworkSessionSuccess)success
                      failure:(JHNetworkSessionFailure)failure{
    
    NSMutableDictionary *dic = parameters;
    
    NSString *absoluteURLString = [NSString stringWithFormat:@"%@%@",[JHHTTPSessionManager shareManager].baseURL.absoluteString,URLString];
    for (NSString *key in dic.allKeys) {
        if (![absoluteURLString containsString:@"?"]) {
            absoluteURLString = [absoluteURLString stringByAppendingString:@"?"];
        }
        NSString *value = dic[key];
        NSString *query = [NSString stringWithFormat:@"%@=%@",key,value];
        absoluteURLString = [absoluteURLString stringByAppendingString:query];
    }
    
    if ([[JHCacheManager sharedInstance] diskCacheExistsWithKey:absoluteURLString]) {
        [[JHCacheManager sharedInstance] getCacheDataForKey:absoluteURLString value:^(NSData * _Nonnull data, NSString * _Nonnull filePath) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success(nil,dic);
        }];
    }
    
    [self setHeaderToken];
    return [[JHHTTPSessionManager shareManager] GET:URLString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self->_cacheData) {
            
            NSString *key = task.response.URL.absoluteString;
            [[JHCacheManager sharedInstance] storeContent:responseObject forKey:key isSuccess:^(BOOL isSuccess) {
                
            }];
        }
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(task,error);
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                  downProgress:(void (^)(NSProgress *progress))downProgress
                       success:(JHNetworkSessionSuccess)success
                       failure:(JHNetworkSessionFailure)failure{
    
    
    NSMutableDictionary *dic = parameters;
    
    NSString *absoluteURLString = [NSString stringWithFormat:@"%@%@",[JHHTTPSessionManager shareManager].baseURL.absoluteString,URLString];
    for (NSString *key in dic.allKeys) {
        if (![absoluteURLString containsString:@"?"]) {
            absoluteURLString = [absoluteURLString stringByAppendingString:@"?"];
        }
        NSString *value = dic[key];
        NSString *query = [NSString stringWithFormat:@"%@=%@",key,value];
        absoluteURLString = [absoluteURLString stringByAppendingString:query];
    }
    
    if ([[JHCacheManager sharedInstance] diskCacheExistsWithKey:absoluteURLString]) {
        [[JHCacheManager sharedInstance] getCacheDataForKey:absoluteURLString value:^(NSData * _Nonnull data, NSString * _Nonnull filePath) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success(nil,dic);
        }];
    }

    [self setHeaderToken];
    return [[JHHTTPSessionManager shareManager] POST:URLString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (self->_cacheData) {
            
            [[JHCacheManager sharedInstance] storeContent:responseObject forKey:absoluteURLString isSuccess:^(BOOL isSuccess) {
                
            }];
        }
        success(task,responseObject);
        DLog(@"successResponse");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
        DLog(@"failureResponse");
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                  downProgress:(void (^)(NSProgress *progress))downProgress
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(JHNetworkSessionSuccess)success
                       failure:(JHNetworkSessionFailure)failure{

    [self setHeaderToken];
    return [[JHHTTPSessionManager shareManager] POST:URLString parameters:parameters constructingBodyWithBlock:block progress:downProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters success:(JHNetworkSessionSuccess)success failure:(JHNetworkSessionSuccess)failure{
    
    [self setHeaderToken];
    return [[JHHTTPSessionManager shareManager] DELETE:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters success:(JHNetworkSessionSuccess)success failure:(JHNetworkSessionFailure)failure{
    
    [self setHeaderToken];
    return [[JHHTTPSessionManager shareManager] PUT:URLString parameters:parameters success:success failure:failure];
}

@end
