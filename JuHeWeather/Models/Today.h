//
//  Today.h
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Today : NSObject

@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *wind;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *date_y;
@property (nonatomic, strong) NSString *dressing_index;
@property (nonatomic, strong) NSString *dressing_advice;
@property (nonatomic, strong) NSString *uv_index;
@property (nonatomic, strong) NSString *comfort_index;
@property (nonatomic, strong) NSString *wash_index;
@property (nonatomic, strong) NSString *travel_index;
@property (nonatomic, strong) NSString *exercise_index;
@property (nonatomic, strong) NSString *drying_index;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
