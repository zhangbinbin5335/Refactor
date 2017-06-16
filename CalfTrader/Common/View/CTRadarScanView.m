//
//  CTRadarScanView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/16.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTRadarScanView.h"

@interface CTRadarScanView ()

@property (nonatomic, strong) CAShapeLayer *surroundLayer; // 最外层环绕layer
@property (nonatomic, strong) CAShapeLayer *pointLayer; // 中间圆心layer
@property (nonatomic, strong) CAShapeLayer *radarLayer; // 雷达layer

@end

@implementation CTRadarScanView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.radarLayer];
        [self.layer addSublayer:self.pointLayer];
        [self.layer addSublayer:self.surroundLayer];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)layoutSubviews{
    CGRect bounds = self.bounds;
    CGFloat surroundLineWidth = 3;
    CGFloat space = 5;
    
    [self drawSurroundLayer:bounds lineWidth:surroundLineWidth];
    [self drawPointLayer:bounds];
    
    self.radarLayer.frame = CGRectMake(space + surroundLineWidth,
                                       space + surroundLineWidth,
                                       bounds.size.width - 2 * (surroundLineWidth + space),
                                       bounds.size.width - 2 * (surroundLineWidth + space));
}

#pragma mark - 🔒private
-(void)drawSurroundLayer:(CGRect)rect lineWidth:(CGFloat)lineWidth{
    self.surroundLayer.frame = rect;
    
    CGFloat surroundRadius = self.ct_width / 2.;
    UIBezierPath *surroundPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                            cornerRadius:surroundRadius];
    self.surroundLayer.lineDashPattern = @[@((2 * M_PI * surroundRadius - 100) / 2.),
                                           @50];//虚线中实线部分和间隔部分分别的长度
    self.surroundLayer.path = surroundPath.CGPath;
    self.surroundLayer.strokeColor = [UIColor colorWithRed:251/255.
                                                     green:41/255.
                                                      blue:107/255.
                                                     alpha:0.1].CGColor;// rgba(251, 41, 107, 0.1)
    self.surroundLayer.fillColor = [UIColor clearColor].CGColor;
    self.surroundLayer.lineWidth = lineWidth;
}

-(void)drawPointLayer:(CGRect)rect{
    self.pointLayer.frame = rect;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                          cornerRadius:rect.size.width/2.];
    self.pointLayer.path = circlePath.CGPath;
    self.surroundLayer.fillColor = [UIColor colorWithRed:251/255.
                                                     green:41/255.
                                                      blue:107/255.
                                                     alpha:0.1].CGColor;// rgba(251, 41, 107, 0.1)
    self.surroundLayer.strokeColor = [UIColor clearColor].CGColor;
}

#pragma mark - 🔄overwrite

#pragma mark - 🚪public
-(void)startAnimate{
    CABasicAnimation *surroundAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    surroundAnimation.fromValue = @(2 * M_PI);
    surroundAnimation.toValue = @(0);
    surroundAnimation.duration = 1.0;
    surroundAnimation.repeatCount = HUGE_VALF;
    
    [self.surroundLayer addAnimation:surroundAnimation forKey:@"surroundAnimation"];
    
    CABasicAnimation *radarAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    radarAnimation.fromValue = @(0);
    radarAnimation.toValue = @(2 * M_PI);
    radarAnimation.duration = 2.;
    radarAnimation.repeatCount = HUGE_VALF;

    [self.radarLayer addAnimation:radarAnimation forKey:@"radarAnimation"];
    
    CABasicAnimation *scaleAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 终点设定
    scaleAnimation.toValue = [NSNumber numberWithFloat:80];; // 終点
    
    
    /* 动画2（绕Z轴中心旋转） */
    CABasicAnimation *animation2 =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定旋转角度
    animation2.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的角度
    animation2.toValue = [NSNumber numberWithFloat:44 * M_PI]; // 结束时的角度
    
    
    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 动画选项设定
    group.duration = 3.0;
    group.repeatCount = 1;
}
#pragma mark - ☸getter and setter
-(CAShapeLayer *)radarLayer{
    if (!_radarLayer) {
        _radarLayer = [[CAShapeLayer alloc] init];
        _radarLayer.contents = (__bridge id)[UIImage imageNamed:@"radar"].CGImage;
//        _radarLayer.masksToBounds = YES;
    }
    
    return _radarLayer;
}

-(CAShapeLayer *)pointLayer{
    if (!_pointLayer) {
        _pointLayer = [[CAShapeLayer alloc] init];
    }
    
    return _pointLayer;
}

-(CAShapeLayer *)surroundLayer{
    if (!_surroundLayer) {
        _surroundLayer = [[CAShapeLayer alloc] init];
    }
    
    return _surroundLayer;
}

@end
