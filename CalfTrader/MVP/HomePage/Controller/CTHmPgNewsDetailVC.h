//
//  CTHmPgNewsDetailVC.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/15.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTTableViewController.h"
#import "CTHmPgNewsModel.h"

@interface CTHmPgNewsDetailVC : CTTableViewController

@property (nonatomic, strong) CTHmPgNewsModel *newsModel;

/**
 用于请求news详情
 */
@property (nonatomic, copy) NSString *informationId;

@end
