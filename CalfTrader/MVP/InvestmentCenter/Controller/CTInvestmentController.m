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
#import "CTPassWordInput.h"

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
    
    CTPassWordInput *textField = [[CTPassWordInput alloc]initWithFrame:CGRectMake(20, 340, 340, 80)];
    textField.passwordCount = 4;
    [self.view addSubview:textField];
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter

@end
