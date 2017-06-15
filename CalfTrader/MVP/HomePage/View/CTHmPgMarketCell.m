//
//  CTHmPgMarketCell.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/15.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgMarketCell.h"
#import "CTHmPgMarketModel.h"

static const CGFloat kOffSet = 8;

@interface CTHmPgMarketCell ()

@property (nonatomic, strong) UILabel *closeMarkLabel; // 休市标志
@property (nonatomic, strong) UILabel *productNameLabel; // 产品名
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amplitudeLabel; // 幅度
@property (nonatomic, strong) UILabel *amplitudeRatioLabel; // 幅度比

@end

@implementation CTHmPgMarketCell
#pragma mark -- life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self setupLayout];
    }
    
    return self;
}
#pragma mark -- private
-(void)setupSubViews{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    
    [self.contentView addSubview:self.closeMarkLabel];
    [self.contentView addSubview:self.productNameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.amplitudeLabel];
    [self.contentView addSubview:self.amplitudeRatioLabel];
}

-(void)setupLayout{
    __weak typeof(self) weakSelf = self;
    
    [self.closeMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.contentView).offset(kOffSet/2.);
        make.bottom.equalTo(weakSelf.productNameLabel.mas_top);
    }];
    
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView.mas_centerX);
        make.bottom.equalTo(weakSelf.priceLabel.mas_top).offset(-kOffSet);
        make.top.equalTo(weakSelf.closeMarkLabel.mas_bottom);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView.mas_centerX);
        make.bottom.equalTo(weakSelf.amplitudeLabel.mas_top).offset(-kOffSet);
    }];
    
    [self.amplitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_centerX).offset(-kOffSet / 2.);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-2 * kOffSet);
    }];
    
    [self.amplitudeRatioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.amplitudeLabel);
        make.left.equalTo(weakSelf.contentView.mas_centerX).offset(kOffSet / 2.);
    }];
}

-(void)startAnimation:(UIColor*)backgroundColor{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.toValue = (id)backgroundColor.CGColor;
    animation.duration = 0.25;
    
    [self.layer addAnimation:animation forKey:@"animation"];
}
#pragma makr -- get&set
-(UILabel *)closeMarkLabel{
    if (!_closeMarkLabel) {
        _closeMarkLabel = [CTViewsFactory ct_labelWithText:@"休"
                                                 textColor:[UIColor whiteColor]
                                                      font:[UIFont boldSystemFontOfSize:14.]];
        _closeMarkLabel.hidden = YES;
        _closeMarkLabel.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _closeMarkLabel;
}

-(UILabel *)productNameLabel{
    if (!_productNameLabel) {
        _productNameLabel = [CTViewsFactory ct_labelWithText:@"测试"
                                                   textColor:[UIColor blackColor]];
    }
    
    return _productNameLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [CTViewsFactory ct_labelWithText:@"0"
                                             textColor:[UIColor greenColor]
                                                  font:[UIFont boldSystemFontOfSize:16.0]];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _priceLabel;
}

-(UILabel *)amplitudeLabel{
    if (!_amplitudeLabel) {
        _amplitudeLabel = [CTViewsFactory ct_labelWithText:@"0"
                                                 textColor:[UIColor greenColor]
                                                      font:[UIFont systemFontOfSize:12.0]];
        _amplitudeLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _amplitudeLabel;
}

-(UILabel *)amplitudeRatioLabel{
    if (!_amplitudeRatioLabel) {
        _amplitudeRatioLabel = [CTViewsFactory ct_labelWithText:@"0"
                                                      textColor:[UIColor greenColor]
                                                           font:[UIFont systemFontOfSize:12.0]];
        _amplitudeRatioLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _amplitudeRatioLabel;
}
#pragma mark - 🍐delegate
-(void)fillData:(id)data{
    CTHmPgMarketModel *model = (CTHmPgMarketModel*)data;
    
    self.closeMarkLabel.hidden = model.marketClose;
    self.productNameLabel.text = model.productName;
    self.amplitudeLabel.text = model.amplitude;
    self.amplitudeRatioLabel.text = model.amplitudeRatio;
    self.priceLabel.text = model.price;
    
    self.userInteractionEnabled = model.marketClose;
    if (model.increase > 0) {
        // 涨 背景变红
        [self startAnimation:[UIColor redColor]];
    }else if(model.increase < 0){
        // 跌 背景变绿
        [self startAnimation:[UIColor greenColor]];
    }else{
        // do nothing
    }
}

@end
