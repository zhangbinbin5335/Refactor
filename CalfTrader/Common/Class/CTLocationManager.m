//
//  CTLocationManager.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/5/31.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTLocationManager.h"

#import <CoreLocation/CoreLocation.h>

@interface CTLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) CTLocationManagerHandler handler;

@end

@implementation CTLocationManager

#pragma mark - ♻️life cycle

#pragma mark - 🔒private
-(void)requestCurrentLoacion{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }else if (status == kCLAuthorizationStatusDenied){
        NSLog(@"用户拒绝提供位置权限");
    }else {
        [self.locationManager requestLocation];
    }
}

#pragma mark - delegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations.count > 0) {
        CLLocation *location = [locations firstObject];
        
        __weak typeof(self) weakSelf = self;
        
        CLGeocoder * geocoder = [[CLGeocoder alloc]init];
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                           BOOL inChina = NO;
                           if (error || placemarks.count == 0) {
                           }else if ([[placemarks firstObject].ISOcountryCode  isEqual: @"CN"]){
                               inChina = YES;
                           }else{
                           }
                           
                           if (weakSelf.handler) {
                               weakSelf.handler(inChina);
                           }
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status > kCLAuthorizationStatusDenied) {
        [manager requestLocation];
    }
}

#pragma mark - 🚪public
-(void)requestLocationCompletionHandler:(void (^)(BOOL))completion{
    [self requestCurrentLoacion];
    self.handler = [completion copy];
}

#pragma mark - ☸getter and setter
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}

@end
