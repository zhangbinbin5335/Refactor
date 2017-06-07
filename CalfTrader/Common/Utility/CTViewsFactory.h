//
//  CTViewsFactory.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 UILabel、 UIButton的工厂方法
 */
@interface CTViewsFactory : NSObject

+(UILabel*)ct_label;
+(UILabel*)ct_labelWithText:(NSString*)text;
+(UILabel*)ct_labelWithText:(NSString*)text textColor:(UIColor*)textColor;

/**
 UILabel 工厂方法

 @param text 显示文字
 @param textColor 文字颜色
 @param font 字体
 @return UILabel 对象
 */
+(UILabel*)ct_labelWithText:(NSString*)text textColor:(UIColor*)textColor font:(UIFont*)font;

@end
