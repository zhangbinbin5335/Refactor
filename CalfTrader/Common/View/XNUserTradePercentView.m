//
//  XNUserTradePercentView.m
//  calftrader
//
//  Created by 张彬彬 on 2017/7/12.
//  Copyright © 2017年 宏鹿. All rights reserved.
//

#import "XNUserTradePercentView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 展示比率线条
@interface RectProgressLayer : CAShapeLayer

@property (nonatomic, assign) CGFloat progress;
@property(nullable) CGColorRef progressColor;

@end

@implementation RectProgressLayer
+ (BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"progress"]/*progress 属性变化时，重绘*/) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(void)dealloc{
    [self removeAllAnimations];
}

-(void)drawInContext:(CGContextRef)ctx{
    
    CGSize boundsSize = self.bounds.size;
    CGFloat width = boundsSize.width * self.progress;
    
    UIBezierPath *cutoutPath =[UIBezierPath bezierPathWithRect:CGRectMake(0,
                                                                          0,
                                                                          width,
                                                                          boundsSize.height)];
    
    
    CGContextSetFillColorWithColor(ctx,self.progressColor);
    CGContextAddPath(ctx, cutoutPath.CGPath);
    CGContextFillPath(ctx);
}

@end

@interface XNUserTradePercentView ()<CAAnimationDelegate>

@property (nonatomic, strong) RectProgressLayer *percentLayer;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *titleLabe;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, assign) CGFloat percentLineWidth;
@property (nonatomic, strong) CAGradientLayer *rightGradientLayer; // 左侧渐变layer
@property (nonatomic, strong) CAGradientLayer *leftGradientLayer; // 左侧渐变layer
@property (nonatomic, strong) UIColor *buyupColor; // 买涨颜色
@property (nonatomic, strong) UIColor *buydownColor; // 买跌颜色

@end

@implementation XNUserTradePercentView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _buyupPercent = 0.3;
        _percentLineWidth = 2;
        _buyupColor = UIColorFromRGB(0xff5376);
        _buydownColor = UIColorFromRGB(0x00ce64);
        
        [self.layer addSublayer:self.percentLayer];
        [self.layer addSublayer:self.leftGradientLayer];
        [self.layer addSublayer:self.rightGradientLayer];
        
        [self xn_initSubViews];
    }
    
    return self;
}
-(void)dealloc{
    [self stopAnimation];
}
#pragma mark - 🔄overwrite
-(void)layoutSubviews{
    [self setLayersFrame];
    self.leftLabel.textColor = self.buyupColor;
    self.rightLabel.textColor = self.buydownColor;
}
#pragma mark - 🔒private
- (void)xn_initSubViews{
    [self addSubview:self.leftLabel];
    [self addSubview:self.titleLabe];
    [self addSubview:self.rightLabel];
    
    // 约束
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.mas_top).offset(self.percentLineWidth + 5 * ScaleY);
        make.right.equalTo(self.titleLabe.mas_left);
    }];
    [self.titleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftLabel);
        make.right.equalTo(self.rightLabel.mas_left);
        make.centerX.equalTo(self.mas_centerX);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftLabel);
        make.right.equalTo(self.mas_right);
    }];
}

