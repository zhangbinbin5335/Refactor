//
//  CTFlashView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/8.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTCycleView.h"

static NSString *const kCellID = @"flashViewCellID";
static NSString *const kOverCellID = @"overFlashViewCellID";

static CGFloat kMaxSection = 100;

@interface CTFlashViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* thumbImageView; // 封面图片

@end

@implementation CTFlashViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.thumbImageView];
        [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
    }
    
    return self;
}

-(UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _thumbImageView;
}

@end

@interface CTCycleView ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *contentView; // 轮播用
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *loopTimer;

@end

@implementation CTCycleView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.contentView];
        [self addSubview:self.pageControl];
        
        __weak typeof(self) weakSelf = self;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(weakSelf);
        }];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
            make.height.mas_equalTo(10);
        }];
        
        self.autoPlay = YES;
        self.showTime = 3;
        self.dataSource = @[];
        self.loop = YES;
    }
    return self;
}

-(void)dealloc{
    [self stopLoopTimer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.dataSource.count > 0 && _autoPlay) {
        [self startLoopTimer];
    }else{
        [self stopLoopTimer];
    }
    
    if (self.dataSource.count > 0 &&
        self.contentView.contentOffset.x == 0) {
        [self.contentView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                     inSection:self.contentView.numberOfSections/2]
                                 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                         animated:NO];
    }
}
#pragma mark - 🔒private
-(NSIndexPath*)resetIndexPath{
    NSIndexPath *currentIndexPath = [[self.contentView indexPathsForVisibleItems]lastObject];
    // 回到中间
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForRow:currentIndexPath.item inSection:kMaxSection/2];
    [self.contentView scrollToItemAtIndexPath:currentIndexPathReset
                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                     animated:NO];
    return currentIndexPathReset;
}
-(void)loopScroll{
    if (!self.loop) {
        return;
    }
    // 这个循环播放赌的就是用户不会手动滚动kMaxSection／2 = 50次（组）广告;
    // 如果有脑残用户真的自己滑动看了50组一样的广告，那就没办法了。
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    
    // 如果当前section已经滚动到最后，则滚动到下一个section第一个。
    if (nextItem == self.dataSource.count) {
        nextItem = 0;
        nextSection ++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextItem inSection:nextSection];
    [self.contentView scrollToItemAtIndexPath:nextIndexPath
                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                     animated:YES];
}

-(void)startLoopTimer{
    [self stopLoopTimer];
    if (self.autoPlay) {
        _loopTimer = [NSTimer timerWithTimeInterval:self.showTime
                                             target:self
                                           selector:@selector(loopScroll)
                                           userInfo:nil
                                            repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.loopTimer forMode:NSRunLoopCommonModes];
    }
}

-(void)stopLoopTimer{
    if (self.loopTimer) {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
}
#pragma mark - 🔄overwrite

#pragma mark - 🚪public
-(void)registerClass:(Class)cellClass{
    [_contentView registerClass:cellClass
     forCellWithReuseIdentifier:kOverCellID];
}

#pragma mark -- delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.loop) {
        return kMaxSection;
    }
    
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellAtIndexPath) {
        UICollectionViewCell<CTCyleViewCellDelegate> *cell = _cellAtIndexPath(indexPath, collectionView, kOverCellID);
        [cell fillData:self.dataSource[indexPath.item]];
        
        return cell;
    }
    
    CTFlashViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID
                                                                      forIndexPath:indexPath];
    if (!cell) {
        cell = [[CTFlashViewCell alloc]init];
    }
    
    NSString *urlString = self.dataSource[indexPath.item];
    
    [cell.thumbImageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                           placeholderImage:self.placeholderImage];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_didSelectCompletion) {
        _didSelectCompletion(indexPath.item);
    }
}

// UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_itemSize) {
        return _itemSize(self);
    }
    return CGSizeMake(collectionView.ct_width, collectionView.ct_height);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopLoopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoPlay) {
        [self startLoopTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = 0;
    if (self.dataSource.count == 0) {
        self.pageControl.currentPage = page;
        return;
    }
    page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.dataSource.count;
    self.pageControl.currentPage = page;
}
#pragma mark - ☸getter and setter
-(UICollectionView *)contentView{
    if (!_contentView) {
        // layout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _contentView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:flowLayout];
        
        _contentView.collectionViewLayout = flowLayout;
        _contentView.delegate = self;
        _contentView.dataSource = self;
        [_contentView registerClass:[CTFlashViewCell class]
         forCellWithReuseIdentifier:kCellID];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.backgroundColor = [UIColor whiteColor];
        
        _flowLayout = flowLayout;
    }
    
    return _contentView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    
    return _pageControl;
}

-(void)setDataSource:(NSArray *)dataSource{
    if ([_dataSource isEqualToArray:dataSource]) {
        return;
    }
    _dataSource = dataSource;
    [_contentView reloadData];
    [_pageControl setNumberOfPages:dataSource.count];
    [self stopLoopTimer];
    [self startLoopTimer];
}

-(void)setAutoPlay:(BOOL)autoPlay{
    if (_autoPlay == autoPlay) {
        return;
    }
    _autoPlay = autoPlay;
    [self stopLoopTimer];
    [self startLoopTimer];
}

-(void)setShowTime:(NSTimeInterval)showTime{
    if (_showTime == showTime) {
        return;
    }
    
    if (showTime <= 0) {
        showTime = 1;
    }
    _showTime = showTime;
    [self stopLoopTimer];
    [self startLoopTimer];
}

-(void)setLoop:(BOOL)loop{
    if (_loop == loop) {
        return;
    }
    _loop = loop;
    [_contentView reloadData];
}

-(void)setPageHide:(BOOL)pageHide{
    if (_pageHide == pageHide) {
        return;
    }
    
    _pageControl.hidden = pageHide;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _contentView.backgroundColor = backgroundColor;
}

-(void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout{
    if ([_flowLayout isEqual:flowLayout]) {
        return;
    }
    _contentView.collectionViewLayout = _flowLayout;
    [_contentView reloadData];
}

@end
