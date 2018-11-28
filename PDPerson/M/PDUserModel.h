//
//  PDUserModel.h
//  PDPerson
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 QingYe. All rights reserved.
//  单例

#import "PDBaseModel.h"


@interface PDUserModel : PDBaseModel
SINGLETON_FOR_HEADER(PDUserModel)


@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *userId;
//@property (nonatomic,strong) NSString *userName;
//@property (nonatomic,strong) NSString *sex;



@end
