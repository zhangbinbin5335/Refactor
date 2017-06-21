//
//  CTHmPgNewsDetailPresenter.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/21.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsDetailPresenter.h"

@implementation CTHmPgNewsDetailPresenter
#pragma mark - 🚪public
-(void)requestNewsInfo:(NSString *)informationID completion:(CTHmPgDetailPresenterCompletion)completion{
    // TODO : token处理
    NSString *token = @"";
    
    NSDictionary *parameters = @{@"informationId":informationID,
                                 @"token":token};
    
    __weak typeof(self) weakSelf = self;
    [[CTNetworkManager sharedManager]post:CTBaseUrl
                                urlString:CTHmPgNewsDtailInfo
                               parameters:parameters
                               encryption:YES
                               completion:^(id response, NSError *error) {
                                   if (error) {
                                       completion(nil, error);
                                   }else{
                                       NSDictionary *dataDic = response[@"data"][@"data"][@"information"];
                                       NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                                       CTHmPgNewsDetailModel *model = [CTHmPgNewsDetailModel
                                                                       yy_modelWithDictionary:dataDic];
                                       if (model) {
                                           [modelArray addObject:model];
                                       }
                                       
                                       if (modelArray.count > 0) {
                                           weakSelf.newsDetailArray = [modelArray copy];
                                           completion([modelArray copy], nil);
                                       }
                                   }
                               }
     ];
}

@end
