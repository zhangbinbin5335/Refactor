//
//  CTInvestmentController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTInvestmentController.h"
#import "CTRefreshView.h"
#import "XNUserTradePercentView.h"

@interface CTInvestmentController ()

@end

@implementation CTInvestmentController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CTRefreshView *refreshView = [[CTRefreshView alloc]initWithFrame:CGRectMake(100, 120, 200, 100)];
    
    [self.view addSubview:refreshView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshView startAnimation];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshView stopAnimation];
    });
    
    XNUserTradePercentView *rercentView = [[XNUserTradePercentView alloc]initWithFrame:CGRectMake(100, 230, 300, 100)];
//    rercentView.backgroundColor = [UIColor yellowColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        rercentView.buyupPercent = 0.7;
        rercentView.title = @"title";
        [rercentView startAnimation];
    });
    
    [self.view addSubview:rercentView];
    
    UILabel *htLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 330, 300, 20)];
    htLabel.font = [UIFont fontWithName:@"Heiti SC" size:24];
    htLabel.text = @"￥";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 350, 300, 20)];
    label.font = [UIFont systemFontOfSize:24];
    label.text = @"￥";
    
    [self.view addSubview:htLabel];
    [self.view addSubview:label];
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter

@end
