//
//  MapManager.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MapManager.h"

@interface MapManager ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString          *cityName;

@end

@implementation MapManager

+ (MapManager *)sharedManager {
    
    static MapManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        sharedAccountManagerInstance = [[self alloc] init];
    });
    
    return sharedAccountManagerInstance;
}

- (void)start {
    
    _locationManager          = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
}

// Location Manager Delegate Methods
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    if (self.isGetlocation == YES) {
        
        [manager stopUpdatingLocation];
        
    } else {
    
        self.isGetlocation = YES;
        
        if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didUpdateAndGetLastCLLocation:cityName:subCityName:)]) {
            
            CLLocation *location = [locations lastObject];
            
            
            
            //  获取当前所在的城市名
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            
            //  根据经纬度反向地理编译出地址信息
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
                
                if (array.count > 0) {
                    
                    CLPlacemark *placemark = [array objectAtIndex:0];
                    
                    //NSLog(@"placemark.name --- %@",placemark);
                    
                    //  获取城市
                    NSString *cityName    = placemark.locality;
                    NSString *subCityName = placemark.subLocality;
                    
                    if (!cityName) {
                        
                        //  四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                        cityName = placemark.administrativeArea;
                        
                    }
                    
                    NSLog(@"cityName    --- %@",cityName);
                    NSLog(@"subCityName --- %@",subCityName);
                    
                    [_delegate mapManager:self didUpdateAndGetLastCLLocation:location
                                 cityName:cityName
                              subCityName:subCityName];

                } else if (error == nil && [array count] == 0) {
                    
                    NSLog(@"No results were returned.");
                    
                } else if (error != nil) {
                    
                    NSLog(@"An error occurred = %@", error);
                    [_delegate mapManager:self didFailed:error];
                }

            }];
        }
        
        [manager stopUpdatingLocation];
    }

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"定位失败");
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
        NSLog(@"定位功能关闭");
        if (_delegate && [_delegate respondsToSelector:@selector(mapManagerServerClosed:)]) {
            
            [_delegate mapManagerServerClosed:self];
        }
        
    } else {
        
        NSLog(@"定位功能开启");
        if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didFailed:)]) {
            
            NSLog(@"%@", error);
            [_delegate mapManager:self didFailed:error];
        }
    }
}

@synthesize authorizationStatus = _authorizationStatus;

- (CLAuthorizationStatus)authorizationStatus {
    
    return [CLLocationManager authorizationStatus];
}

@end
