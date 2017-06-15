//
//  CTGlobalConfig.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/5/31.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

// 服务器地址
extern NSString *const CTBaseUrl;

// api接口

// 检查是否需要退出app
extern NSString *const CTAPPExitApi;

// homepage
extern NSString *const CTHmPgNewsInfo;
// banaer info
extern NSString *const CTHmPgBannerInfo;
// 轮播数据
extern NSString *const CTHmFlashViewInfo;
// market 信息
extern NSString *const CTHmPgMarketParametr; // 先去取得CTHmPgMarketInfo请求参数
extern NSString *const CTHmPgMarketInfo;

// NSUserDefaults 存储对应的key
extern NSString *const CTNULastVersionNum;
