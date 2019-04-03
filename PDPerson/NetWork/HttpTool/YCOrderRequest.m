//
//  YCOrderRequest.m
//  Yacht
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "YCOrderRequest.h"
#import "YCOrder.h"
#import "JHModelMapper.h"
#import "YCCreatedOrder.h"
#import "YCWechatPayParameters.h"
#import "YCAlipayParameters.h"
#import "YCPrePayWechatOrder.h"
#import "YCAccountManager.h"


@implementation YCOrderRequest


- (NSURLSessionDataTask *)getOrdersWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure: (JHNetworkRequestFailure)failure {
    
    NSString *path = @"custom-orders";
//    NSDictionary *parameters = @{@"order_time":@(orderTime),
//                                 @"go_time":@(goTime),
//                                 @"status":@(status),
//                                 @"per_page":@(perPage)
//                                 };
    return [self GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *datas = dic[@"data"];
        NSArray *orders = (NSArray<YCOrder *> *)[JHModelMapper modelArrayWithJsonArray:datas modelClass:[YCOrder class]];
        NSString *msg = @"获取订单成功";
        success(orders, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getOrderDetailWith:(NSUInteger)orderId success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure {
    
    NSString *path = [NSString stringWithFormat:@"custom-orders/%lu", (unsigned long)orderId];
    return [self GET:path parameters:nil downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSDictionary *orderDic = dic[@"data"];
        YCOrder *order = [JHModelMapper modelWithDictionary:orderDic modelClass:[YCOrder class]];
        NSString *msg = @"获取订单详情成功";
        success(@[order], msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getCouponsWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure {
    NSString *path = @"custom-order-coupons";
    return [super GET:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *data = dic[ApiResponseKeyData];
        NSArray *modelList = [JHModelMapper modelArrayWithJsonArray:data modelClass:[YCCoupon class]];
        NSString *msg = @"获取优惠券成功";
        success(modelList, msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)createOrderWithParameters:(NSDictionary *)parameters success:(void (^)(YCCreatedOrder *, NSString *))success failure:(JHNetworkRequestFailure)failure {
    NSString *path = @"custom-orders";
    return [super POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSDictionary *data = dic[ApiResponseKeyData];
        YCCreatedOrder *order = [JHModelMapper modelWithDictionary:data modelClass:[YCCreatedOrder class]];
        NSString *msg = @"创建订单成功";
        success(order,msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getWechatPrePayOrderInfoWithParameters:(YCWechatPayParameters *)parameter success:(void (^)(YCPrePayWechatOrder *,NSString *))success failure:(JHNetworkRequestFailure)failure{
    
    NSString *path = @"pay/we-chat-pay";
    NSString *token = [YCAccountManager shared].token;
    NSRange range = [token rangeOfString:@"Bearer"];
    NSString *subToken = [token substringFromIndex:range.length];
    NSDictionary *parameters =@{@"source" : @(parameter.source)?:@"",@"out_trade_no" : parameter.out_trade_no?:@"", @"total_fee" : parameter.total_fee?:@"", @"return_url" : parameter.return_url?:@"", @"type" : parameter.type?:@"",@"token":subToken?:@""};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSDictionary *data = dic[ApiResponseKeyData];
        YCPrePayWechatOrder *order = [JHModelMapper modelWithDictionary:data modelClass:[YCPrePayWechatOrder class]];
        success(order,@"");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

- (NSURLSessionDataTask *)getAlipayPrePayOrderInfoWithParameters:(YCAlipayParameters *)parameter success:(JHNetworkRequestSuccessContent)success failure:(JHNetworkRequestFailure)failure{
    
    NSString *path = @"pay/ali-pay";
    NSString *token = [YCAccountManager shared].token;
    NSRange range = [token rangeOfString:@"Bearer"];
    NSString *subToken = [token substringFromIndex:range.length];
    NSDictionary *parameters =@{@"source" : @(parameter.source)?:@"",@"out_trade_no" : parameter.out_trade_no?:@"", @"total_amount" : @(parameter.total_amount)?:@"", @"return_url" : parameter.return_url?:@"", @"type" : parameter.type?:@"",@"token":subToken?:@""};
    return [self POST:path parameters:parameters downProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *data = dic[ApiResponseKeyData];
        NSString *msg = dic[ApiResponseKeyMsg];
        success(data,msg);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

@end
