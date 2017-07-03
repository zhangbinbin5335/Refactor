//
//  CTHmPgNewsDetailCell.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/20.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsDetailCell.h"
#import "CTCycleView.h"

static const CGFloat kOffSet = 10;
static NSString * const kCTHmPgNewsDetailCellID = @"kCTHmPgNewsDetailCellID";

@interface CTHmPgNewsDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *likedButton; // 点赞
@property (nonatomic, strong) UILabel *likedCountLabel; // 点赞数
@property (nonatomic, strong) CTCycleView *likedUserView; // 展示点赞用户头像，最多展示五个
@property (nonatomic, assign) BOOL liked; //是否点赞


@end

@implementation CTHmPgNewsDetailCell

#pragma mark -- life cycle
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
        [self setupLayout];
    }
    return self;
}

-(void)dealloc{
    
}

#pragma mark -- private
-(void)setupSubViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.likedButton];
    [self.contentView addSubview:self.likedCountLabel];
    [self.contentView addSubview:self.likedUserView];
}

-(void)setupLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(kOffSet);
        make.bottom.equalTo(self.contentLabel.mas_top).offset(-kOffSet);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).offset(kOffSet);
        make.right.equalTo(self.titleLabel).offset(-kOffSet);
        make.bottom.equalTo(self.likedButton.mas_top).offset(-kOffSet);
    }];
    
    [self.likedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(46);
        make.bottom.equalTo(self.likedCountLabel.mas_top);
    }];
    
    [self.likedCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.likedButton);
        make.bottom.equalTo(self.likedUserView.mas_top).offset(-kOffSet);
    }];
    
    [self.likedUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kOffSet);
        make.height.mas_equalTo(40);
    }];
}

#pragma makr -- get&set
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [CTViewsFactory ct_labelWithText:@"deafult title"
                                             textColor:[UIColor blackColor]
                                                  font:[UIFont boldSystemFontOfSize:16]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [CTViewsFactory ct_labelWithText:@"加载中..."
                                               textColor:[UIColor grayColor]];
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

-(UIButton *)likedButton{
    if (!_likedButton) {
        _likedButton = [[UIButton alloc] init];
    }
    
    return _likedButton;
}

-(UILabel *)likedCountLabel{
    if (!_likedCountLabel) {
        _likedCountLabel = [[UILabel alloc] init];
    }
    
    return _likedCountLabel;
}

-(CTCycleView *)likedUserView{
    if (!_likedUserView) {
        _likedUserView = [[CTCycleView alloc] init];
        _likedUserView.loop = NO;
        _likedUserView.pageHide = YES;
        _likedUserView.placeholderImage = [UIImage imageNamed:@"cmn_default_avatar"];
    }
    
    return _likedUserView;
}

#pragma mark -- public
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    CTHmPgNewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kCTHmPgNewsDetailCellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (!cell) {
        cell = [[CTHmPgNewsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:kCTHmPgNewsDetailCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)fillData:(CTHmPgNewsDetailModel *)model{
    self.titleLabel.text = model.title;
    
    // 这个方法加载很慢
    NSData *contentData = [model.content dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *attributes = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    NSAttributedString *attributeContent = [[NSAttributedString alloc]initWithData:contentData
                                                                           options:attributes
                                                                documentAttributes:nil
                                                                             error:nil];
    self.contentLabel.attributedText = attributeContent;
    UIImage *likedImage;
    if (model.isPraise) {
        likedImage = [UIImage imageNamed:@"cmn_liked"];
    }else{
        likedImage = [UIImage imageNamed:@"cmn_unlike"];
    }
    [self.likedButton setImage:likedImage forState:UIControlStateNormal];
    self.likedCountLabel.text = [NSString stringWithFormat:@"%lu人点赞",(unsigned long)model.praiseCounts];
    
    NSMutableArray *dataSource = [[NSMutableArray alloc]initWithCapacity:1];
    for (CTHmPgNewsPraiseModel *praiseModel in model.informationPraise) {
        if (dataSource.count >= 5) {
            break;
        }
        NSString *userAvatar = praiseModel.userAvatar;
        [dataSource addObject:userAvatar];
    }
    
    self.likedUserView.itemSize = ^CGSize(CTCycleView *cycleView) {
        return CGSizeMake(40,
                          40 - 0.1);
    };
    
    [self.likedUserView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40 * dataSource.count);
        make.height.mas_equalTo(40);
    }];
    self.likedUserView.dataSource = dataSource;
}


@end
