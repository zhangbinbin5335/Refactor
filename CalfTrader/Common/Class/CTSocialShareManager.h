//
//  CTSocialShareManager.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTSocialShareManager : NSObject

/**
 社交分享的初始化配置
 */
+(void)socialShareConfig;

+(BOOL)handleOpenURL:(NSURL*)url;
@end
