//
//  LocationWeatherViewController.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "LocationWeatherViewController.h"
#import "WeatherTableViewCell.h"
#import "WeatherTableViewHeaderView.h"

#import "WeatherRootModel.h"
#import "GetWeatherData.h"

#import "MapManager.h"

@interface LocationWeatherViewController ()<UITableViewDelegate, UITableViewDataSource, MapManagerLocationDelegate, GetWeatherDataDelegate>

@property (nonatomic, strong) WeatherRootModel           *rootModel;
@property (nonatomic, strong) WeatherTableViewHeaderView *tableViewheaderView;
@property (nonatomic, strong) UITableView                *tableView;

@property (nonatomic, strong) MapManager     *mapLoacation;
@property (nonatomic, strong) GetWeatherData *getWeatherData;
@property (nonatomic, strong) CLLocation     *location;

@property (nonatomic, strong) NSMutableArray *weatherDatasArray;

@end

@implementation LocationWeatherViewController

//懒加载
- (NSMutableArray *)weatherDatasArray {
    
    if (_weatherDatasArray == nil) {
        
        _weatherDatasArray = [[NSMutableArray alloc] init];
    }
    return _weatherDatasArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitleView];
    
    //  创建tableView
    [self createTableView];
    
    [self getLocation];
    [self setWeatherData];
    
}

- (void) setupTitleView {
    
    self.title = @"定位获取天气信息";

}

- (void) createTableView {
    
    CGRect frame      = CGRectZero;
    frame.origin.x    = 0;
    frame.origin.y    = 0;
    frame.size.width  = View_Width;
    frame.size.height = View_Height;
    
    UITableView *tableView    = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[WeatherTableViewCell class] forCellReuseIdentifier:@"WeatherTableViewCell"];
    
    tableView.tableHeaderView = [self createTableHeaderView];
    
    self.tableView = tableView;
    
}

- (UIView *) createTableHeaderView {
    
    WeatherTableViewHeaderView *tableHeaderView = [[WeatherTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 64)];
    
    self.tableViewheaderView = tableHeaderView;
    
    return tableHeaderView;
    
}

#pragma mark - 定位代理方法
- (void) getLocation {
    
    //  定位功能
    self.mapLoacation          = [MapManager sharedManager];
    self.mapLoacation.delegate = self;
    
    // 开始定位
    [self.mapLoacation start];
    
}

- (void) setWeatherData {
    
    //  获取网络请求
    self.getWeatherData          = [GetWeatherData new];
    self.getWeatherData.delegate = self;
    
}

#pragma mark - 定位代理方法
- (void)                mapManager:(MapManager *)manager
     didUpdateAndGetLastCLLocation:(CLLocation *)location
                          cityName:(NSString *)cityName
                       subCityName:(NSString *)subCityName {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    NSDictionary *cityDic = @{@"subCityName" : subCityName,
                              @"cityName"    : cityName,
                              @"location"    : location};
    
    [self delayRunEvent:cityDic];
    
}

/**
 *  延时执行
 *
 *  @param object 过滤掉干扰项目
 *
 */
- (void) delayRunEvent:(id)object {
    
    self.getWeatherData.location = [object valueForKey:@"location"];
    
    [self.getWeatherData startGetLocationWeatherData];
    
}

- (void) mapManager:(MapManager *)manager didFailed:(NSError *)error {
    
}

- (void) mapManagerServerClosed:(MapManager *)manager {
    
}

#pragma mark - 获取数据代理方法
/**
 *  获取到网络数据的结果
 *
 *  @param object 网络数据
 *  @param sucess YES表示成功,NO表示失败
 */
- (void) weatherData:(id)object sucess:(BOOL)sucess {
    
    NSDictionary *WeatherData = [object valueForKey:@"WeatherData"];
    
    WeatherRootModel *rootModel = [[WeatherRootModel alloc] initWithDictionary:WeatherData];
    
    NSMutableArray *tmpArray    = [[NSMutableArray alloc] init];
    NSArray        *futureArray = [rootModel.result valueForKey:@"future"];
    
    for (NSDictionary *futureDic in futureArray) {
        
        Future *future = [[Future alloc] initWithDictionary:futureDic];
        
        [tmpArray addObject:future];
        
    }
    
    self.weatherDatasArray = [tmpArray copy];
    
    Today *today = [[Today alloc] initWithDictionary:[rootModel.result valueForKey:@"today"]];
    
    self.tableViewheaderView.data = today;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableViewheaderView loadData];
        
        [self.tableView reloadData];
        
    });
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.weatherDatasArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (iPhone5_5s) {
        
        return 94;
        
    } else if (iPhone6_6s) {
        
        return 110;
        
    } else if (iPhone6_6sPlus) {
        
        return 120;
        
    } else {
        
        return 94;
        
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherTableViewCell"
                                                                 forIndexPath:indexPath];
    
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    
    Future *model = self.weatherDatasArray[indexPath.row];
    
    cell.data = model;
    
    [cell loadData];
    
    return cell;
    
}

@end
