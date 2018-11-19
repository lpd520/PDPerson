//
//  PDNetworking.m
//  PDPerson
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDNetworking.h"
#import "PDUploadParam.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>


@interface PDNetworking ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;  // 网络管理者

@end





@implementation PDNetworking

static PDNetworking *_instance = nil;

+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        
    });
    return _instance;
}


#pragma mark -- GET请求
- (void)GET_WithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [self.manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

#pragma mark -- POST请求 --
- (void)POST_WithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [self.manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


#pragma mark -- POST/GET网络请求
- (void)httpRequestWithURLString:(NSString *)URLString parameters:(id)parameters type:(HttpRequestType)type success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    switch (type) {
        case HttpRequestType_GET:{
            
            [self.manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestType_POST:{
            
            [self.manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
}


#pragma mark -- 上传
-(void)uploadWithURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(NSArray<PDUploadParam *> *)uploadParams success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [self.manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (PDUploadParam *uploadParam in uploadParams) {
            
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


#pragma mark - 下载数据
- (void)downLoadWithURLString:(NSString *)URLString parameters:(id)parameters progerss:(void (^)(void))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress();
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return targetPath;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (failure) {
            failure(error);
        }
    }];
    // 开始任务
    [downLoadTask resume];
    
}


#pragma mark - getter

-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        // 可以接受的类型
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//      _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
//      _manager.requestSerializer = [AFJSONRequestSerializer serializer];

        // 请求队列的最大并发数
        _manager.operationQueue.maxConcurrentOperationCount = 5;
        // 请求超时的时间
        _manager.requestSerializer.timeoutInterval = 15;
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil];
        // 请求头
//        [_manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];

//        AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
//        [policy setAllowInvalidCertificates:YES];    // 如果是需要验证自建证书，需要设置为YES
//        policy.validatesDomainName = NO;             //不验证证书的域名
//        [_manager setSecurityPolicy:policy];

        // 打开状态栏的等待菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return _manager;
}


#pragma mark - 重置AFHTTPSessionManager相关属性
- (void)setRequestSerializer:(PDRequestSerializer)requestSerializer{
    _manager.requestSerializer = requestSerializer == PDRequestSerializer_HTTP
    ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

- (void)setResponseSerializer:(PDResponseSerializer)responseSerializer{
    _manager.responseSerializer = responseSerializer == PDResponseSerializer_HTTP
    ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

- (void)setRequestTimeoutInterval:(NSTimeInterval)time{
    _manager.requestSerializer.timeoutInterval = time;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field{
    
    [_manager.requestSerializer setValue:value forHTTPHeaderField:field];
}

@end
