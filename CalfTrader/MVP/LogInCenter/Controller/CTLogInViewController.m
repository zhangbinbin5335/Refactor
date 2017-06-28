//
//  CTLogInViewController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/28.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTLogInViewController.h"
/* custom view */
#import "CTLogInTextField.h"
#import "CTLinkView.h"

@interface CTLogInViewController ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) CTLogInTextField *phoneNumTextField; // 手机号输入
@property (nonatomic, strong) CTLogInTextField *verifyCodeTextField; // 验证码输入
@property (nonatomic, strong) CTLinkView *messagePrompt; // 语音验证码提示
@property (nonatomic, strong) CTLinkView *delegatePrompt; // 协议提示
@property (nonatomic, strong) UIButton *agreeButton; // 用户同意按钮
@property (nonatomic, strong) UIButton *nextButton; // 下一步按钮
@property (nonatomic, strong) UIButton *skipLoginButton; // 跳过登录注册

@end

@implementation CTLogInViewController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
}

#pragma mark - 🔒private
-(void)configSubViews{
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.verifyCodeTextField];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.messagePrompt];
    [self.view addSubview:self.delegatePrompt];
    [self.view addSubview:self.agreeButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.skipLoginButton];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    CGFloat offset = 40;
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(offset);
        make.left.equalTo(self.logoImageView).offset(offset / 2.);
        make.right.equalTo(self.logoImageView).offset(-offset / 2.);
        make.height.mas_equalTo(44);
    }];
    [self.verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneNumTextField);
        make.top.equalTo(self.phoneNumTextField.mas_bottom).offset(offset / 4.);
    }];
    [self.messagePrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.verifyCodeTextField);
        make.top.equalTo(self.verifyCodeTextField.mas_bottom);
        make.bottom.equalTo(self.delegatePrompt.mas_top).offset(-offset);
    }];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messagePrompt);
        make.width.mas_equalTo(23);
        make.top.equalTo(self.delegatePrompt).offset(6);
        make.height.mas_equalTo(23);
    }];
    [self.delegatePrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.verifyCodeTextField);
        make.bottom.equalTo(self.nextButton.mas_top).offset(-offset / 2.);
        make.left.equalTo(self.agreeButton.mas_right);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.verifyCodeTextField);
        make.height.mas_equalTo(60);
    }];
    [self.skipLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view).offset(-offset / 4.);
    }];
    
}

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter
-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"login_head"];
    }
    
    return _logoImageView;
}

-(CTLogInTextField *)phoneNumTextField{
    if (!_phoneNumTextField) {
        _phoneNumTextField = [[CTLogInTextField alloc] init];
        _phoneNumTextField.placeholder = @"请输入手机号";
        _phoneNumTextField.leftImage = [UIImage imageNamed:@"login_phone"];
    }
    
    return _phoneNumTextField;
}

-(CTLogInTextField *)verifyCodeTextField{
    if (!_verifyCodeTextField) {
        _verifyCodeTextField = [[CTLogInTextField alloc] init];
        _verifyCodeTextField.placeholder = @"验证码";
        _verifyCodeTextField.rightButtonAppear = YES;
    }
    
    return _verifyCodeTextField;
}

-(CTLinkView *)messagePrompt{
    if (!_messagePrompt) {
        _messagePrompt = [[CTLinkView alloc] init];
        NSString *content = @"没收到验证码 ？请尝试获取";
        NSString *linkStr = @"语音验证码";
        _messagePrompt.content = [content stringByAppendingString:linkStr];
        [_messagePrompt addLink:NSMakeRange(content.length, linkStr.length) click:^(NSString *linkText) {
           // TODO : 语音验证码请求
            CTNLog(@"语音验证码");
        }];
        _messagePrompt.contentColor = [UIColor lightGrayColor];
        _messagePrompt.linkColor = [UIColor greenColor];
        _messagePrompt.contentFont = [UIFont systemFontOfSize:14.];
    }
    
    return _messagePrompt;
}

-(CTLinkView *)delegatePrompt{
    if (!_delegatePrompt) {
        _delegatePrompt = [[CTLinkView alloc] init];
        _delegatePrompt.content = @"我已阅读《风险告知书》并同意《小牛智投平台服务协议》";
        [_delegatePrompt addLink:NSMakeRange(4, 7) click:^(NSString *linkText) {
            // TODO : 打开风险告知书
            CTNLog(@"《风险告知书》");
        }];
        [_delegatePrompt addLink:NSMakeRange(14, 12) click:^(NSString *linkText) {
           // TODO : 打开服务协议
            CTNLog(@"《小牛智投平台服务协议》");
        }];
        _delegatePrompt.contentColor = [UIColor lightGrayColor];
        _delegatePrompt.linkColor = [UIColor greenColor];
        _delegatePrompt.contentFont = [UIFont systemFontOfSize:14.];
    }
    
    return _delegatePrompt;
}

-(UIButton *)agreeButton{
    if (!_agreeButton) {
        _agreeButton = [[UIButton alloc] init];
        [_agreeButton setImage:[UIImage imageNamed:@"login_disagree"] forState:UIControlStateNormal];
        [_agreeButton setImage:[UIImage imageNamed:@"login_agree"] forState:UIControlStateSelected];
        _agreeButton.selected = YES;
    }
    
    return _agreeButton;
}

-(UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _nextButton;
}

-(UIButton *)skipLoginButton{
    if (!_skipLoginButton) {
        _skipLoginButton = [[UIButton alloc] init];
        [_skipLoginButton setTitle:@"快速浏览》" forState:UIControlStateNormal];
        [_skipLoginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    return _skipLoginButton;
}

@end
