//
//  WeatherTableViewCell.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "WeatherTableViewCell.h"
#import "WeatherRootModel.h"

@interface WeatherTableViewCell()

@property (nonatomic, strong) WeatherRootModel *model;

@property (nonatomic, strong) UILabel     *weekLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *maxAndMinTempLabel;
@property (nonatomic, strong) UILabel     *weatherLabel;

@end

@implementation WeatherTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubViews];
        
    }
    
    return self;
    
}

- (void) initSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *h_top_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, View_Width, 0.5f)];
    h_top_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:h_top_lineView];
    
    //  周时间label
    UILabel *weekLabel = [[UILabel alloc] init];
    self.weekLabel     = weekLabel;
    
    //  日期
    UILabel *dateLabel            = [[UILabel alloc] init];
    dateLabel.backgroundColor     = [UIColor blackColor];
    dateLabel.layer.borderColor   = [[UIColor grayColor] CGColor];
    dateLabel.layer.borderWidth   = 0.5f;
    dateLabel.layer.masksToBounds = YES;
    dateLabel.textColor           = [UIColor whiteColor];
    self.dateLabel = dateLabel;
    
    //  最高最低温度
    UILabel *maxAndMinTempLabel      = [[UILabel alloc] init];
    maxAndMinTempLabel.textAlignment = NSTextAlignmentCenter;
    self.maxAndMinTempLabel          = maxAndMinTempLabel;
    
    //  天气
    UILabel *weatherLabel = [[UILabel alloc] init];
    weatherLabel.textAlignment = NSTextAlignmentRight;
    self.weatherLabel     = weatherLabel;
    
    
    if (iPhone5_5s) {
        
        // 天气
        self.weatherLabel.frame = CGRectMake(Width - 100, (94 - 16) / 2, 90, 16.f);
        self.weatherLabel.font  = [UIFont systemFontOfSize:14.f];
        
        // 日期
        self.dateLabel.frame = CGRectMake(Width - 60, 2, 60, 16.f);
        self.dateLabel.font  = [UIFont systemFontOfSize:10.f];
        
        // 星期几
        self.weekLabel.frame = CGRectMake(17, 27, 100, 40);
        self.weekLabel.font  = [UIFont systemFontOfSize:20.f];
        
        // 最高最低温度
        self.maxAndMinTempLabel.frame = CGRectMake(Width / 2 - 50, 27, 120, 40);
        
    } else if (iPhone6_6s) {
        
        // 天气
        self.weatherLabel.frame = CGRectMake(Width - 100, (110 - 18) / 2, 90, 18.f);
        self.weatherLabel.font  = [UIFont systemFontOfSize:16.f];
        
        // 日期
        self.dateLabel.frame = CGRectMake(Width - 65, 2, 65, 18.f);
        self.dateLabel.font  = [UIFont systemFontOfSize:11.f];
        
        // 星期几
        self.weekLabel.frame = CGRectMake(17, 30, 100, 50);
        self.weekLabel.font  = [UIFont systemFontOfSize:22.f];
        
        // 最高最低温度
        self.maxAndMinTempLabel.frame = CGRectMake(Width / 2 - 55, 31, 130, 46);
        
    } else if (iPhone6_6sPlus) {
        
        // 天气
        self.weatherLabel.frame = CGRectMake(Width - 100, (120 - 20) / 2, 90, 20);
        self.weatherLabel.font  = [UIFont systemFontOfSize:16.f];
        
        // 日期
        self.dateLabel.frame = CGRectMake(Width - 70, 2, 70, 20);
        self.dateLabel.font  = [UIFont systemFontOfSize:11.f];
        
        // 星期几
        self.weekLabel.frame = CGRectMake(17, 30, 100, 60);
        self.weekLabel.font  = [UIFont systemFontOfSize:22.f];
        
        // 最高最低温度
        self.maxAndMinTempLabel.frame = CGRectMake(Width / 2 - 60, 31, 140, 56);
        
    } else {
        
        // 天气
        self.weatherLabel.frame = CGRectMake(Width - 100, (94 - 16) / 2, 90, 16.f);
        self.weatherLabel.font  = [UIFont systemFontOfSize:14.f];
        
        // 日期
        self.dateLabel.frame = CGRectMake(Width - 60, 2, 60, 16.f);
        self.dateLabel.font  = [UIFont systemFontOfSize:10.f];
        
        // 星期几
        self.weekLabel.frame = CGRectMake(17, 27, 100, 40);
        self.weekLabel.font  = [UIFont systemFontOfSize:20.f];
        
        // 最高最低温度
        self.maxAndMinTempLabel.frame = CGRectMake(Width / 2 - 50, 27, 120, 40);
        
    }
    
    [self addSubview:self.weatherLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.weekLabel];
    [self addSubview:self.maxAndMinTempLabel];
    
    UIView *h_bottom_lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, View_Width, 0.5f)];
    h_bottom_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:h_bottom_lineView];
    
}

- (void) loadData {
    
    Future *model = self.data;
    if (model.weather.length > 0) {
        
        self.weatherLabel.text = model.weather;
        
    } else {
        
        self.weatherLabel.text = @"晴";
        
    }
    
    if (model.date.length > 0) {
        
        self.dateLabel.text = model.date;
        
    } else {
        
        self.dateLabel.text = @" ";
        
    }
    
    if (model.week.length > 0) {
        
        self.weekLabel.text = model.week;
        
    } else {
        
        self.weekLabel.text = @" ";
        
    }
    
    if (model.temperature.length > 0) {
        
        self.maxAndMinTempLabel.text = model.temperature;
        
    } else {
        
        self.maxAndMinTempLabel.text = @" ";
        
    }
        
}

@end
