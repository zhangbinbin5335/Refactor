//
//  CTFlashView.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/8.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ CTFlashViewDidSelectCompletion)(NSUInteger index); // 被选中cell的index

@interface CTFlashView : UIView

@property (nonatomic, strong) NSArray<NSString *> *dataSource; // 数据源,封面图片链接
@property (nonatomic, assign) BOOL autoPlay; // default YES;
@property (nonatomic, assign) NSTimeInterval showTime; // 展示时间，default 3秒
@property (nonatomic, copy) CTFlashViewDidSelectCompletion didSelectCompletion;

@end
