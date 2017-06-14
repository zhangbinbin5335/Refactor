//
//  CTHmPgBannerModel.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/14.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHmPgBannerModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *image; // 图片链接
@property (nonatomic, strong) NSURL *imageUrl; // 将image转成nsurl类型

@end
