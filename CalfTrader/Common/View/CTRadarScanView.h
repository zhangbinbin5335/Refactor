//
//  CTRadarScanView.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/16.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 雷达扫描动画
 */
@interface CTRadarScanView : UIView

/**
 开始动画，循环播放
 */
-(void)startAnimate;


/**
 停止动画
 */
-(void)stopAnimate;

@end
