//
//  PDTimer.h
//  PDPerson
//
//  Created by mac on 2018/11/15.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDTimer : NSObject

/**
 * 执行定时任务
 */
+ (NSString *)execTask:(void(^)(void))task
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;


+ (NSString *)execTask:(id)target
              selector:(SEL)selector
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;


/**
 * 取消任务
 */
+ (void)cancelTask:(NSString *)name;




@end
