//
//  WeatherTableViewHeaderView.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "WeatherTableViewHeaderView.h"
#import "WeatherRootModel.h"

#import <Accelerate/Accelerate.h>

@interface WeatherTableViewHeaderView()

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *maxAndMinTempLabel;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *backView;

@end


@implementation WeatherTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self initSubViews];
        
    }

    return self;

}

- (void) initSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatBackView];
    
    UIView *h_top_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, View_Width, 0.5f)];
    h_top_lineView.backgroundColor = LineColor;
    [self addSubview:h_top_lineView];
    
    //  天气
    UILabel *weatherLabel = [[UILabel alloc] init];
    weatherLabel.textAlignment = NSTextAlignmentCenter;
    weatherLabel.frame    = CGRectMake(0, 0, 240, 60.f);
    weatherLabel.center   = CGPointMake(self.width / 2, self.height / 4);
    self.weatherLabel     = weatherLabel;
    
    //  城市
    UILabel *cityLabel  = [[UILabel alloc] init];
    cityLabel.frame     = CGRectMake(24, self.height / 2 + 10, 260, 50);
    cityLabel.textColor = [UIColor redColor];
    cityLabel.textAlignment = NSTextAlignmentLeft;
    self.cityLabel      = cityLabel;
    
    //  最高最低温度
    UILabel *maxAndMinTempLabel      = [[UILabel alloc] init];
    maxAndMinTempLabel.frame         = CGRectMake(24, cityLabel.y + cityLabel.height, 200, 30);
    maxAndMinTempLabel.textAlignment = NSTextAlignmentLeft;
    self.maxAndMinTempLabel          = maxAndMinTempLabel;
    
    //  日期
    UILabel *dateLabel  = [[UILabel alloc] init];
    dateLabel.frame     = CGRectMake(24, maxAndMinTempLabel.y + maxAndMinTempLabel.height, 200, 30);
    dateLabel.textColor = [UIColor blackColor];
    self.dateLabel = dateLabel;
    
    //  穿着提醒
    UILabel *label  = [[UILabel alloc] init];
    label.frame     = CGRectMake(0, 0, self.width - 48, 60);
    label.center    = CGPointMake(self.width / 2, Height *3 / 4);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    self.label = label;
    
    if (iPhone5_5s) {
        
        // 天气
        self.weatherLabel.font  = [UIFont systemFontOfSize:32.f];
        
        // 温度
        self.maxAndMinTempLabel.font  = [UIFont systemFontOfSize:18.f];
        
        // 日期
        self.dateLabel.font  = [UIFont systemFontOfSize:13.f];
        
        // 城市
        self.cityLabel.font  = [UIFont systemFontOfSize:30.f];
        
        self.label.font  = [UIFont systemFontOfSize:14.f];
        
    } else if (iPhone6_6s) {
        
        // 天气
        self.weatherLabel.font  = [UIFont systemFontOfSize:34.f];
        
        // 温度
        self.maxAndMinTempLabel.font  = [UIFont systemFontOfSize:20.f];
        
        // 日期
        self.dateLabel.font  = [UIFont systemFontOfSize:14.f];
        
        // 城市
        self.cityLabel.font  = [UIFont systemFontOfSize:32.f];
        
        self.label.font  = [UIFont systemFontOfSize:16.f];
        
    } else if (iPhone6_6sPlus) {
        
        // 天气
        self.weatherLabel.font  = [UIFont systemFontOfSize:36.f];
        
        // 温度
        self.maxAndMinTempLabel.font  = [UIFont systemFontOfSize:22.f];
        
        // 日期
        self.dateLabel.font  = [UIFont systemFontOfSize:16.f];
        
        // 城市
        self.cityLabel.font  = [UIFont systemFontOfSize:34.f];
        
        self.label.font  = [UIFont systemFontOfSize:18.f];
        
    } else {
        
        // 天气
        self.weatherLabel.font  = [UIFont systemFontOfSize:32.f];
        
        // 温度
        self.maxAndMinTempLabel.font  = [UIFont systemFontOfSize:18.f];
        
        // 日期
        self.dateLabel.font  = [UIFont systemFontOfSize:13.f];
        
        // 城市
        self.cityLabel.font  = [UIFont systemFontOfSize:30.f];
        
        self.label.font  = [UIFont systemFontOfSize:14.f];
        
    }
    
    [self addSubview:self.weatherLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.cityLabel];
    [self addSubview:self.maxAndMinTempLabel];
    [self addSubview:self.label];
    
    UIView *h_bottom_lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, View_Width, 0.5f)];
    h_bottom_lineView.backgroundColor = LineColor;
    [self addSubview:h_bottom_lineView];
    
    
    
}

