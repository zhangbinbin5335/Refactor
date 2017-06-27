//
//  CTTextView.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/26.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 自定义TextView
 增加Placeholder属性
 */
@interface CTTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;

@end
