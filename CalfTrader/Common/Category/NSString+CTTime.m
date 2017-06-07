//
//  NSString+CTTime.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "NSString+CTTime.h"

@implementation NSString (CTTime)
+(NSString *)convertTimeString:(NSString *)time{
    if (time) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *timeDate = [dateFormatter dateFromString:time];
        if (timeDate == nil) {
            return @"";
        }
        NSCalendar *calender = [NSCalendar currentCalendar];
        if ([calender isDateInToday:timeDate]) {
            dateFormatter.dateFormat = @"HH:mm";
        }else if ([calender isDateInYesterday:timeDate]) {
            dateFormatter.dateFormat = @"昨天";
        }else {
            dateFormatter.dateFormat = @"MM-dd";
        }
        NSString *result = [dateFormatter stringFromDate:timeDate];
        return result;
    }else{
        return @"";
    }
}

@end
