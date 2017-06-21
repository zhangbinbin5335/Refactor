//
//  CTHmPgNewsDetailCell.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/20.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTHmPgNewsDetailModel.h"

@interface CTHmPgNewsDetailCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)fillData:(CTHmPgNewsDetailModel *)model;

@end
