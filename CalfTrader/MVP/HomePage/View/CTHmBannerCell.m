//
//  CTHmToolCell.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/13.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmBannerCell.h"
#import "CTHmPgBannerModel.h"

static const CGFloat kOffSet = 10;

@interface CTHmBannerCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CTHmBannerCell

#pragma mark -- life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self setupLayout];
    }
    
    return self;
}
#pragma mark -- private
-(void)setupSubViews{
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.cornerRadius = 10;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageView];
}

-(void)setupLayout{
    
    __weak typeof(self) weakSelf = self;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(kOffSet);
        make.left.right.equalTo(weakSelf.contentView);
        make.bottom.mas_equalTo(weakSelf.titleLabel.mas_top).offset(-kOffSet);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(kOffSet);
        make.right.equalTo(weakSelf.contentView).offset(-kOffSet);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-kOffSet);
    }];
}

#pragma makr -- get&set
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [CTViewsFactory ct_labelWithText:@"deafult title"
                                             textColor:[UIColor blackColor]
                                                  font:[UIFont systemFontOfSize:16]];
        _titleLabel.text = @"xxxxxaaa";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _imageView;
}
#pragma mark -- public
-(void)fillData:(id)data{
    CTHmPgBannerModel *model = (CTHmPgBannerModel*)data;
    
    [self.imageView sd_setImageWithURL:model.imageUrl];
    self.titleLabel.text = model.title;
}

@end
