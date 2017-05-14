//
//  WeatherViewController.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherHeaderView.h"
#import "WeatherTableViewCell.h"
#import "WeatherTableViewHeaderView.h"

#import "WeatherRootModel.h"

#import "LocationWeatherViewController.h"

@interface WeatherViewController ()<UITableViewDelegate, UITableViewDataSource, WeatherHeaderViewDelegate>

@property (nonatomic, strong) WeatherRootModel           *rootModel;
@property (nonatomic, strong) WeatherHeaderView          *headerView;
@property (nonatomic, strong) WeatherTableViewHeaderView *tableViewheaderView;
@property (nonatomic, strong) UITableView                *tableView;

@property (nonatomic, strong) NSMutableArray *weatherDatasArray;

@property (nonatomic, strong) UIButton *pustButton;

@end

@implementation WeatherViewController

//懒加载
- (NSMutableArray *)weatherDatasArray {
    
    if (_weatherDatasArray == nil) {
        
        _weatherDatasArray = [[NSMutableArray alloc] init];
    }
    return _weatherDatasArray;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //  创建表头搜索框
    [self createHeaderView];
    
    //  创建tableView
    [self createTableView];
    
    {
        
        UIButton *pustButton = [[UIButton alloc] initWithFrame:CGRectMake(Width - 42, Height - 42, 30, 30)];
        [pustButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        [pustButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:pustButton];
        self.pustButton = pustButton;
        
    }
    
}

- (void) buttonEvent:(UIButton *)sender {

    LocationWeatherViewController *viewController = [[LocationWeatherViewController alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) createHeaderView {
    
    CGRect frame      = CGRectZero;
    frame.origin.x    = 0;
    frame.origin.y    = 0;
    frame.size.width  = View_Width;
    frame.size.height = 64;
    
    WeatherHeaderView *headerView = [[WeatherHeaderView alloc] init];
    headerView.frame              = frame;
    headerView.delegate           = self;
    [headerView buildView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
}

- (void) createTableView {
    
    CGRect frame      = CGRectZero;
    frame.origin.x    = 0;
    frame.origin.y    = 64;
    frame.size.width  = View_Width;
    frame.size.height = View_Height - 64;
    
    UITableView *tableView    = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[WeatherTableViewCell class] forCellReuseIdentifier:@"WeatherTableViewCell"];
    
    tableView.tableHeaderView = [self createTableHeaderView];
    
    self.tableView = tableView;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(clickView)];
    tapGestureRecognizer.cancelsTouchesInView    = NO;
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
    
}

- (UIView *) createTableHeaderView {

    WeatherTableViewHeaderView *tableHeaderView = [[WeatherTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64)];
    
    self.tableViewheaderView = tableHeaderView;
    
    return tableHeaderView;

}

- (void) clickView {
    
    [self.headerView searchBarResignFirstResponder];
    
}

#pragma mark - headerView代理方法
- (void) streatNetworkingWithCityName:(NSString *)cityName; {

    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    if (cityName > 0) {
        
        NSString *message = [cityName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([message length] == 0) {
            
            NSLog(@"searchBar --- 全是空格");
            
        } else {
            
            NSLog(@"cityName --- %@",cityName);
            
            //  创建数据请求URL及参数
            NSString *citynameString = [self cityNameURLEncodeToStringWithURLEncode:cityName];
            NSString            *url       = @"https://v.juhe.cn/weather/index";
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            [parameter setObject:@"2"     forKey:@"format"];
            [parameter setObject:citynameString forKey:@"cityname"];
            [parameter setObject:API_Key  forKey:@"key"];
            
            //  启动网络进行数据请求
            [httpTool lxfGetWithURL:url params:parameter success:^(id data) {
                
                // 获取数据成功
                [self requestSucessWithData:data];
                
            } failure:^(NSError *error) {
                
                // 获取数据失败
                [self requestFailedWithError:error];
                
            }];
            
        }
        
    } else {
        
        
        
    }

}

//  转换URLEncode
- (NSString *) cityNameURLEncodeToStringWithURLEncode:(NSString *)URLEncode {
    
    NSString *cityNameString = [URLEncode stringByRemovingPercentEncoding];
    
    return cityNameString;
    
}

- (void) requestSucessWithData:(id)data {
        
    WeatherRootModel *rootModel = [[WeatherRootModel alloc] initWithDictionary:data];
        
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

- (void) requestFailedWithError:(NSError *)error {



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

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.headerView searchBarResignFirstResponder];
    
}


@end
