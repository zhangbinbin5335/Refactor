//
//  CTGlobalConfig.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/5/31.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTGlobalConfig.h"

// 服务器地址
#if DEBUG
NSString *const CTBaseUrl = @"http://new.xnsudai.com/";//@"http://101.37.33.121/";
#else
NSString *const CTBaseUrl = @"http://new.xnsudai.com/";
#endif

// 检查是否需要退出app
NSString *const CTAPPExitApi = @"calfTrader-systemCenter-web/admin/iosAuditApi/Find.do";

// homepage
// 新闻
NSString *const CTHmPgNewsInfo = @"calfTrader-communityCenter-api/information/listInf.do";
// banaer info
NSString *const CTHmPgBannerInfo =  @"calfTrader-systemCenter-web/admin/homeIconApi/list.do";
// 轮播数据
NSString *const CTHmFlashViewInfo = @"calfTrader-communityCenter-api/information/informationColumnBanNew.do";
// market数据
NSString *const CTHmPgMarketParametr = @"calfTrader-accountCenter-api/activity/getOrder.do";
NSString *const CTHmPgMarketInfo = @"calfTrader-HGKLine-api/tradingKLine/getCustomMarketList.do";

// homepage news detail
NSString *const CTHmPgNewsDtailInfo = @"calfTrader-communityCenter-api/information/listInfById.do";


// NSUserDefaults 存储对应的key
NSString *const CTNULastVersionNum = @"lastVersionBug";
