//
//  CTFlashView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/8.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTFlashView.h"

static NSString *const kCellID = @"flashViewCellID";

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

@interface CTFlashView ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *contentView; // 轮播用

@end

@implementation CTFlashView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.contentView];
        __weak typeof(self) weakSelf = self;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(weakSelf);
        }];
    }
    
    return self;
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark -- delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTFlashViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID
                                                                      forIndexPath:indexPath];
    if (!cell) {
        cell = [[CTFlashViewCell alloc]init];
    }
    
    NSString *urlString = self.dataSource[indexPath.item];
    
    [cell.thumbImageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                           placeholderImage:nil];
    
    return cell;
}

// UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.ct_width, collectionView.ct_height);
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
    }
    
    return _contentView;
}

-(void)setDataSource:(NSArray *)dataSource{
    if ([_dataSource isEqualToArray:dataSource]) {
        return;
    }
    _dataSource = dataSource;
    [_contentView reloadData];
}
@end
