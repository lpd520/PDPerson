//
//  PDBaseModel.h
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.

// 所有建立的模型 都继承这个类

#import <Foundation/Foundation.h>

@interface PDBaseModel : NSObject

/**
 *  JSON转 模型对象
 */
+(id)modelObjectFromJSON:(id)json ;

/**
 *  声明数组中的模型
 */
+(void)setupClassInArray:(NSString *)arrayName Model:(NSString *)modelName ;
/**
 *  属性名替换
 */
+(void)replacePropertyName:(NSString *)oldName With:(NSString *)newsName;


@end
