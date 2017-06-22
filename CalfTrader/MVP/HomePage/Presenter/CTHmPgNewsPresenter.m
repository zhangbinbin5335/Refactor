//
//  CTHmPgNewsPresenter.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsPresenter.h"

@interface CTHmPgNewsPresenter ()

@property (nonatomic, strong) NSArray *preMarketInfoArray;
@property (nonatomic, strong) NSArray *marketInfoArray;
@property (nonatomic, strong) NSURLSessionDataTask *preTask;

@end

@implementation CTHmPgNewsPresenter

#pragma mark - ♻️life cycle

#pragma mark - 🔒private
-(void)checkMarketPriceIncrease:(CTHmPgMarketModel*)model{
    for (CTHmPgMarketModel *preModel in self.preMarketInfoArray) {
        if ([model.investProductId isEqualToString:preModel.investProductId]) {
            if (preModel.todayPrice.floatValue >
                model.todayPrice.floatValue &&
                preModel) {
                model.increase = 1;
            }else if (preModel.todayPrice.floatValue <
                      model.todayPrice.floatValue &&
                      preModel){
                model.increase = -1;
            }else{
                model.increase = 0;
            }
            break;
        }
    }
}

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

-(void)requestFlashViewInfoCompletion:(CTHmPgPresenterCompletion)completion{
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

-(void)requestBannerInfoCompletion:(CTHmPgPresenterCompletion)completion{
    // TODO : 获取用户phone num
    NSString *phoneNum = @"";
    NSDictionary *parameters = @{@"phone":phoneNum};
    
    [[CTNetworkManager sharedManager]post:CTBaseUrl
                                urlString:CTHmPgBannerInfo
                               parameters:parameters
                               encryption:YES
                               completion:^(id response, NSError *error) {
                                   CTNLog(@"获取用户 done");
                                   if (error) {
                                       completion(nil, error);
                                   }else{
                                       NSMutableArray *dataArray = response[@"data"][@"data"];
                                       NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                                       for (NSDictionary *info in dataArray) {
                                           CTHmPgBannerModel *model = [CTHmPgBannerModel yy_modelWithDictionary:info];
                                           [modelArray addObject:model];
                                       }
                                       
                                       completion([modelArray copy], nil);
                                   }
                               }
     ];
}

-(void)requesetMarketInfoCompletion:(CTHmPgPresenterCompletion)completion{
    if (self.preTask &&
        self.preTask.state == NSURLSessionTaskStateRunning) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    // TODO : 获取用户phone num
    NSString *phoneNum = @"";
    // 先去请求参数
    self.preTask = [[CTNetworkManager sharedManager]post:CTBaseUrl
                                    urlString:CTHmPgMarketParametr
                                   parameters:@{@"mobile" : phoneNum}
                                   encryption:YES
                                   completion:^(id response, NSError *error) {
                                       NSArray *orderArray = response[@"data"][@"order"];
                                       NSDictionary *parameters = @{@"jsonStr":@[@{@"bourse":@"JN",@"goodsType":@"URP"},
                                                                                 @{@"bourse":@"JN",@"goodsType":@"S"},
                                                                                 @{@"bourse":@"JN",@"goodsType":@"KC"}] /*default 顺序*/,
                                                                    @"tyoe" : @"0"/*不知道干嘛的*/};

                                       // 参数正确返回
                                       if (orderArray && orderArray.count > 0) {
                                           parameters = @{@"jsonStr":orderArray /*顺序*/,
                                                          @"type" : @"0"/*不知道干嘛的*/};
                                       }
                                       
                                               weakSelf.preTask = [[CTNetworkManager sharedManager]post:CTBaseUrl
                                                                           urlString:CTHmPgMarketInfo
                                                                          parameters:parameters
                                                                          encryption:YES
                                                                          completion:^(id response, NSError *error) {
//                                                                              CTNLog(@"market request done");
                                                                              if (error) {
                                                                                  completion(nil, error);
                                                                              }else{
                                                                                  NSMutableArray *dataArray = response[@"data"]
                                                                                                                      [@"data"]
                                                                                                                      [@"dataList"];
                                                                                  
                                                                                  NSMutableArray *modelArray = [[NSMutableArray alloc]
                                                                                                                init];
                                                                                  
                                                                                  for (NSDictionary *info in dataArray) {
                                                                                      CTHmPgMarketModel *model = [CTHmPgMarketModel yy_modelWithDictionary:info];
                                                                                      // 判断价格是否上涨
                                                                                      [weakSelf checkMarketPriceIncrease:model];
                                                                                      [modelArray addObject:model];
                                                                                  }
                                                                                  
                                                                                  weakSelf.preMarketInfoArray = weakSelf.marketInfoArray;
                                                                                  weakSelf.marketInfoArray = [modelArray copy];
                                                                                  weakSelf.preTask = nil;
                                                                                  completion([modelArray copy], nil);
                                                                              }
                                                                          }
                                                ];

                                           }
         ];
}
#pragma mark - ☸getter and setter

@end
