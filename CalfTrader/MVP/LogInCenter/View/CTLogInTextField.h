//
//  CTLogInTextField.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/28.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTLogInTextField : UITextField

// 设置是否显示输入框右侧按钮
@property (nonatomic, assign) BOOL rightButtonAppear; // default NO
@property (nonatomic, assign) BOOL rightButtonEnble; // default NO
// 右侧按钮点击事件回调
@property (nonatomic, copy) void(^rightButtonClick)();
// 设置输入框左边展示图片，默认是"login_phone"
@property (nonatomic, strong) UIImage *leftImage;

@end
