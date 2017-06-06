//
//  CTNetworkManager.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/1.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^CTNetworkManagerCompletion)(id response, NSError* error);

@interface CTNetworkManager : NSObject

+ (instancetype)sharedManager;


/**
 get request

 @param baseUrl 服务器地址
 @param urlString 服务器具体地址
 @param parameters 参数
 @param completion 请求完成回调
 */
-(void)get:(NSString*)baseUrl
 urlString:(NSString*)urlString
parameters:(id)parameters
completion:(CTNetworkManagerCompletion)completion;


/**
 @param encryption 参数是否加密(DES加密)
 */
-(void)get:(NSString*)baseUrl
 urlString:(NSString*)urlString
parameters:(id)parameters
encryption:(BOOL)encryption
completion:(CTNetworkManagerCompletion)completion;


/**
 post request
 */
-(void)post:(NSString*)baseUrl
 urlString:(NSString*)urlString
parameters:(id)parameters
completion:(CTNetworkManagerCompletion)completion;

/**
 @param encryption 参数是否加密(DES加密)
 */
-(void)post:(NSString*)baseUrl
 urlString:(NSString*)urlString
parameters:(id)parameters
encryption:(BOOL)encryption
completion:(CTNetworkManagerCompletion)completion;

@end
