//
//  PDUploadParam.h
//  PDPerson
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 QingYe. All rights reserved.

// 上传接口 参数类

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,PDUploadQuantityCategory){
    PDUploadQuantityCategorySingle = 0,   // 单张 上传
    PDUploadQuantityCategoryMulti        //  多张 上传
    
} ;


@interface PDUploadParam : NSObject

/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;


//-(instancetype)initWithName:(NSString *)name FileName:(NSString *)fileName Type:(NSString *)type;
-(instancetype)initWithImage:(UIImage *)img Type:(PDUploadQuantityCategory)type;




@end
