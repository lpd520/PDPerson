//
//  PDNetworking.h
//  PDPerson
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDUploadParam;

/**
 *  网络请求 类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    
    HttpRequestType_GET = 0,
    HttpRequestType_POST
};

/**
 *  请求数据 格式
 */
typedef NS_ENUM(NSUInteger, PDRequestSerializer) {
    /** JSON格式*/
    PDRequestSerializer_JSON = 0,
    /** 二进制格式*/
    PDRequestSerializer_HTTP,
};

/**
 *  响应数据 格式
 */
typedef NS_ENUM(NSUInteger, PDResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    PDResponseSerializer_JSON = 0,
    /** 设置响应数据为二进制格式*/
    PDResponseSerializer_HTTP,
};


@interface PDNetworking : NSObject



+ (instancetype)sharedInstance;  // 单例

/**
 *  发送GET请求
 *
 *  @param URLString  请求网址字符串
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)GET_WithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  发送POST请求
 *
 *  @param URLString  请求网址字符串
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)POST_WithURLString:(NSString *)URLString
                parameters:(id)parameters
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求网址字符串
 *  @param parameters  请求参数
 *  @param type        请求的类型
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)httpRequestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString    上传图片的网址字符串
 *  @param parameters   上传图片的参数
 *  @param uploadParams 上传图片的信息
 *  @param success      成功回调
 *  @param failure      失败回调
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray <PDUploadParam *> *)uploadParams
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;


/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param parameters  下载数据的参数
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)downLoadWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                     progerss:(void (^)(void))progress
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;


#pragma mark - setter
/**
 *  设置 网络请求参数的格式:默认为JSON格式
 */
+ (void)setRequestSerializer:(PDRequestSerializer)requestSerializer;

/**
 *  设置 服务器响应数据格式:默认为JSON格式
 */
+ (void)setResponseSerializer:(PDResponseSerializer)responseSerializer;

/**
 *  设置 最大响应时间:默认为15s
 */
- (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

@end
