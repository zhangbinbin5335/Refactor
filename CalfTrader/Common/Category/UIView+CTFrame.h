//
//  UIView+CTFrame.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CTFrame)

//
@property (nonatomic, assign) CGFloat ct_top;
@property (nonatomic, assign) CGFloat ct_left;
@property (nonatomic, assign) CGFloat ct_right;
@property (nonatomic, assign) CGFloat ct_bottom;
// frame
@property (nonatomic, assign) CGFloat ct_x;
@property (nonatomic, assign) CGFloat ct_y;
@property (nonatomic, assign) CGFloat ct_width;
@property (nonatomic, assign) CGFloat ct_height;
@end
