//
//  URLString.m
//  AnYue
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PDRequestURL.h"

@implementation PDRequestURL


+(NSString *)URL_WithAPICategory:(APICategory)category{
    
    switch (category) {
        case APICategoryUserLogin:
            return [NSString stringWithFormat:@"%@/app/login",currentBaseURL];;
            break;
        case APICategoryUserRegister:
            return [NSString stringWithFormat:@"%@/app/register",currentBaseURL];;
            break;
        
        default:
            return @"";
            break;
    }
    
}


@end
