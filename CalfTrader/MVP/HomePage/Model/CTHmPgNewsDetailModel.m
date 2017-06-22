//
//  CTHmPgNewDetailModel.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/21.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsDetailModel.h"

@implementation CTHmPgNewsPraiseModel

-(NSString *)userAvatar{
    if (!_userAvatar || _userAvatar.length == 0) {
        NSURL *pathUrl = [[NSBundle mainBundle]URLForResource:@"cmn_default_avatar"
                                                withExtension:@"png"];
        _userAvatar = [pathUrl.absoluteString copy];
    }else{
        _userAvatar = [CTBaseUrl stringByAppendingString:_userAvatar];
    }
    
    return _userAvatar;
}

@end

@implementation CTHmPgNewsDetailModel

-(NSArray<CTHmPgNewsPraiseModel *> *)informationPraise{
    if (_informationPraise && _informationPraise.count > 0) {
        NSMutableArray *modelArray = [[NSMutableArray alloc]init];
        for (NSDictionary *praiseDic in _informationPraise) {
            CTHmPgNewsPraiseModel *model = [CTHmPgNewsPraiseModel yy_modelWithDictionary:praiseDic];
            [modelArray addObject:model];
        }
        
        return [modelArray copy];
    }
    
    return nil;
}

@end
