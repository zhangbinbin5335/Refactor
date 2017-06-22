//
//  CTHmPgNwsDtalHdrView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/21.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNwsDtalHdrView.h"
#import "NSString+CTTime.h"

static const CGFloat kOffset = 10;

@interface CTHmPgNwsDtalHdrView ()

@property (nonatomic, strong) UIImageView *authorImageView;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *postTimeLabel;
@property (nonatomic, strong) UILabel *roleLabel;
@property (nonatomic, strong) UIButton *attentionButton; // 关注按钮
@property (nonatomic, assign) BOOL attention; // 是否关注

@end

@implementation CTHmPgNwsDtalHdrView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self setupLayout];
    }
    
    return self;
}

#pragma mark - 🔒private
-(void)setupSubViews{
    [self addSubview:self.authorImageView];
    [self addSubview:self.authorNameLabel];
    [self addSubview:self.roleLabel];
    [self addSubview:self.postTimeLabel];
    [self addSubview:self.attentionButton];
}

-(void)setupLayout{
    [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kOffset);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.authorImageView.layer.cornerRadius = 30;
    
    [self.authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorImageView);
        make.bottom.equalTo(self.postTimeLabel.mas_top);
        make.right.equalTo(self.roleLabel.mas_left).offset(-kOffset);
        make.left.equalTo(self.authorImageView.mas_right).offset(kOffset);
    }];
    
    [self.roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorImageView);
        make.width.mas_equalTo(100);
        make.bottom.equalTo(self.authorNameLabel);
    }];
    
    [self.postTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorNameLabel);
        make.bottom.equalTo(self.authorImageView);
        make.width.mas_equalTo(100);
    }];
    
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-kOffset);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    self.attentionButton.layer.cornerRadius = 10;
    self.attentionButton.layer.borderWidth = 1;
    self.attentionButton.layer.borderColor = [UIColor brownColor].CGColor;
}
#pragma mark - 🔄overwrite

#pragma mark - 🚪public
-(void)fillData:(CTHmPgNewsDetailModel *)model{
    [self.authorImageView sd_setImageWithURL:[NSURL URLWithString:model.userAvatar
                                                    relativeToURL:[NSURL URLWithString:CTBaseUrl]]];
    self.authorNameLabel.text = model.nickname;
    self.roleLabel.text = model.userRole;
    self.postTimeLabel.text = [NSString convertTimeString:model.createTime];
}

#pragma mark - ☸getter and setter
-(UIImageView *)authorImageView{
    if (!_authorImageView) {
        _authorImageView = [[UIImageView alloc] init];
//        _authorImageView.contentMode = UIViewContentModeScaleAspectFit;
        _authorImageView.clipsToBounds = YES;
    }
    
    return _authorImageView;
}

-(UILabel *)authorNameLabel{
    if (!_authorNameLabel) {
        _authorNameLabel = [CTViewsFactory ct_labelWithText:@"S.B"
                                                  textColor:[UIColor brownColor]
                                                       font:[UIFont boldSystemFontOfSize:18]];
    }
    
    return _authorNameLabel;
}

-(UILabel *)roleLabel{
    if (!_roleLabel) {
        _roleLabel = [CTViewsFactory ct_labelWithText:@"分析师"
                                            textColor:[UIColor brownColor]];
    }
    
    return _roleLabel;
}

-(UILabel *)postTimeLabel{
    if (!_postTimeLabel) {
        _postTimeLabel = [CTViewsFactory ct_labelWithText:@"09:49 昨天"
                                                textColor:[UIColor lightGrayColor]
                                                     font:[UIFont systemFontOfSize:10]];
    }
    
    return _postTimeLabel;
}

-(UIButton *)attentionButton{
    if (!_attentionButton) {
        _attentionButton = [[UIButton alloc] init];
        [_attentionButton setTitle:@"+ 关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return _attentionButton;
}

@end
