//
//  RgMapView.m
//  RgFeinno
//
//  Created by Rogue Andy on 16/9/6.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "RgMapView.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface RgMapView()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

@property (nonatomic, strong) BMKReverseGeoCodeOption *reverseGeoCodeOption;

/**
 *  启动定位服务
 */

@property (nonatomic, strong) BMKLocationService *localService;

/**
 *  大头针按钮设置
 */

@property (weak, nonatomic) UIButton *mapPin;

/**
 *  调用百度地图
 */

@property (nonatomic, strong) BMKMapView *mapView;

@end

@implementation RgMapView

- (void)setFrame:(CGRect)frame {

    [super setFrame:frame];
    
    [self loadLayout]; // 因为从外部设置高度，所以赋值时候，调用 setter 方法来改变对应的布局

}

- (instancetype)init {

    if(self = [super init]) {
    
        [self loadSubview];
        [self loadLayout];
    
    }
    
    return self;

}

- (void)loadSubview {

    self.mapView = [[BMKMapView alloc] init];
    self.mapPin = [UIButton buttonWithType:UIButtonTypeSystem]; //大头针
    [self.mapPin setBackgroundImage:[UIImage imageNamed:@"serach_Map"] forState:UIControlStateNormal];
    self.mapPin.backgroundColor = [UIColor greenColor];
    
    self.mapView.zoomLevel = 17; //比例尺
    [self.mapView setMapType:BMKMapTypeStandard]; //地图类型
    self.mapView.delegate = self;
    self.localService.delegate = self;
    [self.localService startUserLocationService]; //用户开始定位
    
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow; //设置定位的状态
    self.mapView.showsUserLocation = YES; //显示定位图层
    
    [self.mapView addSubview:self.mapPin];
    [self addSubview:self.mapView];
    [self.mapView bringSubviewToFront:self.mapPin];

}

- (void)loadLayout {

    self.mapView.frame = self.bounds;
    self.mapPin.frame = CGRectMake(0, 0, 40, 80);
    self.mapPin.center = self.mapView.center;

}

#pragma mark - 懒汉模式

- (BMKLocationService *)localService {
    
    if (!_localService) {
        
        _localService = [[BMKLocationService alloc] init];
        [_localService setDesiredAccuracy:kCLLocationAccuracyBest]; //设置定位精度
        
    }
    
    return _localService;
}

/**
 *  地理编码
 *
 *  @return 对象
 */

- (BMKGeoCodeSearch *)geoCodeSearch {

    if(!_geoCodeSearch) {
    
        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _geoCodeSearch.delegate = self;
    
    }
    
    return _geoCodeSearch;

}

/**
 *  初始化反地理编码类
 *
 *  @return 对象
 */

- (BMKReverseGeoCodeOption *)reverseGeoCodeOption {

    if(!_reverseGeoCodeOption) {
    
        _reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    
    }
    
    return _reverseGeoCodeOption;

}

#pragma mark - BMKLocationServiceDelegate

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.mapView.showsUserLocation = YES; //显示定位图层
    [self.mapView updateLocationData:userLocation]; //设置地图中心为用户经纬度
    
    BMKCoordinateRegion region; //表示范围的结构体
    region.center = self.mapView.centerCoordinate; //中心点
    region.span.latitudeDelta = 0.004; //经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.004; //纬度范围
    [self.mapView setRegion:region animated:YES];
    
}

#pragma mark -- BMKMapViewDelegate

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    CLLocationCoordinate2D MapCoordinate=[self.mapView convertPoint:self.mapPin.center toCoordinateFromView:self.mapView]; //屏幕坐标转地图经纬度
    self.reverseGeoCodeOption.reverseGeoPoint = MapCoordinate; //需要逆地理编码的坐标位置
    [self.geoCodeSearch reverseGeoCode:self.reverseGeoCodeOption];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init]; //创建地理编码对象
    CLLocation *location = [[CLLocation alloc] initWithLatitude:MapCoordinate.latitude longitude:MapCoordinate.longitude]; //创建位置
    
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error != nil || placemarks.count == 0) {
            NSLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //赋值详细地址
            NSLog(@"%@", placemark.name);
        }
    }];
}

#pragma mark -- BMKGeoCodeSearchDelegate

//周边信息
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    for (BMKPoiInfo *poi in result.poiList) {
        
        NSLog(@"%@",poi.name);//周边建筑名
        NSLog(@"%d",poi.epoitype);
        
    }
    
}

@end
