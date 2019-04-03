//
//  YCHomeRequest.m
//  Yacht
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "YCHomeRequest.h"
#import "JHModelMapper.h"
#import "YCBanner.h"
@implementation YCHomeRequest

- (NSURLSessionDataTask *)getBannersWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure {
    NSString *path = @"banners";
    return [super GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *data = dic[ApiResponseKeyData];
        NSArray *modelList = [JHModelMapper modelArrayWithJsonArray:data modelClass:[YCBanner class]];
        NSString *msg = @"获取Banners成功";
        success(modelList, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
    
}

@end
