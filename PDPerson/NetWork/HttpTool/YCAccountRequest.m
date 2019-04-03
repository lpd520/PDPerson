//
//  YCAccount.m
//  Yacht
//
//  Created by Jonphy on 2019/3/11.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "YCAccountRequest.h"
#import "JHToastManager.h"
#import "JHLocalManager.h"
#import "YCAccountManager.h"
#import "NSString+YCExt.h"
#import "YCUser.h"
#import "JHModelMapper.h"
#import "YCTransaction.h"
#import "YCCoupon.h"
#import "YCMessage.h"

@implementation YCAccountRequest

- (void)dealLoginTokenWithResult:(NSDictionary *)result failure:(nonnull JHNetworkRequestFailure)failure {
    NSString *tokenSubfix = result[@"data"][@"token"];
    if(![tokenSubfix isExist]) {
        NSError *error = [[NSError alloc] initWithDomain:@"token 不存在" code:9999 userInfo:nil];
        failure(error);
        return;
    }
    NSString *token = [NSString stringWithFormat:@"Bearer %@", result[@"data"][@"token"]];
    [[YCAccountManager shared] setToken:token];
}

- (void)dealUserInfoWith:(YCUser *)user failure:(JHNetworkRequestFailure)failure {
    if (!user) {
        NSError *error = [[NSError alloc] initWithDomain:@"用户信息不存在" code:9999 userInfo:nil];
        failure(error);
        return;
    }
    [[YCAccountManager shared] setUser:user];
}

