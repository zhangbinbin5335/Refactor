//
//  CTBadgeButton.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/7/20.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTBadgeButton.h"

@interface CTBadgeButton ()

@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation CTBadgeButton

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.badgeLabel];
        self.minBadgeWidth = 15;
    }
    
    return self;
}


#pragma mark - 🔒private
- (void)setupBadgeLabelFrame{
    CGSize badgeSize = [self.badgeLabel sizeThatFits:CGSizeMake(FLT_MAX, FLT_MAX)];
    if (badgeSize.width < self.minBadgeWidth) {
        badgeSize.width = self.minBadgeWidth;
        badgeSize.height = self.minBadgeWidth;
    }else{
        badgeSize.width += 5;
    }
    
    CGRect badgeRect = self.badgeLabel.frame;
    badgeRect.origin.y -= (badgeSize.height / 2.);
    badgeRect.size = badgeSize;
    if (CGRectGetMaxX(badgeRect) > self.ct_width) {
        badgeRect.size.width += (self.ct_width - CGRectGetMaxX(badgeRect));
    }
    
    self.badgeLabel.frame = badgeRect;
    self.badgeLabel.layer.cornerRadius = MIN(badgeSize.width, badgeSize.height) / 2.;
}
#pragma mark - 🔄overwrite
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    self.badgeLabel.frame = CGRectMake(CGRectGetMaxX(titleRect), titleRect.origin.y, 0, 0);
    [self setupBadgeLabelFrame];
    return titleRect;
}

#pragma mark - 🚪public

#pragma mark - ☸getter and setter
- (UILabel *)badgeLabel{
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.backgroundColor = [UIColor redColor];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.text = @"1";
        _badgeLabel.font = [UIFont systemFontOfSize:10];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeLabel.layer.masksToBounds = YES;
    }
    
    return _badgeLabel;
}

- (void)setBadgeText:(NSString *)badgeText{
    _badgeText = [badgeText copy];
    if (_badgeText == nil || _badgeText.length == 0) {
        _badgeLabel.hidden = YES;
    }else{
        _badgeLabel.text = badgeText;
        [self setupBadgeLabelFrame];
        _badgeLabel.hidden = NO;
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor{
    _badgeTextColor = badgeTextColor;
    _badgeLabel.textColor = badgeTextColor;
}

- (void)setBadgeBackColor:(UIColor *)badgeBackColor{
    _badgeBackColor = badgeBackColor;
    _badgeLabel.backgroundColor = badgeBackColor;
}

@end
