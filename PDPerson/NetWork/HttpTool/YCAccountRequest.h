//
//  YCAccount.h
//  Yacht
//
//  Created by Jonphy on 2019/3/11.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseRequest.h"


NS_ASSUME_NONNULL_BEGIN

@interface YCAccountRequest : JHBaseRequest

/**
 发送手机验证码

 @param mobile string 手机号
 @param type string 验证码用途:register,reset,forget,other=>目前登录使用这个字段
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)authCodeWithMobile:(NSString *)mobile useType:(NSString *)type
                                 success:(JHNetworkRequestSuccessVoid)success
                                 failure:(JHNetworkRequestFailure)failure;

/**
 手机验证码登录

 @param mobile string 手机号
 @param code string 验证码
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)loginWithMobile:(nonnull NSString *)mobile
                                     code:(nonnull NSString *)code
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure;

/**
 用户登录信息

 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)currentUser:(nonnull JHNetworkRequestSuccessArray)success
                              failure:(nonnull JHNetworkRequestFailure)failure;

/**
 密码登录

 @param mobile string 手机号
 @param password string 验证码
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)loginWithMobile:(nonnull NSString *)mobile
                                 password:(nonnull NSString *)password
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure;

//QQ登录
- (NSURLSessionDataTask *)loginWithQQ:(nonnull NSString *)openId
                             nickname:(nonnull NSString *)nickname
                               avatar:(nonnull NSString *)avatar
                              success:(nonnull JHNetworkRequestSuccessVoid)success
                              failure:(nonnull JHNetworkRequestFailure)failure;

//微信登录
- (NSURLSessionDataTask *)loginWithWechat:(nonnull NSString *)openId
                                 nickname:(nonnull NSString *)nickname
                                   avatar:(nonnull NSString *)avatar
                                  unionId:(nonnull NSString *)unionId
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure;

//绑定微信
- (NSURLSessionDataTask *)bindWithWechat:(nonnull NSString *)openId
                                nickname:(nonnull NSString *)nickname
                                 unionId:(nonnull NSString *)unionId
                                 success:(nonnull JHNetworkRequestSuccessVoid)success
                                 failure:(nonnull JHNetworkRequestFailure)failure;
/**
 验证用户是否有密码

 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)requestPasswordExistSuccess:(nonnull JHNetworkRequestSuccessVoid)success
                                              failure:(nonnull JHNetworkRequestFailure)failure;

//验证旧密码
- (NSURLSessionDataTask *)updateOldPassword:(nonnull NSString *)oldPassword
                                    success:(nonnull JHNetworkRequestSuccessVoid)success
                                    failure:(nonnull JHNetworkRequestFailure)failure;

/**
 个人设置绑定手机邮箱验证身份

 @param account string 手机号/邮箱
 @param code string 验证码
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)settingConfirmIdentity:(nonnull NSString *)account
                                            code:(nonnull NSString *)code
                                         success:(nonnull JHNetworkRequestSuccessVoid)success
                                         failure:(nonnull JHNetworkRequestFailure)failure;


- (NSURLSessionDataTask *)logoutSuccess:(nonnull JHNetworkRequestSuccessVoid)success
                                failure:(nonnull JHNetworkRequestFailure)failure;


/**
 获取交易明细列表

 @param parameters
    per_page integer 每页条数
    page integer 第几页
 */
- (NSURLSessionDataTask *)getTransactionsWithParameters:(NSDictionary *)parameters
                                                success:(void (^)(NSArray *transactions, NSString *message))success
                                                failuer:(JHNetworkRequestFailure)failure;

/**
 获取我的优惠券

 @param parameters
    status integer 状态 0=>所有 1=>未使用 2=>已使用 3=>已失效
 */
- (NSURLSessionDataTask *)getMyCouponWithParameters:(NSDictionary *)parameters
                                            success:(void (^)(NSArray *coupons, NSString *message))success
                                            failure:(JHNetworkRequestFailure)failure;

/**
 获取我的消息

 @param parameters
    status string 0=>所有 1=>未读 2=>已读
 */
- (NSURLSessionDataTask *)getMyMessageWithParameters:(NSDictionary *)parameters
                                             success:(void (^)(NSArray *messages, NSString *msg))success
                                             failure:(JHNetworkRequestFailure)failure;


/**
 验证身份

 @param account 手机号或邮箱
 @param code 验证码
 */
- (NSURLSessionDataTask *)confirmIdentity:(nonnull NSString *)account
                                     code:(nonnull NSString *)code
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure;

/**
 修改用户资料

 @param parameters
    email string 邮箱
    mobile integer 手机
    password integer 密码
    avatar string 头像
    sex string 性别 female=>女性，male=>男性
    nickname string 昵称
    bank_account string 银行账户
    account_name string 开户姓名
    bank_name string 银行名称
    open_bank string 开户行
 */
- (NSURLSessionDataTask *)modifyUserInfoWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessVoid)success failure:(JHNetworkRequestFailure)failure;

/**
 发送邮箱验证码

 @param email 邮箱
 @param type 验证码用途:register,reset,forget,other=>目前登录使用这个字段
 */
- (NSURLSessionTask *)authCodeWithEmail:(nonnull NSString *)email
                                useType:(nonnull NSString *)type
                                success:(nonnull JHNetworkRequestSuccessVoid)success
                                failure:(nonnull JHNetworkRequestFailure)failure;

@end

NS_ASSUME_NONNULL_END