- (void) loadData {
    
    self.backView.alpha = 1.f;
    
    Today *model = self.data;
    if (model.weather.length > 0) {
        
        self.weatherLabel.text = model.weather;
        
    } else {
        
        self.weatherLabel.text = @"晴";
        
    }
    
    NSLog(@"weather --- %@",model.weather);
    
    if (model.city.length > 0) {
        
        self.cityLabel.text = model.city;
        
    } else {
        
        self.cityLabel.text = @"西安";
        
    }
    
    if (model.temperature.length > 0) {
        
        self.maxAndMinTempLabel.text = model.temperature;
        
    } else {
        
        self.maxAndMinTempLabel.text = @" ";
        
    }
    
    if (model.date_y.length > 0 && model.week.length > 0) {
        
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",model.date_y,model.week];
        
    } else {
        
        self.dateLabel.text = @" ";
        
    }
    
    if (model.dressing_advice.length > 0) {
        
        self.label.text = model.dressing_advice;
        
    } else {
        
        self.label.text = @" ";
        
    }
    
}

- (void) creatBackView {
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:backView];
    
    //  创建显示图片
    UIImage *image = [UIImage imageNamed:@"14191491.jpg"];
    
    UIImageView *backImageView               = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    backImageView.contentMode   = UIViewContentModeScaleAspectFill;
    backImageView.image         = [self blurryImage:image withBlurLevel:0.95];
    backImageView.clipsToBounds = YES;
    [backView addSubview:backImageView];
    
    backView.alpha = 0.f;
    
    self.backView = backView;
}

//  添加通用模糊效果
//  image是图片，blur是模糊度
- (UIImage *) blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    
    if (image == nil) {
        
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片");
        
        return nil;
    }
    
    //  模糊度,
    if (blur < 0.025f) {
        
        blur = 0.025f;
        
    } else if (blur > 1.0f) {
        
        blur = 1.0f;
        
    }
    
    //  boxSize必须大于0
    int boxSize = (int)(blur * 100);
    
    boxSize -= (boxSize % 2) + 1;
    
    NSLog(@"boxSize:%i",boxSize);
    
    //  图像处理
    CGImageRef img = image.CGImage;
    
    //  需要引入#import <Accelerate/Accelerate.h>
    //  图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    //  像素缓存
    void *pixelBuffer;
    
    //  数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    
    //  provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //  宽，高，字节/行，data
    inBuffer.width    = CGImageGetWidth(img);
    inBuffer.height   = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data     = (void*)CFDataGetBytePtr(inBitmapData);
    
    //  像数缓存，字节行*图片高
    pixelBuffer        = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(img);
    outBuffer.height   = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    //  第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data     = pixelBuffer2;
    outBuffer2.width    = CGImageGetWidth(img);
    outBuffer2.height   = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //  Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        
        NSLog(@"error from convolution %ld", error);
    }
    
    //  NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //  颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //  用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //  根据上下文，处理过的图片，重新组件
    CGImageRef  imageRef    = CGBitmapContextCreateImage (ctx);
    UIImage    *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //  clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    //  CGColorSpaceRelease(colorSpace);
    //  多余的释放
    CGImageRelease(imageRef);
    return returnImage;
    
}

@end
