//
//  PDReachability.h
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDReachability : NSObject

+(void)checkNetworkStatusOn:(void (^)(NSString * status))CallBack;


@end