- (void)setLayersFrame{
    CGRect selfBounds = self.bounds;
    selfBounds.size.height = self.percentLineWidth;
    self.percentLayer.frame = selfBounds;
    self.percentLayer.progress = self.buyupPercent;
    self.percentLayer.progressColor = self.buyupColor.CGColor;
    self.percentLayer.backgroundColor = self.buydownColor.CGColor;
    [self.percentLayer setNeedsDisplay];
    
    self.leftGradientLayer.frame = CGRectMake(0, 0, 60, self.percentLineWidth);
    self.rightGradientLayer.frame = CGRectMake(selfBounds.size.width - 60, 0, 60, self.percentLineWidth);
}
- (void)startAnimation{
    CGFloat selfWidth = self.mj_w;
    CGFloat animationDuration = 1;
    
    CGFloat leftLayerWidth = self.rightGradientLayer.frame.size.width;
    CGFloat leftWidth = selfWidth * self.buyupPercent;
    CGFloat leftToX = leftWidth - leftLayerWidth;
    
    CABasicAnimation *leftTranslateXAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    leftTranslateXAnimation.toValue = @(leftToX);
    leftTranslateXAnimation.duration = animationDuration;
    leftTranslateXAnimation.repeatCount = MAXFLOAT;
    
    CAKeyframeAnimation *leftOpacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    leftOpacityAnimation.values = @[@0.8, @1, @0];
    leftOpacityAnimation.keyTimes = @[@0.1, @0.8, @0.1];
    
    CAAnimationGroup *leftGroupAnimation = [CAAnimationGroup animation];
    leftGroupAnimation.animations = @[leftTranslateXAnimation, leftOpacityAnimation];
    leftGroupAnimation.duration = animationDuration;
    leftGroupAnimation.repeatCount = MAXFLOAT;
    leftGroupAnimation.removedOnCompletion = NO;
    
    [self.leftGradientLayer addAnimation:leftGroupAnimation forKey:@"leftTranslateXAnimation"];
    
    CGFloat rightLayerWidth = self.rightGradientLayer.frame.size.width;
    CGFloat rightToX = (selfWidth - leftWidth - rightLayerWidth) * -1; // 左移距离
    
    CABasicAnimation *rightTranslateXAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    rightTranslateXAnimation.toValue = @(rightToX);
    
    CAKeyframeAnimation *rightOpacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    rightOpacityAnimation.values = @[@0.8, @1, @0];
    rightOpacityAnimation.keyTimes = @[@0.1, @0.8, @0.1];
    
    CAAnimationGroup *rightGroupAnimation = [CAAnimationGroup animation];
    rightGroupAnimation.animations = @[rightTranslateXAnimation, rightOpacityAnimation];
    rightGroupAnimation.duration = animationDuration;
    rightGroupAnimation.repeatCount = MAXFLOAT;
    rightGroupAnimation.removedOnCompletion = NO;
    
    [self.rightGradientLayer addAnimation:rightGroupAnimation forKey:@"rightGroupAnimation"];
}

- (void)stopAnimation{
    [self.leftGradientLayer removeAllAnimations];
    [self.rightGradientLayer removeAllAnimations];
}

#pragma mark - 🚪public

#pragma mark - ☸getter and setter
-(RectProgressLayer *)percentLayer{
    if (!_percentLayer) {
        _percentLayer = [[RectProgressLayer alloc] init];
    }
    
    return _percentLayer;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"买涨50%";
        _leftLabel.font = [UIFont systemFontOfSize:10];
    }
    
    return _leftLabel;
}

-(UILabel *)titleLabe{
    if (!_titleLabe) {
        _titleLabe = [[UILabel alloc] init];
        _titleLabe.font = [UIFont systemFontOfSize:10];
        _titleLabe.textColor = [UIColor blackColor];
    }
    
    return _titleLabe;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"买跌50%";
        _rightLabel.font = [UIFont systemFontOfSize:10];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _rightLabel;
}

-(CAGradientLayer *)leftGradientLayer{
    if (!_leftGradientLayer) {
        _leftGradientLayer = [CAGradientLayer layer];
        _leftGradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor,
                                  (__bridge id)[UIColor colorWithWhite:1 alpha:0.5].CGColor];
        _leftGradientLayer.startPoint = CGPointMake(0, 0);
        _leftGradientLayer.endPoint = CGPointMake(1, 0);

    }
    
    return _leftGradientLayer;
}

-(CAGradientLayer *)rightGradientLayer{
    if (!_rightGradientLayer) {
        _rightGradientLayer = [CAGradientLayer layer];
        _rightGradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor,
                                  (__bridge id)[UIColor colorWithWhite:1 alpha:0.5].CGColor];
        _rightGradientLayer.startPoint = CGPointMake(1, 0);
        _rightGradientLayer.endPoint = CGPointMake(0, 0);
    }
    
    return _rightGradientLayer;
}

-(void)setBuyupPercent:(CGFloat)buyupPercent{
    if (buyupPercent > 1.0) {
        buyupPercent = 1.0;
    }
    _buyupPercent = buyupPercent;
    _leftLabel.text = [NSString stringWithFormat:@"买涨%.0f%%",_buyupPercent * 100];
    _rightLabel.text = [NSString stringWithFormat:@"买涨%.0f%%",(1 - _buyupPercent) * 100];
    [self setNeedsDisplay];
}

-(void)setTitle:(NSString *)title{
    _titleLabe.text = [title copy];
}

@end
