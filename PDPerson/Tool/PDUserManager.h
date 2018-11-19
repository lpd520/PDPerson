//
//  PDUserManager.h
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, PDUserLoginStatus) {
    //未登录
    PDUserLoginStatusLogout = 0 ,
    //登录并激活
    PDUserLoginStatusLoginActive,
    //已登录未激活(自动登录下)
    //PDUserLoginStatusLoginUnActive,
};


@class PDUserModel;
@interface PDUserManager : NSObject
SINGLETON_FOR_HEADER(PDUserManager)


/**
 *  当前登录用户
 */
@property (nonatomic,strong) PDUserModel *currentUser;


#pragma mark - getter
+ (PDUserModel *)currentUser;

+(NSString *)currentUserPhone;


/**
 *  用户登录
 */
+ (void)userLogin;
/**
 *  用户注册
 */
+ (void)userRegister;

/**
 *  删除本地记录的登录用户
 *
 *  @param user 要删除的用户模型
 */
+ (void)removeUserLoginRecord:(PDUserModel*)user;




@end
