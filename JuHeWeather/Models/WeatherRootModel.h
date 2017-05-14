//
//  WeatherRootModel.h
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"

@interface WeatherRootModel : NSObject

@property (nonatomic, strong) NSString *resultcode;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) Result   *result;
@property (nonatomic, strong) NSString *error_code;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
