//
//  PDBaseModel.m
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDBaseModel.h"
#import <MJExtension.h>

@implementation PDBaseModel

+(id)modelObjectFromJSON:(id)json {
    
    return  [[self class] mj_objectWithKeyValues:json];
    
}

+(void)replacePropertyName:(NSString *)oldName With:(NSString *)newsName{
    
    [[self class] mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{newsName : oldName};
    }];
}

+(void)setupClassInArray:(NSString *)arrayName Model:(NSString *)modelName {
    
    [[self class] mj_setupObjectClassInArray:^NSDictionary *{
        return @{arrayName : modelName};
    }];
}

@end
