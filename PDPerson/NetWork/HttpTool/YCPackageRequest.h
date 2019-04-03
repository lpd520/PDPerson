//
//  YCPackageRequest.h
//  Yacht
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseRequest.h"

@interface YCPackageRequest : JHBaseRequest

/**
 获取小套餐
 
 @param parameters 请求参数字典
 yacht_type    string   游艇新类型 1=>游艇 2=>帆船 3=>游轮
 play_type     integer  类型 1=>包艇 2=>单票 3=>拼船
 is_time_limit integer  限时特惠 0=>非限时特惠 1=>限时特惠
 is_top        integer  是否推荐 0=>未推荐 1=>推荐
 sort          integer  排序 1=>智能排序 2=>价格由低到高
 3=>价格由高到低 4=>船型由大到小 5=>船型由小到大 6=>首页默认
 people_num    string   人数 0=>不限 1=>1-5 2=>6-10 3=>11-20 4=>22以上
 price         string   价格 0=>不限 1=>100以下 2=>101-1000 3=>1001-5000 4=>5000以上
 wharf_id      string   0=>不限 码头id
 title         string   搜索套餐名称
 custom_set_meal_id  integer  套餐ID
 per_page      integer  每页条数
 */

- (NSURLSessionDataTask *)getMealSonsWithParameters:(NSDictionary *)parameters
                                            success:(nonnull JHNetworkRequestSuccessArray)success
                                            failure:(nonnull JHNetworkRequestFailure)failure;

/**
 获取小套餐详情

 @param mealSonId 小套餐ID Default value : 1
 @param date 日期 Default value : 2019-03-05
 */
- (NSURLSessionDataTask *)getMealSonDetailWithMealSonId:(NSUInteger)mealSonId
                                                   date:(NSString *)date
                                                success:(JHNetworkRequestSuccessArray)success
                                                failure:(JHNetworkRequestFailure)failure;


/**
 获取码头信息
 */
- (NSURLSessionDataTask *)getWharfsInfoSuccess:(JHNetworkRequestSuccessArray)success
                                       failure:(JHNetworkRequestFailure)failure;




/**
 获取套餐评价

 @param parameters 参数字典
    custom_order_id integer 订单id Default value : 1
    custom_set_meal_id integer 套餐id
    custom_set_meal_son_id integer 子套餐id
    per_page integer 每页条数
    page integer 第几页
 */
- (NSURLSessionDataTask *)getPackageCommentsWithParameters:(NSDictionary *)parameters success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure;

/**
 获取套餐选择器

 @param mealId 大套餐ID
 @param date 日期
 */
- (NSURLSessionDataTask *)getSubPackagesWithMealId:(NSUInteger)mealId date:(NSDate *)date success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure;



/**
 获取套餐可选时间

 @param mealSonId 小套餐ID
 @param date 出发时间
 */
- (NSURLSessionDataTask *)getPackageAvailableTimeWithMealSonId:(NSUInteger)mealSonId date:(NSDate *)date success:(JHNetworkRequestSuccessArray)success failure:(JHNetworkRequestFailure)failure;

@end

