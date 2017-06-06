//
//  CTDESEncryption.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/1.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTDESEncryption.h"

#import <CommonCrypto/CommonCryptor.h>

const Byte iv[] = {1,2,3,4,5,6,7,8};
@implementation CTDESEncryption

//DES加密
+ (NSString *) DESEncrypt:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, // 加密
                                          kCCAlgorithmDES, // 加密算法
                                          kCCOptionPKCS7Padding, // 
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [textData bytes],
                                          dataLength,
                                          buffer, // 返回结果
                                          1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer
                                      length:(NSUInteger)numBytesEncrypted];
        
//        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    }
    return ciphertext;
}
//DES解密
+ (NSString *) DESDecrypt:(NSString *)cipherText key:(NSString*)key{
    NSString *plaintext = nil;
    NSData *cipherdata = [cipherText dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes],
                                          [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

@end
