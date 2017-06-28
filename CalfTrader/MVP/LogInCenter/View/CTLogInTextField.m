//
//  CTLogInTextField.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/28.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTLogInTextField.h"

static const CGFloat kLeftImageWidth = 24;
static const CGFloat kRightButtonWidth = 100;
static const CGFloat kRightButtonHeight = 20;
static const CGFloat kCountDownSec = 60; // 单位秒

@interface CTLogInTextField ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *separatorLine;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSTimer* countDownTimer;
@property (nonatomic, assign) NSUInteger countDownSec;

@end

@implementation CTLogInTextField

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.leftView = self.leftImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:self.separatorLine];
        
        [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.bottom.equalTo(self.mas_bottom).offset(-2);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
        }];
        
        self.countDownSec = kCountDownSec;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return self;
}

-(void)dealloc{
    CTNLog(@"LogInInputTextField dealloc");
}
#pragma mark - 🔒private
// 设置输入框文字展示区域
-(CGRect)newRectForBounds:(CGRect)bounds{
    CGFloat offset = 5;
    CGRect leftRect = CGRectZero;
    CGRect rightRect = CGRectZero;
    
    if (self.leftView) {
        leftRect = self.leftView.frame;
    }
    
    if (self.rightView) {
        rightRect = self.rightView.frame;
    }
    
    return CGRectMake(bounds.origin.x + offset + leftRect.size.width,
                      bounds.origin.y,
                      bounds.size.width - offset - leftRect.size.width - rightRect.size.width,
                      bounds.size.height);
}
-(void)rightButtonClick:(UIButton*)button{
    if (_rightButtonClick) {
        _rightButtonClick();
    }
    [self.countDownTimer fire];
    button.enabled = NO;
    [button setTitle:@"60秒" forState:UIControlStateNormal];
}
-(void)counDown{
    --self.countDownSec;
    if (self.countDownSec == 0) {
        // 倒计时完毕
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        self.rightButton.enabled = YES;
        self.countDownSec = kCountDownSec;
        [self.rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        [self.rightButton setTitle:[NSString stringWithFormat:@"%lu秒",self.countDownSec]
                          forState:UIControlStateNormal];
    }
}
#pragma mark - 🔄overwrite
-(CGRect)textRectForBounds:(CGRect)bounds{
    return [self newRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return [self newRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return [self newRectForBounds:bounds];
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect rightRect = [super rightViewRectForBounds:bounds];
    return CGRectMake(bounds.size.width - kRightButtonWidth,
                      rightRect.origin.y,
                      kRightButtonWidth,
                      kRightButtonHeight);
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect leftRect = [super leftViewRectForBounds:bounds];
    return CGRectMake(leftRect.origin.x,
                      leftRect.origin.y,
                      kLeftImageWidth,
                      kLeftImageWidth);
}

#pragma mark - 🚪public
-(void)setLeftImage:(UIImage *)leftImage{
    if (_leftImageView && leftImage) {
        _leftImageView.image = leftImage;
    }
}

#pragma mark - ☸getter and setter
-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       kLeftImageWidth * ScaleX,
                                                                       kLeftImageWidth * ScaleX)];
        _leftImageView.image = [UIImage imageNamed:@"login_lock"];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _leftImageView;
}

-(UILabel *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = [[UILabel alloc] init];
        _separatorLine.backgroundColor = UIColorWithRGB(0xF0F0F0);
    }
    
    return _separatorLine;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  kRightButtonWidth * ScaleX,
                                                                  kRightButtonHeight * ScaleX)];
        [_rightButton setTitle:@"获取验证码"
                      forState:UIControlStateNormal];
        [_rightButton setTitleColor:UIColorWithRGB(0x5FBBFF)
                           forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14.];
        [_rightButton addTarget:self
                         action:@selector(rightButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
        _rightButton.enabled = NO;
        // 添加一条分割线
        UILabel* rightSeparatorLine = [[UILabel alloc]init];
        rightSeparatorLine.backgroundColor = UIColorWithRGB(0xF0F0F0);
        [_rightButton addSubview:rightSeparatorLine];
        [rightSeparatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_rightButton.mas_left).offset(0);
            make.top.equalTo(_rightButton.mas_top).offset(-5);
            make.bottom.equalTo(_rightButton.mas_bottom).offset(5);
            make.width.mas_equalTo(2);
        }];
    }
    
    return _rightButton;
}

-(NSTimer *)countDownTimer{
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                           target:self
                                                         selector:@selector(counDown)
                                                         userInfo:nil
                                                          repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_countDownTimer
                                    forMode:NSRunLoopCommonModes];
    }
    
    return _countDownTimer;
}

-(void)setRightButtonAppear:(BOOL)rightButtonAppear{
    if (rightButtonAppear) {
        self.rightView = self.rightButton;
        self.rightViewMode = UITextFieldViewModeAlways;
    }else{
        self.rightView = nil;
        self.rightButton = nil;
    }
}

-(void)setRightButtonEnble:(BOOL)rightButtonEnble{
    if (_rightButton) {
        _rightButton.enabled = rightButtonEnble;
    }
}

@end
