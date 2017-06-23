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

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"informationPraise":[CTHmPgNewsPraiseModel class]};
}

@end
