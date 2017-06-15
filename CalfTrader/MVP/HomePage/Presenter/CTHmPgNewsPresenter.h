//
//  CTHmPgNewsPresenter.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTHmPgNewsModel.h"
#import "CTHmPgBannerModel.h"
#import "CTHmPgMarketModel.h"

typedef void(^ CTHmPgPresenterCompletion)(id response, NSError* error);

@interface CTHmPgNewsPresenter : NSObject

@property (nonatomic, strong) NSArray<CTHmPgNewsModel *> *newsInfo;

/**
 请求新闻列表数据
 成功：删除旧数据，保留新数据
 失败：保留旧数据
 @param completion 请求结束回调
 */
-(void)requestNewsInfoCompletion:(CTHmPgPresenterCompletion)completion;

/**
 请求首页轮播数据

 @param completion 请求结束回调
 */
-(void)requestFlashViewInfoCompletion:(CTHmPgPresenterCompletion)completion;

/**
 请求banner数据

 @param completion 请求结束回调
 */
-(void)requestBannerInfoCompletion:(CTHmPgPresenterCompletion)completion;


/**
 请求交易市场数据

 @param completion 请求结束回调
 */
-(void)requesetMarketInfoCompletion:(CTHmPgPresenterCompletion)completion;

@end
