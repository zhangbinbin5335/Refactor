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
                                       NSDictionary *dataDic = response[@"data"][@"data"];
                                       NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                                       CTHmPgNewsDetailModel *informationModel = [CTHmPgNewsDetailModel yy_modelWithDictionary:dataDic[@"information"]];
                                       CTHmPgNewsCmntModelArray *commentModel = [CTHmPgNewsCmntModelArray yy_modelWithDictionary:dataDic];
                                       
                                       weakSelf.commentArray = commentModel;
                                       if (informationModel) {
                                           [modelArray addObject:informationModel];
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
