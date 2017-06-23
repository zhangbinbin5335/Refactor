//
//  CTHmPgNewsCommetnCell.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/23.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTHmPgNewsCmntModel.h"

@interface CTHmPgNewsCommetnCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)fillData:(CTHmPgNewsCmntModel *)model;

@end
