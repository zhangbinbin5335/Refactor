//
//  XNUserTradePercentView.h
//  calftrader
//
//  Created by 张彬彬 on 2017/7/12.
//  Copyright © 2017年 宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
  用户买张涨跌比率展示
 */
@interface XNUserTradePercentView : UIView

@property (nonatomic, assign) CGFloat buyupPercent; // 用户买涨比率，default .5
@property (nonatomic, copy) NSString *title;

- (void)startAnimation;

@end
