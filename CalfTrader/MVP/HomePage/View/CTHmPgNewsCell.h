//
//  CTHmPgNewsCell.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTHmPgNewsModel.h"

@interface CTHmPgNewsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)fillData:(CTHmPgNewsModel*)model;

@end
