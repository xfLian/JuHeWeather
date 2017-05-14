//
//  Sk.h
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sk : NSObject

@property (nonatomic, strong) NSString *temp;
@property (nonatomic, strong) NSString *wind_direction;
@property (nonatomic, strong) NSString *wind_strength;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *time;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
