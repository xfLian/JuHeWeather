//
//  Result.h
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sk.h"
#import "Today.h"
#import "Future.h"

@interface Result : NSObject

@property (nonatomic, strong) Sk                 *sk;
@property (nonatomic, strong) Today              *today;
@property (nonatomic, strong) NSArray <Future *> *future;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
