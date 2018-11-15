//
//  NSString+PD.h
//  AnYue
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PD)


/**
 * 判断字符串是否 空
 */
-(BOOL)isNull;

/**
 * 判断字符串是否 包含汉字
 */
-(BOOL)isHasChinese;

/**
 * 从字符串中 取得URL
 */
+ (NSArray*)getURLFromString:(NSString *)string ;

/**
 * 删除字符串中的空格
 */
-(void)deleteAllSpace;

/**
 * 汉字编码
 */
+(NSString *)decodeHasChineseWithStr:(NSString *)str;


/**
 * 判断字符串是否是 电话号码
 */
+(BOOL)checkForMobilePhoneYES:(NSString *)mobilePhone;


/**
 * 判断字符串是否是 Email地址
 */
+(BOOL)checkForEmailYES:(NSString *)email;


@end
