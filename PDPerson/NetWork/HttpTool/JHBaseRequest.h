//
//  POBaseRequest.h
//  Yacht
//
//  Created by Jonphy on 2018/11/8.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JHNetworkConstant.h"
//#import "POModelMapper.h"

typedef void (^JHNetworkRequestSuccessArray)(NSArray *modelList, NSString *message);
typedef void (^JHNetworkRequestSuccessContent)(NSString *content,NSString *message);
typedef void (^JHNetworkRequestSuccessVoid)(NSString *message);
typedef void (^JHNetworkRequestFailure)(NSError *error);
typedef void (^JHNetworkSessionSuccess)(NSURLSessionDataTask * task, id responseObject);
typedef void (^JHNetworkSessionFailure)(NSURLSessionDataTask * task, NSError * error);



@interface JHBaseRequest : NSObject

@property (nonatomic, assign) BOOL cacheData;


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                 downProgress:(void (^)(NSProgress *progress))downProgress
                      success:(JHNetworkSessionSuccess)success
                      failure:(JHNetworkSessionFailure)failure ;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                  downProgress:(void (^)(NSProgress *progress))downProgress
                       success:(JHNetworkSessionSuccess)success
                       failure:(JHNetworkSessionFailure)failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                  downProgress:(void (^)(NSProgress *progress))downProgress
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(JHNetworkSessionSuccess)success
                       failure:(JHNetworkSessionFailure)failure;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                            parameters:(id)parameters
                               success:(JHNetworkSessionSuccess)success
                               failure:(JHNetworkSessionFailure)failure;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                               parameters:(id)parameters
                                  success:(JHNetworkSessionSuccess)success
                                  failure:(JHNetworkSessionSuccess)failure;

@end
