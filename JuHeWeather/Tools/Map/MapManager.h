//
//  MapManager.h
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class MapManager;
@protocol MapManagerLocationDelegate <NSObject>

@optional

- (void)            mapManager:(MapManager *)manager
 didUpdateAndGetLastCLLocation:(CLLocation *)location
                      cityName:(NSString *)cityName
                   subCityName:(NSString *)subCityName;

- (void) mapManager:(MapManager *)manager
          didFailed:(NSError *)error;

- (void) mapManagerServerClosed:(MapManager *)manager;

@end

@interface MapManager : NSObject

@property (nonatomic, weak)     id<MapManagerLocationDelegate> delegate;
@property (nonatomic, readonly) CLAuthorizationStatus          authorizationStatus;
@property (nonatomic, assign)   BOOL                           isGetlocation;

+ (MapManager *)sharedManager;

- (void)start;

@end
