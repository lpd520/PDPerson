//
//  YCOrderRequest.h
//  Yacht
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseRequest.h"
@class YCCreatedOrder;
@class YCPrePayWechatOrder;
@class YCPrePayAlipayOrder;
@class YCWechatPayParameters;
@class YCAlipayParameters;

typedef NS_ENUM(NSUInteger, YCOrderTime) {
    YCOrderTimeAll = 0,    //所有
    YCOrderTimeOneMonth,   //一个月内
    YCOrderTimeThreeMonths,//三个月内
    YCOrderTimeOneYear,    //一年内
};


@interface YCOrderRequest : JHBaseRequest

/**
 获取订单

 @param parameters 参数字典
    order_time  integer     0=>所有 1 =>一个月内 2 =>三个月 3=>一年内
    go_time     integer     1 =>一个月内 2 =>三个月 3=>一年内
    status      integer     99=>全部 0=>待支付 1=>待确认 2=>待出航 3=>等待评论 4=>已完结 5=>已取消
    per_page    integer     每页条数
 */
- (NSURLSessionDataTask *)getOrdersWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure: (JHNetworkRequestFailure)failure;

/**
 获取订单详情

 @param orderId 订单ID
 */
- (NSURLSessionDataTask *)getOrderDetailWith:(NSUInteger)orderId success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure;

/**
 获取优惠券

 @param parameters
    price string 订单价格
    yacht_id integer 商家游艇id
    custom_provider_id integer 商家id
    per_page integer 每页条数
 */
- (NSURLSessionDataTask *)getCouponsWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure;

/**
 创建订单

 @param parameters
    start_time string 出行开始时间 Default value : 2019-05-01 08:00:00
    end_time string 出行结束时间 Default value : 2019-05-01 09:00:00
    custom_set_meal_son_id integer 子套餐id Default value : 0
    user_coupon_id integer 优惠券id Default value : 0
    contact_person string 联系人 Default value : 0
    mobile string 手机号 Default value : 0
    identity string 身份证 传json 证件类型 1234

 */
- (NSURLSessionDataTask *)createOrderWithParameters:(NSDictionary *)parameters success:(void(^)(YCCreatedOrder *order,NSString *msg))success failure:(JHNetworkRequestFailure)failure;

- (NSURLSessionDataTask *)getWechatPrePayOrderInfoWithParameters:(YCWechatPayParameters *)parameter success:(void(^)(YCPrePayWechatOrder *order, NSString *msg))success failure:(JHNetworkRequestFailure)failure;

- (NSURLSessionDataTask *)getAlipayPrePayOrderInfoWithParameters:(YCAlipayParameters *)parameter success:(JHNetworkRequestSuccessContent)success failure:(JHNetworkRequestFailure)failure;

@end


