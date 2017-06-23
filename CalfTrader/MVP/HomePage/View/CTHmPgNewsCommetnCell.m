//
//  CTHmPgNewsCommetnCell.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/23.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsCommetnCell.h"

static NSString *const kCTHmPgNewsCommetnCellID = @"ctHmNwsCmntCellID";

@interface CTHmPgNewsCommetnCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;

@end

@implementation CTHmPgNewsCommetnCell

#pragma mark -- public
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    CTHmPgNewsCommetnCell *cell = [tableView dequeueReusableCellWithIdentifier:kCTHmPgNewsCommetnCellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CTHmPgNewsCommetnCell"
                                             owner:self
                                           options:nil]
                firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)fillData:(CTHmPgNewsCmntModel *)model{
    [self.userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:model.userAvatar
                                                        relativeToURL:[NSURL URLWithString:CTBaseUrl]]
                                placeholderImage:[UIImage imageNamed:@"cmn_default_avatar"]];
    self.userNameLabel.text = model.nickname;
    self.commentTimeLabel.text = model.createTime;
    self.commentContentLabel.text = model.commentContent;
    self.userNameLabel.text = model.userRole;
}

@end
