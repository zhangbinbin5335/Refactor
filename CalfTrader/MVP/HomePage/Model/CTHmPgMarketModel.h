//
//  CTHmPgMarketModel.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/15.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 changeRange = "";
 changeValue = 3688;
 closingPrice = 3688;
 createMan = task;
 createTime = "2017-06-15 14:50:11";
 floorPrice = 3691;
 highestPrice = 3728;
 id = 30295a2dab9d40de9592f515b0448841;
 investProductId = HGAG;
 investProductName = "\U54c8\U8d35\U94f6";
 lastPrice = 3688;
 modifyMan = "";
 modifyTime = "2017-06-15 14:50:11";
 openingPrice = 3692;
 remark = HGAG;
 state = 1;
 stockIndex = 3699;
 stockTime = "2017-06-15 14:50:09";
 todayPrice = 3699;
 */


@interface CTHmPgMarketModel : NSObject

// 从服务器接受数据model
@property (nonatomic, assign) NSUInteger state;
@property (nonatomic, copy) NSString *investProductName;
@property (nonatomic, copy) NSString *investProductId;
@property (nonatomic, copy) NSString *todayPrice;
@property (nonatomic, copy) NSString *highestPrice;
@property (nonatomic, copy) NSString *lastPrice;
@property (nonatomic, copy) NSString *openingPrice;
@property (nonatomic, copy) NSString *closingPrice;
@property (nonatomic, copy) NSString *remark;

// cell用model
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *amplitude;
@property (nonatomic, copy) NSString *amplitudeRatio;
@property (nonatomic, assign) BOOL marketClose; // 是否休市,YES:休市
@property (nonatomic, assign) NSInteger increase; // 价格是否上涨,-1:跌,0:不变,1:涨

@end
