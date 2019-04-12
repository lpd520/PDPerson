//
//  JHDateConvertion.h
//  Yacht
//
//  Created by Jonphy on 2019/3/5.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHDateConvertion : NSObject

+ (NSString *)dateWithSeconds:(NSUInteger)sec;
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)formatString;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)formatString;
+ (NSDate *)localeDateWithUTCDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
