//
//  APIManager.m
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "APIManager.h"
#import "PDNetworking.h"

@implementation APIManager

+(void)GET_Request:(NSString *)url Param:(NSMutableDictionary *)param Result:(PDResultHelper)resultHelper{
    
    [[PDNetworking sharedInstance] GET_WithURLString:url parameters:param success:^(id responseObject) {
        
        NSInteger success = [responseObject[@"code"] integerValue]==0?0:1;
        
        !resultHelper?:resultHelper(success,responseObject,responseObject[@"msg"]);
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)POST_Request:(NSString *)url Param:(NSMutableDictionary *)param Result:(PDResultHelper)resultHelper{
    
    [[PDNetworking sharedInstance] POST_WithURLString:url parameters:param success:^(id responseObject) {
        
        NSInteger success = [responseObject[@"code"] integerValue]==0?0:1;
        
        !resultHelper?:resultHelper(success,responseObject,responseObject[@"msg"]);
        
        
    } failure:^(NSError *error) {
        
    }];
    
}



@end
