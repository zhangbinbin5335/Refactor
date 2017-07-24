//
//  CTBadgeButton.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/7/20.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 可以设置badge的button
 */
@interface CTBadgeButton : UIButton

@property (nonatomic, copy) NSString *badgeText;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, strong) UIColor *badgeBackColor;
@property (nonatomic, assign) CGFloat minBadgeWidth; // badge 最小宽,default 15

@end
