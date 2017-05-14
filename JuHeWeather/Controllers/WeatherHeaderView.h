//
//  WeatherHeatherView.h
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeatherHeaderViewDelegate <NSObject>

- (void) streatNetworkingWithCityName:(NSString *)cityName;

@end

@interface WeatherHeaderView : UIView

@property (nonatomic, weak) id<WeatherHeaderViewDelegate> delegate;

//  接受请求参数
@property (nonatomic, copy) NSString *userLogIn;

//  创建view
- (void) buildView;

- (void) searchBarResignFirstResponder;

@end
