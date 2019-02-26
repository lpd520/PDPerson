//
//  PDUploadParam.m
//  PDPerson
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDUploadParam.h"


#define kRandomNumber arc4random() % 1000

@implementation PDUploadParam
 
-(instancetype)initWithImage:(UIImage *)img Type:(PDUploadQuantityCategory)type{
    
    if (self = [super init]) {
        
        _name = type == PDUploadQuantityCategorySingle?@"file":@"files";
        
        _mimeType = @"image/png";
        
        _filename = [self creatFileName];
        
//        _data = UIImagePNGRepresentation(img);
        _data =UIImageJPEGRepresentation(img, 0.1);
    }
    return self;
}

-(NSString *)creatFileName{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    return  [NSString stringWithFormat:@"%@_%d.png",str,kRandomNumber];
}

@end


/*
NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

PDUploadParam *pm = [[PDUploadParam alloc] initWithImage:[UIImage imageNamed:@"good"] Type:PDUploadQuantityCategoryMulti];
[arr addObject:pm];
PDUploadParam *pm1 = [[PDUploadParam alloc] initWithImage:[UIImage imageNamed:@"home_BG"] Type:PDUploadQuantityCategoryMulti];
[arr addObject:pm1];
PDUploadParam *pm2 = [[PDUploadParam alloc] initWithImage:[UIImage imageNamed:@"code2d_test"] Type:PDUploadQuantityCategoryMulti];
[arr addObject:pm2];

[[PDNetworking sharedInstance] uploadWithURLString:[PDRequestURL URL_WithAPICategory:APICategoryUploadMulitePictrues] parameters:nil uploadParam:arr success:^(id responseObject) {
    
    PDLog(@"%@",responseObject[@"data"]);  // 返回url，多张时 有 , 号隔开
    
} failure:^(NSError *error) {
    
    }];
 
*/
