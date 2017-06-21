//
//  CTHmPgNewsDetailCell.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/20.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsDetailCell.h"

static const CGFloat kOffSet = 10;
static NSString * const kCTHmPgNewsDetailCellID = @"kCTHmPgNewsDetailCellID";

@interface CTHmPgNewsDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

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
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kOffSet);
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
}


@end
