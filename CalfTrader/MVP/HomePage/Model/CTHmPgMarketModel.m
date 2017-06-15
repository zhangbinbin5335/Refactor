//
//  CTHmPgMarketModel.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/15.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgMarketModel.h"

@implementation CTHmPgMarketModel

#pragma mark - ☸getter and setter
-(BOOL)marketClose{
    if (_state == 1) {
        return YES;
    }
    
    return NO;
}

-(NSString *)productName{
    if (_productName) {
        return _productName;
    }
    
    _productName = [_investProductName copy];
    return _productName;
}

-(NSString *)price{
    if (_price) {
        return _price;
    }
    
    _price = [_todayPrice copy];
    return _price;
}

-(NSString *)amplitude{
    CGFloat increasePrice = _todayPrice.floatValue - _closingPrice.floatValue;
    if (increasePrice > 0) {
        _amplitude = [NSString stringWithFormat:@"+%.2f",increasePrice];
        return _amplitude;
    }else{
        _amplitude = [NSString stringWithFormat:@"%.2f",increasePrice];
        return _amplitude;
    }
}

-(NSString *)amplitudeRatio{
    CGFloat increasePrice = _todayPrice.floatValue - _closingPrice.floatValue;
    CGFloat increasePriceRation = increasePrice / _closingPrice.floatValue * 100.;
    
    _amplitudeRatio = [NSString stringWithFormat:@"%.2f%%",increasePriceRation];
    return _amplitudeRatio;
}
@end
