//
//  CTHmPgNewsDetailPresenter.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/21.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTHmPgNewsDetailModel.h"
#import "CTHmPgNewsCmntModel.h"

typedef void(^ CTHmPgDetailPresenterCompletion)(id response, NSError* error);

@interface CTHmPgNewsDetailPresenter : NSObject

@property (nonatomic, strong) NSArray<CTHmPgNewsDetailModel *> *newsDetailArray;
@property (nonatomic, strong) CTHmPgNewsCmntModelArray *commentArray;

/**
 请求新闻详情数据

 @param informationID 新闻id
 @param completion 请求结束回调
 */
-(void)requestNewsInfo:(NSString *)informationID completion:(CTHmPgDetailPresenterCompletion)completion;

@end
