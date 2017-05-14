//
//  WeatherRootModel.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "WeatherRootModel.h"

@implementation WeatherRootModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    if ([key isEqualToString:@"result"] && [value isKindOfClass:[NSArray class]]) {
        
        NSArray        *tmp       = value;
        NSMutableArray *resultData = [NSMutableArray array];
        
        for (NSDictionary *data in tmp) {
            
            Result *resultModel = [[Result alloc] initWithDictionary:data];
            [resultData addObject:resultModel];
        }
        
        value = resultData;
    }
    
    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        if (self = [super init]) {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    
    return self;
}

@end
