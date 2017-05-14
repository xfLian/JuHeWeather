//
//  WeatherHeaderView.m
//  JuHeWeather
//
//  Created by xf_Lian on 2017/5/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "WeatherHeaderView.h"

@interface WeatherHeaderView()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation WeatherHeaderView

- (void) buildView {
    
    self.backgroundColor = Color(199, 198, 204);
    
    //  创建搜索框
    {
        
        CGRect frame      = CGRectZero;
        frame.origin.x    = 0;
        frame.origin.y    = 20;
        frame.size.width  = View_Width;
        frame.size.height = 44;
        
        UISearchBar *searchBar = [[UISearchBar alloc]init];
        searchBar.frame        = frame;
        searchBar.delegate     = self;
        [searchBar setPlaceholder:@"请输入城市名"];
        [searchBar setTranslucent:YES];
        [searchBar setSearchTextPositionAdjustment:UIOffsetMake(2, 0)];
        [searchBar setShowsCancelButton:NO];
        [self addSubview:searchBar];
        self.searchBar = searchBar;
        
    }
    
}

//  已经开始进行编辑
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    
    
}

//  UISearchBar得到焦点并开始编辑时，执行该方法
- (BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES];
    
    return YES;
    
}

//  UISearchBar结束编辑时，执行该方法
- (BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO];
    
    return YES;
    
}

//  取消按钮的点击事件
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self searchBarResignFirstResponder];
    
}

//  在键盘中的搜索按钮的点击事件
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"searchBar --- %@",searchBar.text);
    
    NSString *cityNameURLEncode = [self cityNameStringToURLEncodeWithString:searchBar.text];
    
    [_delegate streatNetworkingWithCityName:cityNameURLEncode];
    
    [self searchBarResignFirstResponder];
    
}

//  转换URLEncode
- (NSString *) cityNameStringToURLEncodeWithString:(NSString *)string {
    
    NSString *cityNameURLEncode = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return cityNameURLEncode;
    
}

//  当搜索框中的内容发生改变时会自动进行搜索
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    
}

- (void) requestSucessWithData:(id)data; {
    
    
    
}

- (void) requestFailedWithError:(NSError *)error; {
    
    NSLog(@"没有数据");
    
}

- (void) searchBarResignFirstResponder {
    
    [self.searchBar resignFirstResponder];
    
}

@end
