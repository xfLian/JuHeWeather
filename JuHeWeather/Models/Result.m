//
//  Result.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "Result.h"

@implementation Result

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    if ([key isEqualToString:@"future"] && [value isKindOfClass:[NSArray class]]) {
        
        NSArray        *tmp       = value;
        NSMutableArray *futureData = [NSMutableArray array];
        
        for (NSDictionary *data in tmp) {
            
            Future *futureModel = [[Future alloc] initWithDictionary:data];
            [futureData addObject:futureModel];
        }
        
        value = futureData;
    }
    
    if ([key isEqualToString:@"sk"]) {
        value = [[Sk alloc] initWithDictionary:value];
    }
    
    if ([key isEqualToString:@"today"]) {
        value = [[Today alloc] initWithDictionary:value];
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
