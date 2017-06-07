//
//  NSString+CTTime.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CTTime)

/**
 将时间格式根据今天、昨天、其他转换成指定格式
 */
+(NSString*)convertTimeString:(NSString*)time;

@end
