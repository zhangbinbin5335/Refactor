//
//  CTHmPgNewsModel.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/6.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHmPgNewsModel : NSObject

@property (nonatomic, copy) NSString *title; // 新闻标题
@property (nonatomic, copy) NSString *describeTitle; //
@property (nonatomic, copy) NSString *describeContent;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *thumbnail; // 封面缩略图url
@property (nonatomic, assign) NSUInteger prasieCount; // 点赞数量

@end
