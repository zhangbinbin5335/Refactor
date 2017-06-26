//
//  CTHmPgNewsCommetnCell.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/23.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsCommetnCell.h"
#import "NSString+CTTime.h"
#import "CTLinkView.h"

static NSString *const kCTHmPgNewsCommetnCellID = @"ctHmNwsCmntCellID";

@interface CTHmPgNewsCommetnCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet CTLinkView *commentContent;


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
    self.commentTimeLabel.text = [NSString convertTimeString:model.createTime];
    self.commentContent.content = model.commentContent;
    self.userRoleLabel.text = model.userRole;
    if (model.replyNickname &&
        model.replyNickname.length > 0) {
        NSString *replyContent = [NSString stringWithFormat:@"回复 %@ :%@",model.replyNickname, model.commentContent];
        self.commentContent.content = replyContent;
        [self.commentContent addLink:NSMakeRange(3, model.replyNickname.length) click:^(NSString *linkText) {
            CTNLog(@"%@",linkText);
        }];
    }
}

@end
