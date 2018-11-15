//
//  URLString.h
//  AnYue
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, APICategory) {
    
    APICategoryUserLogin = 0,
    APICategoryUserRegister,
    
    //...

};

@interface PDRequestURL : NSObject


+(NSString *)URL_WithAPICategory:(APICategory)category;


@end
