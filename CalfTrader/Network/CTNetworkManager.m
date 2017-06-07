//
//  CTNetworkManager.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/1.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTNetworkManager.h"
/* 3rd */
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
/* custom */
#import "NSString+CTRandom.h"
#import "NSDictionary+CTJson.h"
#import "NSData+CTMD5.h"
#import "CTDESEncryption.h"

typedef NSString* kParameterKey;
kParameterKey ParameterRequestID = @"requestId";
kParameterKey ParameterToken = @"XN_TOKEN";
kParameterKey ParameterCIPHER = @"XN_CIPHER";
kParameterKey ParameterAuth = @"XN_AUTH";


@interface CTNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager* sessionManager;

@end

@implementation CTNetworkManager
#pragma mark - ♻️life cycle
+ (instancetype)sharedManager {
    static CTNetworkManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc]init];
    });
    
    return _sharedManager;
}

-(instancetype)init{
    if (self = [super init]) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

#pragma mark public
-(void)get:(NSString *)baseUrl
 urlString:(NSString *)urlString
parameters:(id)parameters
   completion:(CTNetworkManagerCompletion)completion{
    [self get:baseUrl urlString:urlString parameters:parameters encryption:NO completion:completion];
}

-(void)get:(NSString *)baseUrl
 urlString:(NSString *)urlString
parameters:(id)parameters
encryption:(BOOL)encryption
completion:(CTNetworkManagerCompletion)completion{
    NSString *requestStr = baseUrl ? [baseUrl stringByAppendingString:urlString] : urlString;
    NSDictionary *handlePrmtrs = [self handleParameters:parameters encryption:encryption];
    
    [self ct_get:requestStr parameters:handlePrmtrs completion:completion];
}

-(void)post:(NSString *)baseUrl
  urlString:(NSString *)urlString
 parameters:(id)parameters
 completion:(CTNetworkManagerCompletion)completion{
    [self post:baseUrl urlString:urlString parameters:parameters encryption:NO completion:completion];
}

-(void)post:(NSString*)baseUrl
  urlString:(NSString*)urlString
 parameters:(id)parameters
 encryption:(BOOL)encryption
 completion:(CTNetworkManagerCompletion)completion{
    NSString *requestStr = baseUrl ? [baseUrl stringByAppendingString:urlString] : urlString;
    NSDictionary *handlePrmtrs = [self handleParameters:parameters encryption:encryption];
    [self ct_post:requestStr parameters:handlePrmtrs completion:completion];
}

#pragma mark private
-(void)ct_get:(NSString*)urlString
parameters:(id)parameters
completion:(CTNetworkManagerCompletion)completion{
    [self.sessionManager GET:urlString
                  parameters:parameters
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         completion(responseObject, nil);
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         completion(nil, error);
                     }
     ];
}

-(void)ct_post:(NSString*)urlString
parameters:(id)parameters
completion:(CTNetworkManagerCompletion)completion{
    [self.sessionManager POST:urlString
                  parameters:parameters
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         completion(responseObject, nil);
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         completion(nil, error);
                     }
     ];
}

-(NSDictionary*)handleParameters:(id)parameters encryption:(BOOL)encryption{
    // 处理后的参数
    NSMutableDictionary *handleParameters = [[NSMutableDictionary alloc]initWithCapacity:1];
    // 参数加密
    NSMutableDictionary *encryptionParameters;
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        encryptionParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }else{
        // 参数类型不是NSDictionary，默认为没有传参数
        encryptionParameters = [NSMutableDictionary dictionary];
    }
    // 统一传的参数 ?
    [encryptionParameters setValue:@"WXOETPVRQGDJENSPPQYCUOZEIFALWOUU" forKey:ParameterRequestID];
    if (encryption) {
        // 加密处理
        NSString *encryptnPrmtrsJson = [encryptionParameters convertToJson];
        // 然后把字符串加密 DES
        NSString *desstring = [CTDESEncryption DESEncrypt:encryptnPrmtrsJson key:kEncryptionKey];
        [handleParameters setValue:desstring forKey:ParameterCIPHER];
        
        // MD5
        NSString *desstringMD5 = [[desstring dataUsingEncoding:NSUTF8StringEncoding] md5String];
        NSData *desstringMD5Data = [desstringMD5 dataUsingEncoding:NSUTF8StringEncoding];
        NSString *rsastring = [desstringMD5Data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        
        [handleParameters setValue:rsastring forKey:ParameterToken];
    }else{
        handleParameters = [NSMutableDictionary dictionaryWithDictionary:encryptionParameters];
    }
    
    // 统一传的参数  XN_AUTH
    NSString *XN_AUTH = @"";
    [handleParameters setValue:XN_AUTH forKey:ParameterAuth];
    return handleParameters;
}

@end
