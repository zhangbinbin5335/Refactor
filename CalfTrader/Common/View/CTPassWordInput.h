//
//  CTPassWordTextField.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/7/24.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTPassWordInput : UIView

@property (nonatomic, assign) NSInteger passwordCount; // 密码位数
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy, readonly) NSString *passwordText; // 用户输入的密码,如果小于passwordCount，返回nil

@end
