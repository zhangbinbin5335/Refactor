//
//  CTHmPgNewsDetailVC.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/15.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsDetailVC.h"
#import "CTHmPgNewsDetailPresenter.h"
#import "CTHmPgNewsDetailCell.h"

@interface CTHmPgNewsDetailVC ()

@property (nonatomic, strong) CTHmPgNewsDetailPresenter *presenter;

@end

@implementation CTHmPgNewsDetailVC

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self initSubViews];
    [self requestNewsDetailInfo];
}

#pragma mark - 🔒private
-(void)initSubViews{
}

-(void)requestNewsDetailInfo{
    __weak typeof(self) weakSelf = self;
    [self.presenter requestNewsInfo:self.informationId completion:^(id response, NSError *error) {
        if (response) {
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.presenter.newsDetailArray.count;
    }else{
        return 50;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CTHmPgNewsDetailCell *cell = [CTHmPgNewsDetailCell cellWithTableView:tableView];
        [cell fillData:self.presenter.newsDetailArray[indexPath.item]];
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString
                               stringWithFormat:@"section = %ld, item = %ld",(long)indexPath.section,indexPath.item];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"全部评论";
    }
    
    return nil;
}

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter
-(CTHmPgNewsDetailPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[CTHmPgNewsDetailPresenter alloc] init];
    }
    
    return _presenter;
}


@end
