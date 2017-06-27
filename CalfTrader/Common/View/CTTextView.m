//
//  CTTextView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/26.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTTextView.h"

@interface CTTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation CTTextView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.placeholderLabel];
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(inputDidChange:)
                                                    name:UITextViewTextDidChangeNotification
                                                  object:nil];
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)layoutSubviews{
    self.placeholderLabel.frame = self.bounds;
    [self inputDidChange:nil];
}

#pragma mark - 🔒private
-(void)inputDidChange:(NSNotification*)noti{
    if (self.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    }else{
        [self.placeholderLabel sizeToFit];
        CGPoint cursorPosition = [self caretRectForPosition:self.selectedTextRange.end].origin;
        self.placeholderLabel.ct_x = cursorPosition.x;
        self.placeholderLabel.ct_y = cursorPosition.y / 2.;
        self.placeholderLabel.hidden = NO;
    }
}

#pragma mark - 🔄overwrite
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    _placeholderLabel.font = font;
}

#pragma mark - 🚪public

#pragma mark - ☸getter and setter
-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.numberOfLines = 0;
    }
    
    return _placeholderLabel;
}

-(void)setPlaceholder:(NSString *)placeholder{
    if ([_placeholder isEqualToString:placeholder]) {
        return;
    }
    _placeholder = [placeholder copy];
    _placeholderLabel.text = _placeholder;
    [self inputDidChange:nil];
}

@end


