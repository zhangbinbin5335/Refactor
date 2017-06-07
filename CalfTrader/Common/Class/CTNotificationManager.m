//
//  CTNotificationManager.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/2.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//


#import "CTNotificationManager.h"

@implementation CTNotificationManager

+(void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions delegate:(id<JPUSHRegisterDelegate>)delegate{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:delegate];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions
                           appKey:kJPUSHAppkey
                          channel:kJPUSHChannel
                 apsForProduction:NO];
}

+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

+(void)didReceiveRemoteNotification:(NSDictionary*)userInfo{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    // 推送包含url，就打开web界面
    NSString *urlStr = userInfo[@"url"];
    if(urlStr.length > 0){
        [self pushWebVCWithURLString:urlStr];
    }
}

// 远程推送处理
+ (void)pushWebVCWithURLString:(NSString *)urlStr
{
    // TODO
}

@end
