//
//  PDUserManager.m
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDUserManager.h"
#import "PDUserModel.h"
#import "APIManager.h"

@implementation PDUserManager
SINGLETON_FOR_CLASS(PDUserManager)

+ (PDUserModel *)currentUser {
    return [self sharedPDUserManager].currentUser;
}

+(NSString *)currentUserPhone{
    return [self currentUser].mobile;
}

+(void)userLogin{
    
    [APIManager POST_Request:@"" Param:nil Result:^(NSInteger code, id result, NSString *message) {
    
        if (code==0) {
            
            [PDUserModel modelObjectFromJSON:result];
            
        }
        
    }];
    
}

+(void)removeUserLoginRecord:(PDUserModel *)user{
    
}

@end
