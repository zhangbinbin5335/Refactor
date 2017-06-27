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
#import "CTHmPgNewsCommetnCell.h"
#import "CTHmPgNwsDtalHdrView.h"
#import "CTHmPgNewsInputView.h"

@interface CTHmPgNewsDetailVC ()

@property (nonatomic, strong) CTHmPgNewsDetailPresenter *presenter;
@property (nonatomic, strong) CTHmPgNewsInputView *commentInputView; // 评论view

@end

@implementation CTHmPgNewsDetailVC

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillAppear:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    
    [self initSubViews];
    [self requestNewsDetailInfo];
}

#pragma mark - 🔒private
-(void)keyboardWillAppear:(NSNotification*)noti{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView scrollRectToVisible:[self.tableView convertRect:self.tableView.tableFooterView.bounds
                                                               fromView:self.tableView.tableFooterView]
                                   animated:YES];
    });
}
-(void)initSubViews{
    [self configTableFooterView];
}

-(void)configTableHeaderView{
    if (self.presenter.newsDetailArray.count > 0 ) {
        CTHmPgNwsDtalHdrView *headerView = [[CTHmPgNwsDtalHdrView alloc]initWithFrame:CGRectMake(0,
                                                                                                 0,
                                                                                                 self.view.ct_width,
                                                                                                 80)];
        CTHmPgNewsDetailModel *model = self.presenter.newsDetailArray[0];
        [headerView fillData:model];
        self.tableView.tableHeaderView = headerView;
    }else{
        self.tableView.tableHeaderView = nil;
    }
}

-(void)configTableFooterView{
    self.commentInputView.frame = CGRectMake(0,
                                             0,
                                             self.view.ct_width,
                                             44);
    self.tableView.tableFooterView = self.commentInputView;
}

-(void)requestNewsDetailInfo{
    __weak typeof(self) weakSelf = self;
    [self.presenter requestNewsInfo:self.informationId completion:^(id response, NSError *error) {
        if (response) {
            [weakSelf configTableHeaderView];
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
        return self.presenter.commentArray.informationComment.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CTHmPgNewsDetailCell *cell = [CTHmPgNewsDetailCell cellWithTableView:tableView];
        [cell fillData:self.presenter.newsDetailArray[indexPath.item]];
        
        return cell;
    }else{
        CTHmPgNewsCommetnCell *cell = [CTHmPgNewsCommetnCell cellWithTableView:tableView];
        [cell fillData:self.presenter.commentArray.informationComment[indexPath.item]];
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

-(CTHmPgNewsInputView *)commentInputView{
    if (!_commentInputView) {
        _commentInputView = [[CTHmPgNewsInputView alloc] init];
    }
    
    return _commentInputView;
}


@end
