//
//  Future.h
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Future : NSObject

@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *wind;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *date;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
