//
//  CTHmPgNewsCell.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsCell.h"

static NSString *kCTHmPgNewsCellID = @"CTHmPgNewsCellID";
const CGFloat kOffSet = 10;

@interface CTHmPgNewsCell ()

@property (nonatomic,strong) UILabel *titleLabel;//标题
@property (nonatomic,strong) UILabel *describeContent;//内容
@property (nonatomic,strong) UILabel *timeLabel;//时间
@property (nonatomic,strong) UILabel *prasieLabel;//点赞
@property (nonatomic,strong) UIImageView *thumbnailImageView;//图片
@property (nonatomic,strong) UIView *lineView;//底部的横线
@property (nonatomic,strong) UILabel *nickNameLabel;//分析师

@end

@implementation CTHmPgNewsCell
#pragma mark -- life cycle
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellHeight = 44;
        [self setupSubViews];
        [self setupLayout];
    }
    return self;
}
#pragma mark -- private
-(void)setupSubViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.describeContent];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.prasieLabel];
    [self.contentView addSubview:self.thumbnailImageView];
    [self.contentView addSubview:self.lineView];
}

-(void)setupLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kOffSet);
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.thumbnailImageView.mas_left).offset(-kOffSet);
        make.height.mas_equalTo(30);
    }];
    [self.describeContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kOffSet);
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-kOffSet);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.lineView.mas_top);
        make.right.equalTo(self.nickNameLabel.mas_left);
        make.width.mas_equalTo(100);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right);
        make.bottom.equalTo(self.timeLabel);
        make.right.equalTo(self.prasieLabel.mas_left);
    }];
    [self.prasieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel.mas_right);
        make.bottom.equalTo(self.timeLabel);
        make.right.equalTo(self.thumbnailImageView.mas_left);
        make.width.mas_equalTo(80);
    }];
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kOffSet);
        make.right.equalTo(self.contentView.mas_right).offset(-kOffSet);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kOffSet);
        make.width.mas_equalTo(60);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

#pragma makr -- get&set
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [CTViewsFactory ct_labelWithText:@"deafult title"
                                             textColor:[UIColor blackColor]
                                                  font:[UIFont systemFontOfSize:20]];
    }
    
    return _titleLabel;
}
-(UILabel *)describeContent{
    if (!_describeContent) {
        _describeContent = [CTViewsFactory ct_labelWithText:@"deafult content"];
        _describeContent.numberOfLines = 0;
    }
    
    return _describeContent;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [CTViewsFactory ct_labelWithText:@"09:49"
                                            textColor:[UIColor lightGrayColor]
                                                 font:[UIFont systemFontOfSize:10]];
    }
    
    return _timeLabel;
}

-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [CTViewsFactory ct_labelWithText:@"xxxsdfsafsafsf"
                                                textColor:[UIColor lightGrayColor]
                                                     font:[UIFont systemFontOfSize:10]];
    }
    
    return _nickNameLabel;
}
-(UILabel *)prasieLabel{
    if (!_prasieLabel) {
        _prasieLabel = [CTViewsFactory ct_labelWithText:@"5人赞"
                                              textColor:[UIColor lightGrayColor]
                                                   font:[UIFont systemFontOfSize:10]];
    }
    
    return _prasieLabel;
}
-(UIImageView *)thumbnailImageView{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc] init];
        _thumbnailImageView.backgroundColor = [UIColor yellowColor];
    }
    
    return _thumbnailImageView;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _lineView;
}
#pragma mark -- public
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    CTHmPgNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCTHmPgNewsCellID];
    if (!cell) {
        cell = [[CTHmPgNewsCell alloc]initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:kCTHmPgNewsCellID];
    }
    return cell;
}

-(void)fillData:(CTHmPgNewsModel *)model{
    self.titleLabel.text = model.title;
    self.describeContent.text = model.describeContent;
//    self.timeLabel.text = model.
    self.nickNameLabel.text = model.nickName;
    self.prasieLabel.text = [NSString stringWithFormat:@"%lu人赞",(unsigned long)model.prasieCount];
    self.thumbnailImageView.image = [UIImage imageWithData:
                                               [NSData dataWithContentsOfURL:
                                                [NSURL URLWithString:model.thumbnail]]];
}

@end
