//
//  CTHmPgNewDetailModel.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/21.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHmPgNewsDetailModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;// 封面图片URL
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *userRole;
@property (nonatomic, copy) NSString *createTime;


@end
