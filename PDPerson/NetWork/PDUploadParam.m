//
//  PDUploadParam.m
//  PDPerson
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDUploadParam.h"

@implementation PDUploadParam


-(instancetype)initWithImage:(UIImage *)img Type:(PDUploadQuantityCategory)type{
    
    if (self = [super init]) {
        
        _name = type==PDUploadQuantityCategorySingle?@"file":@"files";
        
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
    
    return [NSString stringWithFormat:@"%@_%d.png",str,123123];
}



@end
