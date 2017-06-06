//
//  NSDictionary+CTJson.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/1.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "NSDictionary+CTJson.h"

@implementation NSDictionary (CTJson)

- (NSString*)convertToJson{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
