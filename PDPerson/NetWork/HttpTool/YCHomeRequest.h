//
//  YCHomeRequest.h
//  Yacht
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseRequest.h"

@interface YCHomeRequest : JHBaseRequest

/**
 获取banners

 @param parameters 参数字典
    position string index首页 travel_note游记 article=>资讯 wap=>wap
    per_page integer 每页条数

 */
- (NSURLSessionDataTask *)getBannersWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure;

@end
