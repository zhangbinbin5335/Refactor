//
//  CTAppDelegate.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/5/31.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTAppDelegate.h"
/* custom */
#import "CTLocationManager.h"
#import "CTNotificationManager.h"
#import "CTSocialShareManager.h"
#import "CTRootViewController.h"

#import <UserNotifications/UserNotifications.h>

@interface CTAppCheckModel : NSObject
@property (nonatomic, assign) BOOL shouldCheck;
@end
@implementation CTAppCheckModel
@end

@interface CTAppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic, strong) CTLocationManager* locationManager;

@end
@implementation CTAppDelegate

#pragma mark - ♻️life cycle
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // 检查app是否需要退出
//    [self checkApplicationShouldExit];
    // 推送相关处理
    [CTNotificationManager didFinishLaunchingWithOptions:launchOptions delegate:self];
    // 社交分享初始化配置
    [CTSocialShareManager socialShareConfig];
    //TODO : app未登录被kill,重新打开app弹出登录界面
    
    // 保存最新版本号
    [self saveLastVersionNumber];
    // 设置根视图
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[CTRootViewController alloc]init];
    
    NSString *string = @"x";
    NSAssert(string, @"string == nil");
    NSDictionary *dic = @{@"xx" : string};
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [CTNotificationManager didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [CTNotificationManager didReceiveRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [CTNotificationManager didReceiveRemoteNotification:userInfo];
}
#pragma mark -- 第三方应用打开app处理
-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
           options:(nonnull NSDictionary<NSString *,id> *)options{
    return [CTSocialShareManager handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [CTSocialShareManager handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url{
    return [CTSocialShareManager handleOpenURL:url];
}

#pragma mark --get&set
-(CTLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CTLocationManager alloc]init];
    }
    return _locationManager;
}

#pragma mark --delegate
// ios 10.0通知响应处理
// 处理前台收到通知的代理方法，即App正开启着，用户正在浏览App内容
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(NSInteger options))completionHandler{
    NSDictionary *userInfo = notification.request.content.userInfo;
    [CTNotificationManager didReceiveRemoteNotification:userInfo];
    
    // 全部设置为alert模式
    completionHandler(UNNotificationPresentationOptionAlert);
}
// ios 10.0通知响应处理
// 处理后台点击通知的代理方法，这里的后台和iOS9不一样，指App Killed（即关闭）或者App摁下Home键返回后台的情况
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
 didReceiveNotificationResponse:(UNNotificationResponse *)response
          withCompletionHandler:(void(^)())completionHandler{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    [CTNotificationManager didReceiveRemoteNotification:userInfo];
}
#pragma mark --priviate
-(void)checkApplicationShouldExit{
    // 判断是否需要exit
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSDictionary *parameters = @{@"version" : version};
    
    __weak typeof(self) weakSelf = self;
    [[CTNetworkManager sharedManager]post:@"http://new.xnsudai.com/"
                                urlString:CTAPPExitApi
                               parameters:parameters
                               encryption:YES
                               completion:^(id response, NSError *error) {
                                   CTAppCheckModel* model = [CTAppCheckModel yy_modelWithDictionary:response];
                                   if (model.shouldCheck) {
                                       // 需要check是否退出app
                                       [weakSelf.locationManager requestLocationCompletionHandler:^(BOOL inChina) {
                                           // 不在中国则退出
                                           if (!inChina) {
                                               exit(-1);
                                           }
                                       }];
                                   }
                               }
     ];
}

-(void)saveLastVersionNumber{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * lastVersion = [defaults stringForKey:CTNULastVersionNum];
        ///获得当前软件的版本号
        NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        if (![currentVersion isEqualToString:lastVersion]){
            //存储新版本
            [defaults setObject:currentVersion forKey:CTNULastVersionNum];
            [defaults synchronize];
        }
    });
}
@end


