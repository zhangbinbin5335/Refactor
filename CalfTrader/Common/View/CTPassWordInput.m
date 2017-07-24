//
//  CTPassWordTextField.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/7/24.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTPassWordInput.h"

@interface CTPassWordLabel : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) BOOL selected;

@end

@implementation CTPassWordLabel
#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
        [self addSubview:self.line];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(2);
            make.bottom.equalTo(self).offset(-2);
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20 * ScaleX);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.line.mas_top).offset(-15 * ScaleX);
        }];
        self.label.layer.cornerRadius = 20 * ScaleX / 2.;
        self.label.layer.masksToBounds = YES;
    }
    
    return self;
}

#pragma mark - ☸getter and setter
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor blackColor];
        _label.textColor = [UIColor blackColor];
        _label.hidden = YES;
    }
    
    return _label;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIColorWithRGB(0xB2B2B2);
    }
    
    return _line;
}

- (void)setSelected:(BOOL)selected{
    if (selected) {
        _line.backgroundColor = [UIColor blackColor];
    }else{
        _line.backgroundColor = UIColorWithRGB(0xB2B2B2);
    }
}

- (void)setText:(NSString *)text{
    if (text == nil || text.length == 0) {
        _label.hidden = YES;
    }else{
        _label.hidden = NO;
    }
    _text = [text copy];
}

@end

@interface CTPassWordInput ()
<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray <CTPassWordLabel *>*passwordLabelArray;
@property (nonatomic, strong) CAShapeLayer *cursorLayer;

@end

@implementation CTPassWordInput

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.passwordCount = 6;
        [self addPasswordLabelWithCount:self.passwordCount];
        [self addSubview:self.textField];
        [self.layer addSublayer:self.cursorLayer];
    }
    
    return self;
}

#pragma mark - 🔄overwrite
- (void)layoutSubviews{
    self.textField.frame = self.bounds;
    
    CGFloat passwordSpace = 10;
    CGFloat passwordWidth = (self.ct_width - passwordSpace) / self.passwordCount;
    
    for (NSInteger index = 0; index < self.passwordLabelArray.count; index++) {
        CTPassWordLabel *label = [self.passwordLabelArray objectAtIndex:index];
        CGRect labelRect = CGRectMake(index * passwordWidth + passwordSpace,
                                      0,
                                      passwordWidth - passwordSpace,
                                      self.ct_height);
        label.frame = labelRect;
    }
    [self bringSubviewToFront:self.textField];
    self.cursorLayer.frame = CGRectMake(-2, 0, 2, self.ct_height - 12 * ScaleX);
}

#pragma mark - 🔒private
- (void)removeAllPasswordLabel{
    for (UILabel *passwordLabel in self.passwordLabelArray) {
        [passwordLabel removeFromSuperview];
    }
    [self.passwordLabelArray removeAllObjects];
}

- (void)addPasswordLabelWithCount:(NSInteger)count{
    [self removeAllPasswordLabel];
    for (int labelCount = 0; labelCount < count; labelCount++) {
        CTPassWordLabel *passwordLabel = [[CTPassWordLabel alloc]init];
        [self addSubview:passwordLabel];
        [self.passwordLabelArray addObject:passwordLabel];
    }
}

- (void)textDidChange:(UITextField *)textField{
    NSInteger textLength = textField.text.length;
    NSString *text = textField.text;
    [self setText:[text substringWithRange:NSMakeRange(textLength - 1, 1)]
            index:textLength - 1];
    [self setSelected:YES index:textLength];
    [self setSelected:NO index:textLength - 1];
    
    if (text.length >= self.passwordCount) {
        CGRect layerFrame = self.cursorLayer.frame;
        layerFrame.origin.x = self.ct_width;
        self.cursorLayer.frame = layerFrame;
        [textField resignFirstResponder];
    }
}

- (void)setText:(NSString *)text index:(NSInteger)index{
    if (index < 0 ||
        index >= self.passwordLabelArray.count) {
        return;
    }
    
    CTPassWordLabel *passLabel = [self.passwordLabelArray objectAtIndex:index];
    passLabel.text = text;
}

- (void)setSelected:(BOOL)selected index:(NSInteger)index{
    if (index < 0 ||
        index >= self.passwordLabelArray.count) {
        return;
    }
    
    CTPassWordLabel *label = [self.passwordLabelArray objectAtIndex:index];
    if (selected) {
        CGRect layerFrame = self.cursorLayer.frame;
        layerFrame.origin.x = label.center.x;
        self.cursorLayer.frame = layerFrame;
    }

    label.selected = selected;
}

- (void)setCursorLayerAnimaiton{
    [self.cursorLayer removeAllAnimations];
    
    CABasicAnimation *hidenAnimation = [CABasicAnimation animationWithKeyPath:@"hidden"];
    hidenAnimation.repeatCount = FLT_MAX;
    hidenAnimation.duration = 1;
    hidenAnimation.fromValue = @(YES);
    hidenAnimation.toValue = @(NO);
    [self.cursorLayer addAnimation:hidenAnimation forKey:@"hidenAnimation"];
}

#pragma mark - 🚪public

#pragma mark - 🍐delegate
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    if (string.length == 0) {
        [self setSelected:NO index:textField.text.length];
        [self setText:@"" index:textField.text.length - 1];
        return YES;
    }
    
    if (textField.text.length >= self.passwordCount) {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self setSelected:YES index:textField.text.length];
    [self setCursorLayerAnimaiton];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.cursorLayer removeAllAnimations];
}
#pragma mark - ☸getter and setter
- (void)setPasswordCount:(NSInteger)passwordCount{
    if (_passwordCount == passwordCount) {
        return;
    }
    _passwordCount = passwordCount;
    [self addPasswordLabelWithCount:_passwordCount];
}

- (NSMutableArray<CTPassWordLabel *> *)passwordLabelArray{
    if (!_passwordLabelArray) {
        _passwordLabelArray = [[NSMutableArray alloc] init];
    }
    
    return _passwordLabelArray;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        [_textField addTarget:self
                       action:@selector(textDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        _textField.textColor = [UIColor clearColor];
        _textField.tintColor = [UIColor clearColor];
    }
    
    return _textField;
}

- (CAShapeLayer *)cursorLayer{
    if (!_cursorLayer) {
        _cursorLayer = [CAShapeLayer layer];
        _cursorLayer.backgroundColor = UIColorWithRGB(0x42A7F3).CGColor;
        _cursorLayer.hidden = YES;
    }
    
    return _cursorLayer;
}

- (NSString *)passwordText{
    NSString *password = _textField.text;
    if (password == nil ||
        password.length < _passwordCount) {
        return nil;
    }
    return password;
}

@end
