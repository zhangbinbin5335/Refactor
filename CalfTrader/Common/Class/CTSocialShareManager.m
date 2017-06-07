//
//  CTSocialShareManager.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTSocialShareManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UMMobClick/MobClick.h>

NSString *const kUMengAnalyticsAppKey = @"58bfc600a40fa3678e00060b";
NSString *const kUMengChannelID = @"App Store";
NSString *const kUMengSocialAppKey = @"58bfc600a40fa3678e00060b";
NSString *const kWechatAppKey = @"wxb877604fa52dfc8c";
NSString *const kWechatAppSecret = @"f7252b2af957eadbd7c5d2cca663910d";
NSString *const kQQAppKey = @"1105973193";
#warning 未设置有效值
NSString *const kQQAppSecret = nil;
NSString *const kRedirectURL = nil;

@implementation CTSocialShareManager

+(void)socialShareConfig{
//    //----------------------友盟统计-------------------
//    UMConfigInstance.appKey = kUMengAnalyticsAppKey;
//    UMConfigInstance.channelId = kUMengChannelID;
//    [MobClick setAppVersion:XcodeAppVersion];
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    //----------------------友盟分享-------------------
    /* 打开调试日志 */
#if DEBUG
    [[UMSocialManager defaultManager] openLog:YES];
#else
    [[UMSocialManager defaultManager] openLog:NO];
#endif
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMengSocialAppKey];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:kWechatAppKey
                                       appSecret:kWechatAppSecret
                                     redirectURL:kRedirectURL];
    
    /* 设置qq的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:kQQAppKey
                                       appSecret:kQQAppSecret
                                     redirectURL:kRedirectURL];
}

+(BOOL)handleOpenURL:(NSURL *)url{
    return [[UMSocialManager defaultManager]handleOpenURL:url];
}

@end
