//
//  CTHmPgNewsInputView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/26.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsInputView.h"
#import "CTTextView.h"

static const CGFloat kOffSet = 5;

@interface CTHmPgNewsInputView ()

@property (nonatomic, strong) CTTextView *textView;

@end

@implementation CTHmPgNewsInputView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kOffSet * 2);
            make.right.equalTo(self).offset(-kOffSet * 2);
            make.top.equalTo(self).offset(kOffSet);
            make.bottom.equalTo(self).offset(-kOffSet);
        }];
    }
    
    return self;
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - ☸getter and setter
-(CTTextView *)textView{
    if (!_textView) {
        _textView = [[CTTextView alloc] init];
        _textView.placeholder = @"楼主说的怎么样，点评一下吧!";
        _textView.layer.cornerRadius = 10;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    return _textView;
}

@end
