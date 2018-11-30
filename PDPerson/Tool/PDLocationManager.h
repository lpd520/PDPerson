//
//  PDLocationManager.h
//  PDPerson
//
//  Created by mac on 2018/11/30.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef void(^LatitudeLongitudeMessageBlock)(NSString *lat, NSString *lon);
typedef void(^addressMessageBlock)(NSString *city, NSString *street, NSString *detail);


@interface PDLocationManager : NSObject

@property(nonatomic, copy)NSString *lat;  //纬度
@property(nonatomic, copy)NSString *lon;  //经度

// 创建单例对象
+ (instancetype)sharedManager;

// 获取当前的地理位置  ( 外部的网络请求 在此回调中发送 )
- (void)getGetLocationMessage:(LatitudeLongitudeMessageBlock)block;

// 根据地址关键字，获取经纬度
- (void)geocoderWithAddress:(NSString *)address reback:(LatitudeLongitudeMessageBlock)block;

//根据经纬度信息，进行反地理编码
-(void)getAddressWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon reback:(addressMessageBlock)block;

@end
