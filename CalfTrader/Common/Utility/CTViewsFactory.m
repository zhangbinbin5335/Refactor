//
//  CTViewsFactory.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTViewsFactory.h"

@implementation CTViewsFactory
// UILabel
+(UILabel *)ct_label{
    return [self ct_labelWithText:@""];
}
+(UILabel *)ct_labelWithText:(NSString *)text{
    return [self ct_labelWithText:text textColor:[UIColor lightGrayColor]];
}
+(UILabel *)ct_labelWithText:(NSString *)text textColor:(UIColor *)textColor{
    return [self ct_labelWithText:text textColor:textColor font:[UIFont systemFontOfSize:14.0]];
}

+(UILabel *)ct_labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;

    return label;
}

@end
