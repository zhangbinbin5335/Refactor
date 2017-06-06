//
//  CTDESEncryption.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/1.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTDESEncryption : NSObject

//DES加密
+ (NSString *) DESEncrypt:(NSString *)plainText key:(NSString *)key;
//DES解密
+ (NSString *) DESDecrypt:(NSString *)cipherText key:(NSString*)key;

@end
