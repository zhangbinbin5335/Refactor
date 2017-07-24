//
//  CTPageIndicatorView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/7/21.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTPageIndicatorView.h"
#import "CTBadgeButton.h"
static NSString *const kCTPageIndicatorViewCellID = @"kCTPageIndicatorViewCellID";

@interface CTIndicatorCell : UICollectionViewCell

@property (nonatomic, strong) CTBadgeButton *badgeButton;

@end

@implementation CTIndicatorCell

#pragma mark - 🔄overwrite
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.badgeButton.selected = selected;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.badgeButton];
        [self.badgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (CTBadgeButton *)badgeButton{
    if (!_badgeButton) {
        _badgeButton = [CTBadgeButton buttonWithType:UIButtonTypeCustom];
        [_badgeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_badgeButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _badgeButton.userInteractionEnabled = NO;
    }
    
    return _badgeButton;
}

@end

@interface CTPageIndicatorView ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *separateLine;

@end

@implementation CTPageIndicatorView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.collectionView];
        [self addSubview:self.separateLine];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.bottom.equalTo(self).offset(-1);
            make.height.mas_equalTo(1);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    
    return self;
}

#pragma mark - 🔒private
- (void)updateSeparateLineFrameWithIndex:(NSInteger)index{
    CGFloat cellWidth = _collectionView.ct_width / _dataSource.count;
    CGPoint separateCenter = _separateLine.center;
    separateCenter.x = (index + 1) * cellWidth - cellWidth / 2.;
    _separateLine.center = separateCenter;
}
#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTIndicatorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCTPageIndicatorViewCellID
                                                                      forIndexPath:indexPath];
    NSDictionary *badgeInfo = self.dataSource[indexPath.item];
    cell.badgeButton.badgeText = badgeInfo[@"badge"];
    [cell.badgeButton setTitle:badgeInfo[@"title"] forState:UIControlStateNormal];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectCompletion) {
        self.didSelectCompletion(indexPath.item);
    }
    [self updateSeparateLineFrameWithIndex:indexPath.item];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(collectionView.ct_width / self.dataSource.count, collectionView.ct_height);
}

#pragma mark - ☸getter and setter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        // layout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:flowLayout];
        
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CTIndicatorCell class]
         forCellWithReuseIdentifier:kCTPageIndicatorViewCellID];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
}

- (UILabel *)separateLine{
    if (!_separateLine) {
        _separateLine = [[UILabel alloc] init];
        _separateLine.backgroundColor = [UIColor redColor];
    }
    
    return _separateLine;
}

-(void)setDataSource:(NSArray<NSDictionary *> *)dataSource{
    _dataSource = dataSource;
    [_collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex > _dataSource.count -1) {
        return;
    }
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [_collectionView selectItemAtIndexPath:selectIndexPath
                                  animated:YES
                            scrollPosition:UICollectionViewScrollPositionNone];
    [self updateSeparateLineFrameWithIndex:selectedIndex];
}

@end
