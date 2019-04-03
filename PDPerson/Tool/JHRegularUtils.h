//
//  JHRegularUtils.h
//  Yacht
//  正则表达式集成
//  Created by apple on 2019/1/11.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHRegularUtils : NSObject

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard;

#pragma 正则匹配验证码为4位数字
+ (BOOL)checkUserCode:(NSString *)Code;

#pragma 邮箱验证
/**
 *  @param email 邮箱
 *  @return YES:正确  NO:失败
 */
+ (BOOL)checkForEmail:(NSString *)email;

#pragma 校验只能输入数字
/**
 *  @param number 数字
 *  @return 结果
 */
+ (BOOL)checkForNumber:(NSString *)number;

#pragma 校验只能输入n位的数字
/**
 *  @param length n位
 *  @param number 数字
 *  @return 结果
 */
+ (BOOL)checkForNumberWithLength:(NSString *)length number:(NSString *)number;

#pragma 电话号验证
/**
 *  @param phone 电话号
 *  @return 结果
 */
+(BOOL)checkForPhoneNo:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
