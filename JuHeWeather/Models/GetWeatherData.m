//
//  GetWeatherData.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "GetWeatherData.h"
#import "WeatherRootModel.h"

typedef enum : NSUInteger {
    
    kWeather = 0x11,
    kDaily,
    
} EGetWeatherDataValue;

@interface GetWeatherData ()

@end

@implementation GetWeatherData

- (void) startGetLocationWeatherData {
    
    CGFloat lat = self.location.coordinate.latitude;
    CGFloat lon = self.location.coordinate.longitude;
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    //  创建数据请求URL及参数
    NSString            *url       = @"https://v.juhe.cn/weather/geo";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"2"     forKey:@"format"];
    [parameter setObject:API_Key  forKey:@"key"];
    [parameter setObject:[NSString stringWithFormat:@"%f",lon] forKey:@"lon"];
    [parameter setObject:[NSString stringWithFormat:@"%f",lat] forKey:@"lat"];
    
    //  启动网络进行数据请求
    [httpTool lxfGetWithURL:url params:parameter success:^(id data) {
        
        // 获取数据成功
        [self requestSucessWithData:data];
        
    } failure:^(NSError *error) {
        
        // 获取数据失败
        [self requestFailedWithError:error];
        
    }];

    
}

- (void) requestSucessWithData:(id)data {
        
    [_delegate weatherData:@{@"WeatherData" : data}
                    sucess:YES];
    
}

- (void) requestFailedWithError:(id)error {
    
    [_delegate weatherData:nil sucess:NO];
    
}

- (NSDictionary *) dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData       *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError      *err;
    NSDictionary *dic      = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
    
    if (err) {
        
        //创建一个消息对象
        NSNotification *notice = [NSNotification notificationWithName:@"DataError"
                                                               object:nil
                                                             userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
        
    }
    
    return dic;
}

@end
