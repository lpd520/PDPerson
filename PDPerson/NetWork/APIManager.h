//
//  APIManager.h
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+(void)GET_Request:(NSString *)url Param:(NSMutableDictionary *)param Result:(PDResultHelper)resultHelper;


+(void)POST_Request:(NSString *)url Param:(NSMutableDictionary *)param Result:(PDResultHelper)resultHelper;

@end
