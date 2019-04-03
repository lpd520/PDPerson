//
//  YCPackageRequest.m
//  Yacht
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "YCPackageRequest.h"
#import "JHModelMapper.h"
#import "YCMealSon.h"
#import "YCOrderComment.h"
#import "JHDateConvertion.h"
#import "YCMealSonAvailableTime.h"

@implementation YCPackageRequest

- (NSURLSessionDataTask *)getMealSonsWithParameters:(NSDictionary *)parameters
                                            success:(nonnull JHNetworkRequestSuccessArray)success
                                            failure:(nonnull JHNetworkRequestFailure)failure {
    
    NSString *path = @"custom-set-meal-sons";
    return [self GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *datas = dic[@"data"];
        NSArray *mealSons = [JHModelMapper modelArrayWithJsonArray:datas modelClass:[YCMealSon class]];
        NSString *msg = @"获取小套餐成功";
        success(mealSons, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getMealSonDetailWithMealSonId:(NSUInteger)mealSonId
                                          date:(NSString *)date
                                       success:(JHNetworkRequestSuccessArray)success
                                       failure:(JHNetworkRequestFailure)failure {
    
    NSString *path = [NSString stringWithFormat:@"custom-set-meal-sons/%lu", (unsigned long)mealSonId];
    NSDictionary *parameters = @{@"date":date?:@""};
    return [self GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSDictionary *mealSonDic = dic[@"data"];
        YCMealSon *mealSon = [JHModelMapper modelWithDictionary:mealSonDic modelClass:[YCMealSon class]];
        NSString *msg = @"获取套餐详情成功";
        success(@[mealSon], msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getWharfsInfoSuccess:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure {
    NSString *path = @"wharfs";
    return [self GET:path parameters:nil downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *wharfsDatas = dic[@"data"];
        NSArray *wharfs = [JHModelMapper modelArrayWithJsonArray:wharfsDatas modelClass:[YCWharf class]];
        NSString *msg = @"获取码头信息成功";
        success(wharfs, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
    
}

- (NSURLSessionDataTask *)getPackageCommentsWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure {
    NSString *path = @"custom-order-comments";
    return [self GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *totalComments = [NSString stringWithFormat:@"%@", dic[@"meta"][@"total"]];
        NSArray *data = dic[ApiResponseKeyData];
        NSArray *modelist = [JHModelMapper modelArrayWithJsonArray:data modelClass:[YCOrderComment class]];
        success(modelist, totalComments);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getSubPackagesWithMealId:(NSUInteger)mealId date:(NSDate *)date success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure {
    
    NSString *path = @"custom-set-meal-sons-select";
    NSString *dateStr = [JHDateConvertion stringWithDate:date format:@"yyyy-MM-dd"];
    NSDictionary *parameters = @{@"custom_set_meal_id":@(mealId), @"date":dateStr};
    return  [super GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *data = dic[ApiResponseKeyData];
        NSArray *modelList = [JHModelMapper modelArrayWithJsonArray:data modelClass:[YCMealSon class]];
        NSString *msg = @"获取套餐选择器成功";
        success(modelList, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getPackageAvailableTimeWithMealSonId:(NSUInteger)mealSonId date:(NSDate *)date success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure {
    
    NSString *path =@"custom-set-meal-sons-order-time-check";
    NSString *dateStr = [JHDateConvertion stringWithDate:date format:@"yyyy-MM-dd"];
    NSDictionary *parameters = @{@"custom_set_meal_son_id":@(mealSonId), @"date":dateStr};
    return [super GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSDictionary *data = dic[ApiResponseKeyData];
        YCMealSonAvailableTime *time = [JHModelMapper modelWithDictionary:data modelClass:[YCMealSonAvailableTime class]];
        NSString *msg = @"获取可选时间成功";
        success(@[time], msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

@end
