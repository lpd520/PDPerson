//
//  PDCashes.h
//  AnYue
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDCachesManager : NSObject


/**
 *  获取缓存大小
 */
+ (NSString *)getCachesSize;


/**
 *  清理缓存
 */
+ (void)removeCache;


@end
