//
//  CTHmPgNewsInputView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/26.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsInputView.h"

@interface CTHmPgNewsInputView ()

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation CTHmPgNewsInputView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textView];
        [self.textView addSubview:self.placeholderLabel];
    }
    
    return self;
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - ☸getter and setter

@end
