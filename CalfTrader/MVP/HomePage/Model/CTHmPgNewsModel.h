//
//  CTHmPgNewsModel.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/6.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHmPgNewsModel : NSObject

@property (nonatomic,assign) NSUInteger attentionCounts; //
@property (nonatomic,strong) NSString *auditTime;
@property (nonatomic,strong) NSString *authorId;
@property (nonatomic,assign) NSUInteger commentNum; // 评论数
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *contentType;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *informationId;
@property (nonatomic,assign) BOOL isAttention;
@property (nonatomic,assign) BOOL isPraise;
@property (nonatomic,strong) NSString *modifyTime;
@property (nonatomic,strong) NSString *nickname; // 作者昵称
@property (nonatomic,strong) NSString *picOne;
@property (nonatomic,assign) NSUInteger praiseCounts;//点赞数
@property (nonatomic,strong) NSString *systemDate;
@property (nonatomic,strong) NSString *title; // 标题
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *userAvatar;
@property (nonatomic,strong) NSString *userRole;
@property (nonatomic,strong) NSString *describeContent;
@property (nonatomic,strong) NSString *homePic;// 封面图片URL

@end