- (NSURLSessionTask *)authCodeWithMobile:(nonnull NSString *)mobile useType:(nonnull NSString *)type success:(nonnull JHNetworkRequestSuccessVoid)success failure:(nonnull JHNetworkRequestFailure)failure{
    
    NSString *path = @"code/sendMobileCode";
    NSDictionary *parameters = @{@"mobile":mobile,@"type":type};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionTask *)authCodeWithEmail:(nonnull NSString *)email
                                useType:(nonnull NSString *)type
                                success:(nonnull JHNetworkRequestSuccessVoid)success
                                failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"code/sendEmailCode";
    NSDictionary *parameters = @{@"email":email, @"type":type};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)loginWithMobile:(nonnull NSString *)mobile
                                     code:(nonnull NSString *)code
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/phone-code-login";
    NSDictionary *parameters = @{@"account":mobile, @"code":code};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        [self dealLoginTokenWithResult:dic failure:failure];//处理登录Token
        //获取用户信息
        [self currentUser:^(NSArray *modelList, NSString *message) {
            
        } failure:^(NSError *error) {
            
        }];
        success(msg);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)makeCaptchaSuccess:(nonnull JHNetworkRequestSuccessContent)success
                                     failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"code/make_captcha";
    return [self GET:path parameters:nil downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject[ApiResponseKeyMsg];
        NSString *captchaKey = dic[@"captcha_key"];
        NSString *code = dic[@"code"];
        success(captchaKey, code);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)loginWithMobile:(nonnull NSString *)mobile
                                 password:(nonnull NSString *)password
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/password-login";
    return [self makeCaptchaSuccess:^(NSString *captchaKey, NSString *code) {
        
        NSDictionary *parameters = @{@"account":mobile, @"code":code, @"captcha_key":captchaKey, @"password":password};
        [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {

            NSDictionary *dic = responseObject;
            NSString *msg = dic[ApiResponseKeyMsg];
            [JHToastManager showSuccessWithStatus:msg duration:2.0];
            [self dealLoginTokenWithResult:dic failure:failure];//处理登录Token
            //获取用户信息
            [self currentUser:^(NSArray *modelList, NSString *message) {
                
            } failure:^(NSError *error) {
                
            }];
            success(msg);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {

            failure(error);
        }];
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)loginWithQQ:(nonnull NSString *)openId
                             nickname:(nonnull NSString *)nickname
                               avatar:(nonnull NSString *)avatar
                              success:(nonnull JHNetworkRequestSuccessVoid)success
                              failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/qq-login";
    NSDictionary *parameters = @{@"open_id":openId, @"nickname":nickname, @"avatar":avatar};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)loginWithWechat:(nonnull NSString *)openId
                                 nickname:(nonnull NSString *)nickname
                                   avatar:(nonnull NSString *)avatar
                                  unionId:(nonnull NSString *)unionId
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/wechat-login";
    NSDictionary *parameters = @{@"openid":openId, @"nickname":nickname, @"avatar":avatar, @"unionid":unionId};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)bindWithWechat:(nonnull NSString *)openId
                                nickname:(nonnull NSString *)nickname
                                 unionId:(nonnull NSString *)unionId
                                 success:(nonnull JHNetworkRequestSuccessVoid)success
                                 failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/wechat-bind";
    NSDictionary *parameters = @{@"openid":openId, @"nickname":nickname, @"unionid":unionId};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)loginWithWechatMiniapp:(nonnull NSString *)nickname
                                          avatar:(nonnull NSString *)avatar
                                            code:(nonnull NSString *)code
                                         success:(nonnull JHNetworkRequestSuccessVoid)success
                                         failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/wechat-miniapp-login";
    NSDictionary *parameters = @{@"nickname":nickname, @"avatar":avatar, @"code":code};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)logoutSuccess:(nonnull JHNetworkRequestSuccessVoid)success
                                failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user/logout";
    return [self POST:path parameters:nil downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        [[YCAccountManager shared] setToken:nil];
        [[YCAccountManager shared] setUser:nil];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)confirmIdentity:(nonnull NSString *)account
                                     code:(nonnull NSString *)code
                                  success:(nonnull JHNetworkRequestSuccessVoid)success
                                  failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/confirm-identity";
    NSDictionary *parameters = @{@"account":account, @"code":code};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)settingConfirmIdentity:(nonnull NSString *)account
                                            code:(nonnull NSString *)code
                                         success:(nonnull JHNetworkRequestSuccessVoid)success
                                         failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/setting-confirm-identity";
    NSDictionary *parameters = @{@"account":account, @"code":code};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)updateOldPassword:(nonnull NSString *)oldPassword
                                    success:(nonnull JHNetworkRequestSuccessVoid)success
                                    failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/update_old_password";
    NSDictionary *parameters = @{@"old_password":oldPassword ?: @""};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)updatePassword:(nonnull NSString *)password
                         confirmPassword:(nonnull NSString *)confirmPassword
                              forAccount:(nonnull NSString *)account
                                    code:(nonnull NSString *)code
                                 success:(nonnull JHNetworkRequestSuccessVoid)success
                                 failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user-login/updatePassword";
    NSDictionary *parameters = @{@"password":password, @"confirm_password":confirmPassword, @"account":account, @"code":code};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        [JHToastManager showSuccessWithStatus:msg duration:2.0];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)currentUser:(nonnull JHNetworkRequestSuccessArray)success
                              failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"user/login-status";
    return [self GET:path parameters:nil downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *msg = @"获取用户信息成功";
        NSArray *userData = responseObject[@"data"];
        NSArray *users = (NSArray<YCUser *> *)[JHModelMapper modelArrayWithJsonArray:userData modelClass:[YCUser class]];
        [self dealUserInfoWith:users.firstObject failure:failure];
        success(users, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}


- (NSURLSessionDataTask *)getTransactionsWithParameters:(NSDictionary *)parameters success:(void (^)(NSArray *transactions, NSString *message))success failuer:(JHNetworkRequestFailure)failure {
    NSString *path = @"user/transactions";
    return [super GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *data = dic[ApiResponseKeyData];
        NSArray *transactions = [JHModelMapper modelArrayWithJsonArray:data modelClass:[YCTransaction class]];
        NSString *msg = @"获取交易明细成功";
        success(transactions, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getMyCouponWithParameters:(NSDictionary *)parameters success:(void (^)(NSArray *coupons, NSString *message))success failure:(JHNetworkRequestFailure)failure {
    NSString *path = @"user/coupons";
    return [super GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *data = dic[ApiResponseKeyData];
        NSArray *coupons = [JHModelMapper modelArrayWithJsonArray:data modelClass:[YCCoupon class]];
        NSString *msg = @"获取我的优惠券成功";
        success(coupons, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getMyMessageWithParameters:(NSDictionary *)parameters success:(void (^)(NSArray *messages, NSString *msg))success failure:(JHNetworkRequestFailure)failure {
    NSString *path = @"user/messages";
    return [super GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *data = dic[ApiResponseKeyData];
        NSArray *messages = [JHModelMapper modelArrayWithJsonArray:data modelClass:[YCMessage class]];
        NSString *msg = @"获取消息列表成功";
        success(messages, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)modifyUserInfoWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessVoid)success failure:(JHNetworkRequestFailure)failure {
    
    NSString *path = @"users";
    return [super PUT:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *msg = dic[ApiResponseKeyMsg];
        success(msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
@end
