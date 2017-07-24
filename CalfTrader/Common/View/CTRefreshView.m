//
//  CTRefreshView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/7/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTRefreshView.h"

@interface CTRefreshView ()

@property (nonatomic, strong) CAReplicatorLayer *replicatiorLayer;
@property (nonatomic, strong) CALayer *circleLayer;

@end

@implementation CTRefreshView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        [self.layer addSublayer:self.replicatiorLayer];
        [self.replicatiorLayer addSublayer:self.circleLayer];
        self.backgroundColor = [UIColor yellowColor];
    }
    
    return self;
}

-(void)layoutSubviews{
    CGRect bounds = self.layer.bounds;
    
    CGFloat circleWidth = bounds.size.width / 5;
    self.circleLayer.frame = CGRectMake(0, 0, circleWidth, circleWidth);
    self.circleLayer.position = CGPointMake((bounds.size.width) / 2.0, circleWidth / 2.);
    self.circleLayer.cornerRadius = circleWidth / 2.;
    self.circleLayer.backgroundColor = [UIColor colorWithRed:78/255. green:178/255. blue:180/255. alpha:1.].CGColor;
    
    // 圆点个数
    NSUInteger circleCount = 3;
    CGFloat angle = 2 * M_PI / circleCount * 1.0;
    self.replicatiorLayer.instanceCount = 3;
    self.replicatiorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:42/255. green:193/255. blue:136/255. alpha:1.].CGColor,
                             (__bridge id)[UIColor colorWithRed:78/255. green:178/255. blue:180/255. alpha:1.].CGColor];//78,178,180 42,193,136
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0.18, @0.5, @0.9];
    
//    self.replicatiorLayer.mask = gradientLayer;
//    self.replicatiorLayer.masksToBounds = YES;
    self.replicatiorLayer.frame = bounds;
    self.layer.masksToBounds = YES;
    self.layer.mask = self.replicatiorLayer;
    [self.layer addSublayer:gradientLayer];
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public
-(void)startAnimation{
    [self stopAnimation];
    
    CGRect bounds = self.layer.bounds;
    CGFloat circleWidth = self.circleLayer.bounds.size.width;
    
    CAKeyframeAnimation *circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    circleAnimation.values = @[
                               [NSValue valueWithCGPoint:CGPointMake((bounds.size.width) / 2.0, circleWidth)], // 从上开始
                               [NSValue valueWithCGPoint:CGPointMake((bounds.size.width) / 2.0, bounds.size.height - circleWidth)], // 下
                               [NSValue valueWithCGPoint:CGPointMake(bounds.size.width - circleWidth, bounds.size.height / 2.)], // 右
                               [NSValue valueWithCGPoint:CGPointMake(circleWidth, bounds.size.height / 2.)], // 左
                               [NSValue valueWithCGPoint:CGPointMake((bounds.size.width) / 2.0, bounds.size.height - circleWidth)], // 下
                               [NSValue valueWithCGPoint:CGPointMake((bounds.size.width) / 2.0, circleWidth)] // 回到上
                               ];
    circleAnimation.duration = 3.;
    circleAnimation.repeatCount = MAXFLOAT;
    circleAnimation.removedOnCompletion = NO;
    [self.circleLayer addAnimation:circleAnimation forKey:nil];
}

-(void)stopAnimation{
    [self.circleLayer removeAllAnimations];
}

#pragma mark - ☸getter and setter
-(CAReplicatorLayer *)replicatiorLayer{
    if (!_replicatiorLayer) {
        _replicatiorLayer = [[CAReplicatorLayer alloc] init];
    }
    
    return _replicatiorLayer;
}

-(CALayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [[CALayer alloc] init];
    }
    
    return _circleLayer;
}

@end
