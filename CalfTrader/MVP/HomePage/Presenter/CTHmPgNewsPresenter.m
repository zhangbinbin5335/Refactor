//
//  CTHmPgNewsPresenter.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsPresenter.h"

@implementation CTHmPgNewsPresenter

#pragma mark - ♻️life cycle

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public
-(void)requestNewsInfoCompletion:(CTHmPgPresenterCompletion)completion{
    __weak typeof(self) weakSelf = self;
    // 首页的消息列表
    [[CTNetworkManager sharedManager]post:@"http://new.xnsudai.com/"
                                urlString:CTHmPgNewsInfo
                               parameters:nil
                               encryption:YES
                               completion:^(id response, NSError *error) {
                                   if (error) {
                                       completion(nil, error);
                                   }else{
                                       NSMutableArray *dataArray = response[@"data"][@"data"];
                                       NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                                       for (NSDictionary *info in dataArray) {
                                           CTHmPgNewsModel *model = [CTHmPgNewsModel yy_modelWithDictionary:info];
                                           [modelArray addObject:model];
                                       }
                                       if (modelArray.count > 0) {
                                           weakSelf.newsInfo = [modelArray copy];
                                           completion([modelArray copy], nil);
                                       }
                                   }
                               }
     ];
}

-(void)requestFlashViewInfoCompltion:(CTHmPgPresenterCompletion)completion{
    // TODO : 获取用户ID
    NSString *customerID = @"";
    NSDictionary *parameters = @{@"customerId":customerID};
    
    [[CTNetworkManager sharedManager]post:CTBaseUrl
                                urlString:CTHmFlashViewInfo
                               parameters:parameters
                               completion:^(id response, NSError *error) {
                                   CTNLog(@"首页轮播数据 = %@",response);
                                   completion(response, error);
                               }
     ];
}
#pragma mark - ☸getter and setter

@end
