//
//  PDLocationManager.m
//  PDPerson
//
//  Created by mac on 2018/11/30.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDLocationManager.h"

@interface PDLocationManager()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locManager;
@property(nonatomic,strong)CLGeocoder *geocoder;
//这个block主要是跨方法进行保存
@property(nonatomic,copy)LatitudeLongitudeMessageBlock block;

@end



@implementation PDLocationManager

+ (instancetype)sharedManager{
    //在静态去生成一个引用，但是现在还没有指向任何东西
    static PDLocationManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[PDLocationManager alloc] init];
    });
    return _manager;
}

- (instancetype)init{
    if (self == [super init]) {
        _locManager = [[CLLocationManager alloc] init];
        // 设置精确度
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        _locManager.distanceFilter = 100;  //每移动一百米定位一次
        _locManager.delegate = self;
        
        _geocoder = [[CLGeocoder alloc] init];
        
        if(![CLLocationManager locationServicesEnabled]){
            NSLog(@">>>>> 没有开启服务，应该开启定位服务");
            
//            UIAlertController *aler = [UIAlertController alertWithTipMessage:@"未开启定位服务，立即开启？" subTitle:nil okBlock:^{
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//            } noBlock:^{
//            }];
//
        }else{ // 已经开启定位权限
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            
            //设置定位只在前台开启 这里对应的info.plist要同步更改
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
        }
        
    }
    return self;
}

//外部调用这个方法的时候，开始定位
-(void)getGetLocationMessage:(LatitudeLongitudeMessageBlock)block{
    
    self.block = block;
    //开始定位
    [self.locManager startUpdatingLocation];
}

// 根据地址关键字，进行地理编码
- (void)geocoderWithAddress:(NSString *)address reback:(LatitudeLongitudeMessageBlock)block{
//    address = @"广东省深圳市宝安区";
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        //创建placemark对象
        CLPlacemark *placemark = [placemarks firstObject];
        //经度
        NSString *longitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
        //纬度
        NSString *latitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
        
        NSLog(@"经度：%@，纬度：%@",longitude,latitude);
        
        if (block) {
            block(latitude,longitude);
        }
        
    }];
}

-(void)getAddressWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon reback:(addressMessageBlock)block{

    CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    
    [_geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *plk = [placemarks firstObject];
        NSLog(@"---城市：%@--街道：%@--全称：%@",plk.locality,plk.thoroughfare,plk.name);
        
        if (block) {
            block(plk.locality,plk.thoroughfare,plk.name);
        }
    }];
}


#pragma mark -CLLocationManagerDelegate

//以下两个方法只能写其中一个，如果写了第一个方法，第二个方法不再有效
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    //NSLog(@"定位成功");
//}


// 定位成功回调
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //保存经纬度信息，这是一个结构体
    CLLocationCoordinate2D coor = newLocation.coordinate;
    NSString *lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString *lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    
    
    //进行赋值，用变量保存，又因是单例，所以可以在整个app中使用
    [PDLocationManager sharedManager].lat = lat;
    [PDLocationManager sharedManager].lon = lon;    //不能使用 self.lat = lat;进行赋值。

    if (_block) {
        self.block(lat,lon);
    }
    //定位成功后，关闭定位
    [self.locManager stopUpdatingLocation];
    
}

// 定位失败后 回调
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if (error.code == kCLErrorDenied) {
        // 提示用户出错
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户未决定");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"定位服务访问受限 (系统预留字段)");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"定位被拒绝");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"前后台定位授权");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"前台定位授权");
            break;
        default:
            break;
    }
    
}

@end
