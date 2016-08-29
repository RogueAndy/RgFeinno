//
//  RgLocation.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/8/29.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgLocation.h"
#import <UIKit/UIKit.h>

static RgLocation *manager = nil;

@interface RgLocation()<CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) void (^locationComplete)(CLPlacemark *place);

@end

@implementation RgLocation

#pragma mark - 单例模式

+ (instancetype)shareInstance {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        manager = [[self alloc] init];
        
    });
    
    return manager;
    
}

#pragma mark - 请求定位

+ (void)requestLocation:(void (^)(CLPlacemark *))locationComplete {

    [[self shareInstance] setLocationComplete:locationComplete];
    [[self shareInstance] startUpdatingLocation];

}

#pragma mark - 懒汉加载

- (CLLocationManager *)locationManager {
    
    if(!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
    }
    
    return _locationManager;
    
}

- (void)startUpdatingLocation {
    
    /**
     *  如果是iOS8，请求定位
     */
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0) {
        [self.locationManager requestWhenInUseAuthorization];// 前台定位
    }
    /**
     *  开始定位
     */
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - Location Delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [self.locationManager stopUpdatingLocation];
    self.locationComplete(nil);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [self.locationManager stopUpdatingLocation];
    [self getAreaInformation:manager didUpdateLocations:[locations firstObject]];
    
}

#pragma mark - 定位成功进入自定义方法

- (void)getAreaInformation:(CLLocationManager *)manager didUpdateLocations:(CLLocation *)locations {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __weak RgLocation *weakSelf = self;
    [geocoder reverseGeocodeLocation:locations completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        /*
        
        if(placemarks.count > 0) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            NSString *cityName = placemark.locality;
            
            if(!cityName || [cityName isEqualToString:placemark.administrativeArea]) { // 如果是直辖市，则 locality 属性为空，需要从父类获取地址
                
                model.name = placemark.administrativeArea;
                model.level1name = placemark.administrativeArea;;
                model.level2name = @"市辖区";
                model.level3name = placemark.subLocality;
                model.is_zhixiashi = YES;
                
            } else {
                
                model.name = placemark.locality;
                model.level1name = placemark.administrativeArea;
                model.level2name = placemark.locality;
                model.level3name = placemark.subLocality;
                model.is_zhixiashi = NO;
                
            }
            
            model = [NXFMDB getAreaModel_areaName:model.name];
            
            weakSelf.locationComplete(model);
            return;
         
            
        }
        
        weakSelf.locationComplete(nil);
         
        **/
        
        weakSelf.locationComplete([placemarks firstObject]);
        
    }];
    
}

@end
