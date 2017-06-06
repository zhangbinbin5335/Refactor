//
//  CTNotificationManager.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/2.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 3rd */
// 极光推送
#import <JPUSHService.h>

@interface CTNotificationManager : NSObject
// 注册远程推送
+(void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions delegate:(id<JPUSHRegisterDelegate>)delegate;
// 注册成功取到token
+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
// 处理推远程送消息
+(void)didReceiveRemoteNotification:(NSDictionary*)userInfo;
@end
