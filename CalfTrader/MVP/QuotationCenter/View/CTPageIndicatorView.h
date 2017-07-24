//
//  CTPageIndicatorView.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/7/21.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTPageIndicatorView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataSource; // key : badge、title
@property (nonatomic, copy) void(^didSelectCompletion)(NSInteger index);

@end
