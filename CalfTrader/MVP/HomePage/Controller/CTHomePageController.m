//
//  CTHomePageController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHomePageController.h"
#import "CTHmPgNewsCell.h"
#import "CTHmPgNewsPresenter.h"
#import "CTFlashView.h"

@interface CTHomePageController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; // 新闻展示
@property (nonatomic, strong) CTFlashView *flashView; // 顶部轮播view
@property (nonatomic, strong) CTHmPgNewsPresenter *presenter;

@end

@implementation CTHomePageController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    [self requestNewsInfo];
}

#pragma mark - 🔒private
-(void)initSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.flashView;
    self.flashView.frame = CGRectMake(0, 0, self.view.ct_width, 100);
    
    self.flashView.dataSource = @[@"http://new.xnsudai.com/systemCenter/c2078da09d6c4345bf03c932da7db312.jpg",
                                  @"http://new.xnsudai.com/systemCenter/b1829cff33184f1995777fa6ce948586.png",
                                  @"http://new.xnsudai.com/systemCenter/0c9cfc3edf1c4541841e5b55fa32be35.png"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
}

-(void)requestNewsInfo{
    typeof(self) weakSelf = self;
    
    [self.presenter requestNewsInfoCompletion:^(NSArray *response, NSError *error) {
        if (!error) {
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.presenter.newsInfo.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTHmPgNewsCell *cell = [CTHmPgNewsCell cellWithTableView:tableView];
    [cell fillData:self.presenter.newsInfo[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self requestNewsInfo];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 100;
}
#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

-(CTFlashView *)flashView{
    if (!_flashView) {
        _flashView = [[CTFlashView alloc] init];
    }
    
    return _flashView;
}

-(CTHmPgNewsPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[CTHmPgNewsPresenter alloc] init];
    }
    
    return _presenter;
}

@end
