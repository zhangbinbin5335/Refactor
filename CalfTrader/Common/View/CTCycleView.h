//
//  CTFlashView.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/8.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ CTCycleViewDidSelectCompletion)(NSUInteger index); // 被选中cell的index
typedef UICollectionViewCell *(^ CTCycleViewCellAtIndexPath)(NSIndexPath *indexPath,
                                                            UICollectionView *collectionView); // 自定义cell


/**
 这是一个假的循环collectionView，只是默认设置了100个section，也就是有100组一样的广告。
 初始化时，将展示页面滚动到第50组，每次自动滚动，都将重置到第50组，中间位置来。只要用户不会往左或右滑动50组广告就没问题。
 如果关闭auto play，且用户往左或往右滑动50组广告，就不能再往左或右滚动了。
 */
@interface CTCycleView : UIView

@property (nonatomic, strong) NSArray<NSString *> *dataSource; // 数据源,封面图片链接
@property (nonatomic, assign) BOOL autoPlay; // default YES;
@property (nonatomic, assign) BOOL loop; // 是否循环，default YES
@property (nonatomic, assign) NSTimeInterval showTime; // 展示时间，default 3秒
@property (nonatomic, copy) CTCycleViewDidSelectCompletion didSelectCompletion;

/**
 默认展示是一张图片
 通过这个属性，可以自定义cell样式
 */
@property (nonatomic, copy) CTCycleViewCellAtIndexPath cellAtIndexPath;

@end
