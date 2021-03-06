//
//  PDTimer.m
//  PDPerson
//
//  Created by mac on 2018/11/15.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDTimer.h"



@implementation PDTimer

static NSMutableDictionary *timers_;   //存放定时器 arr
dispatch_semaphore_t semaphore_;   // 信号量 控制线程并发访问的最大数量 


+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}


+ (NSString *)execTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async{
    
    if (!task || start < 0 || (interval <= 0 && repeats))
        return nil;
    
    // 队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置时间
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC, 0);
    
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    // 定时器的唯一标识
    NSString *name = [NSString stringWithFormat:@"%zd", timers_.count];
    // 存放到字典中
    timers_[name] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        
        if (!repeats) { // 不重复的任务
            [self cancelTask:name];
        }
    });
    
    // 启动定时器
    dispatch_resume(timer);
    
    return name;
}


+ (NSString *)execTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async{
    
    if (!target || !selector)
        return nil;
    
    return [self execTask:^{
        
        if ([target respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
}


+ (void)cancelTask:(NSString *)name{
    if (name.length == 0)
        return;
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = timers_[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:name];
    }
    
    dispatch_semaphore_signal(semaphore_);
}



// 外界调用
/*
 1.
self.task = [Timer execTask:self
                   selector:@selector(doTask)
                      start:2.0
                   interval:1.0
                    repeats:YES
                      async:NO];

 2.
self.task = [Timer execTask:^{
    
    NSLog(@"111111 - %@", [NSThread currentThread]);
    
} start:2.0 interval:-10 repeats:NO async:NO];
*/


@end
