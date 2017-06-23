//
//  CTHmPgNewsCmntModel.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/23.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHmPgNewsCmntModel : NSObject

@property (nonatomic, copy) NSString *commentContent;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *userRole;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *replyNickname; // 被回复者昵称

@end

@interface CTHmPgNewsCmntModelArray : NSObject

@property (nonatomic, strong) NSArray<CTHmPgNewsCmntModel *> *informationComment;

@end
