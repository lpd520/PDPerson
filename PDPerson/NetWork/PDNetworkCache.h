//
//  PDNetworkCache.h
//  PDPerson
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 QingYe. All rights reserved.

// - 网络数据 缓存类


#import <Foundation/Foundation.h>

@interface PDNetworkCache : NSObject


/**
 *  异步缓存（异步）
 *
 *  @param httpData   服务器返回的数据
 *  @param URL        请求的URL地址
 *  @param parameters 请求的参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters;



/**
 *  取出 缓存数据（同步）
 *
 *  @param URL        请求的URL
 *  @param parameters 请求的参数
 *
 *  @return 缓存的服务器数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;


/**
 *  取出 缓存数据（异步）
 *
 *  @param URL        请求的URL
 *  @param parameters 请求的参数
 *  @param block      异步回调缓存的数据
 */
+ (void)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters withBlock:(void(^)(id<NSCoding> object))block;


/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;


/**
 *  删除所有网络缓存
 */
+ (void)removeAllHttpCache;

@end
