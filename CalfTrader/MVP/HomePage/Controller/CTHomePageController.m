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
    self.flashView.frame = CGRectMake(0, 0, self.view.ct_width, 200);
    
    self.flashView.dataSource = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496933469041&di=5c0f77e9c47025370a8d83aeebba872e&imgtype=0&src=http%3A%2F%2Fwww.liangtupian.com%2Fuploads%2Fmv%2F20150416%2F2015041622073712228.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496933470203&di=12c9280476a1dd65fd6c170fc3c5525a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F3%2Fe9%2F72821378027.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496933470202&di=139c6281531319f29c90a616f694aed7&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F150%2F35%2F542TBW786509.jpg"];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"最新消息";
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
