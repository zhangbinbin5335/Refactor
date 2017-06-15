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
#import "CTCycleView.h"
#import "CTHmBannerCell.h"
#import "CTHmPgMarketCell.h"

@interface CTHomePageController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *newsTableView; // 新闻展示
@property (nonatomic, strong) CTCycleView *flashView; // 顶部轮播view
@property (nonatomic, strong) CTCycleView *bannerView; // 顶部banner view
@property (nonatomic, strong) CTCycleView *marketView; // 顶部市场信息view
@property (nonatomic, strong) CTHmPgNewsPresenter *presenter;
@property (nonatomic, strong) NSTimer *loopRequestTimer;

@end

@implementation CTHomePageController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    [self requestNewsInfo];
    [self requestFlashViewInfo];
    [self requestBannerInfo];
    [self requesetMarketInfo];
    
    // 每隔一秒刷新market数据
    [self startLoopRequestMarketInfo:1];
}

-(void)dealloc{
    [self stopLoopRequestMarketInfo];
}
#pragma mark - 🔒private
-(void)initSubViews{
    [self.view addSubview:self.newsTableView];
    
    UIView *tableHeaderView = [self configTableHeaderView];
    self.newsTableView.tableHeaderView = tableHeaderView;
    
    __weak typeof(self) weakSelf = self;
    [self.newsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-44);
    }];
}

-(UIView *)configTableHeaderView{
    UIView *tableHeaderView = [[UIView alloc]init];
    
    [tableHeaderView addSubview:self.flashView];
    [tableHeaderView addSubview:self.bannerView];
    [tableHeaderView addSubview:self.marketView];
    
    CGFloat bannerWidth = (self.view.ct_width) / 4.;
    
    CGFloat marketItemSpace = 5;
    CGFloat marketHSpace = 20;
    CGFloat marketWidth = (self.view.ct_width - marketItemSpace * 4 - 30) / 3.;
    self.marketView.flowLayout.minimumLineSpacing = marketItemSpace;
    self.marketView.flowLayout.footerReferenceSize = CGSizeMake(marketItemSpace,
                                                                marketWidth - marketHSpace);
    self.marketView.flowLayout.headerReferenceSize = CGSizeMake(marketItemSpace,
                                                                marketWidth - marketHSpace);
    
    self.bannerView.itemSize = ^(CTCycleView *cycleView){
        return CGSizeMake(bannerWidth, bannerWidth);
    };
    
    self.marketView.itemSize = ^CGSize(CTCycleView *cycleView) {
        return CGSizeMake(marketWidth, marketWidth - marketHSpace);
    };
    
    self.flashView.frame = CGRectMake(0, 0, self.view.ct_width, 200);
    self.bannerView.frame = CGRectMake(0, 200, self.view.ct_width, bannerWidth);
    self.marketView.frame = CGRectMake(0,
                                       CGRectGetMaxY(self.bannerView.frame),
                                       self.view.ct_width,
                                       marketWidth);
    tableHeaderView.frame = CGRectMake(0,
                                       0,
                                       self.view.ct_width,
                                       self.marketView.ct_y + self.marketView.ct_height);
    
    return tableHeaderView;
}

-(void)requestNewsInfo{
    typeof(self) weakSelf = self;
    
    [self.presenter requestNewsInfoCompletion:^(NSArray *response, NSError *error) {
        if (!error) {
            [weakSelf.newsTableView reloadData];
        }
    }];
}

-(void)requestBannerInfo{
    typeof(self) weakSelf = self;
    
    [self.presenter requestBannerInfoCompletion:^(NSArray *response, NSError *error) {
        if (!error) {
            weakSelf.bannerView.dataSource = response;
        }
    }];
}

-(void)requesetMarketInfo{
    typeof(self) weakSelf = self;
    
    [self.presenter requesetMarketInfoCompletion:^(NSArray *response, NSError *error) {
        if (!error) {
            weakSelf.marketView.dataSource = response;
        }
    }];
}

-(void)startLoopRequestMarketInfo:(NSTimeInterval)timeInterval{
    if (_loopRequestTimer) {
        [_loopRequestTimer invalidate];
        _loopRequestTimer = nil;
    }
    _loopRequestTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                         target:self
                                                       selector:@selector(requesetMarketInfo)
                                                       userInfo:nil
                                                        repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_loopRequestTimer forMode:NSRunLoopCommonModes];
}

-(void)stopLoopRequestMarketInfo{
    if (_loopRequestTimer) {
        [_loopRequestTimer invalidate];
        _loopRequestTimer = nil;
    }
}

-(void)requestFlashViewInfo{
    typeof(self) weakSelf = self;
    
    [self.presenter requestFlashViewInfoCompletion:^(id response, NSError *error) {
        weakSelf.flashView.dataSource = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496933469041&di=5c0f77e9c47025370a8d83aeebba872e&imgtype=0&src=http%3A%2F%2Fwww.liangtupian.com%2Fuploads%2Fmv%2F20150416%2F2015041622073712228.jpg",
                                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496933470203&di=12c9280476a1dd65fd6c170fc3c5525a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F3%2Fe9%2F72821378027.jpg",
                                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496933470202&di=139c6281531319f29c90a616f694aed7&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F150%2F35%2F542TBW786509.jpg"];
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
-(UITableView *)newsTableView{
    if (!_newsTableView) {
        _newsTableView = [[UITableView alloc] init];
        _newsTableView.delegate = self;
        _newsTableView.dataSource = self;
    }
    
    return _newsTableView;
}

-(CTCycleView *)flashView{
    if (!_flashView) {
        _flashView = [[CTCycleView alloc] init];
    }
    
    return _flashView;
}

-(CTCycleView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[CTCycleView alloc] init];
        _bannerView.loop = NO;
        _bannerView.pageHide = YES;
        [_bannerView registerClass:[CTHmBannerCell class]];
        _bannerView.cellAtIndexPath = ^UICollectionViewCell *(NSIndexPath *indexPath,
                                                            UICollectionView *collectionView,
                                                            NSString *cellID) {
            CTHmBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                           forIndexPath:indexPath];
            if (!cell) {
                cell = [[CTHmBannerCell alloc]init];
            }
            return cell;
        };
    }
    
    return _bannerView;
}

-(CTCycleView *)marketView{
    if (!_marketView) {
        _marketView = [[CTCycleView alloc] init];
        _marketView.loop = NO;
        _marketView.pageHide = YES;
        _marketView.backgroundColor = [UIColor lightGrayColor];
        [_marketView registerClass:[CTHmPgMarketCell class]];
        _marketView.cellAtIndexPath = ^UICollectionViewCell *(NSIndexPath *indexPath,
                                                              UICollectionView *collectionView,
                                                              NSString *cellID) {
            CTHmPgMarketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                               forIndexPath:indexPath];
            if (!cell) {
                cell = [[CTHmPgMarketCell alloc]init];
            }
            return cell;
        };
    }
    
    return _marketView;
}

-(CTHmPgNewsPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[CTHmPgNewsPresenter alloc] init];
    }
    
    return _presenter;
}

@end
