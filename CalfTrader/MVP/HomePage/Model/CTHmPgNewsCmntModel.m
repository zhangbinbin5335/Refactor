//
//  CTHmPgNewsCmntModel.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/23.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTHmPgNewsCmntModel.h"

@implementation CTHmPgNewsCmntModel

@end

@implementation CTHmPgNewsCmntModelArray

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"informationComment":[CTHmPgNewsCmntModel class]};
}

@end
