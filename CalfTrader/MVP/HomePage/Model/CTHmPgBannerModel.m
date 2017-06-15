//
//  CTHmPgBannerModel.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/14.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgBannerModel.h"

@implementation CTHmPgBannerModel

#pragma mark - ☸getter and setter
-(NSURL *)imageUrl{
    
    if (_imageUrl) {
        return _imageUrl;
    }
    
    if (_image) {
        return [NSURL URLWithString:_image];
    }
    
    return nil;
}

@end
