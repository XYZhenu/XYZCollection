//
//  NSData+Encryption.m
//  city
//
//  Created by 郜路阳 on 15/2/4.
//  Copyright (c) 2015年 郜路阳. All rights reserved.
//
/**
 *             
 NSString* string64 = nil;
 if ([[type lowercaseString] isEqualToString:@"png"]) {
 string64=[UIImagePNGRepresentation(imageicon) base64Encoding]; //图片转base64码
 }else{
 string64=[UIImageJPEGRepresentation(imageicon, 1) base64Encoding];
 }
 */
#import "NSData+Encryption.h"
#import <CommonCrypto/CommonCryptor.h>
#define AESKey @"Victory_Forever"
@implementation NSData (Encryption)

- (NSData *)AES256EncryptWithKey:(NSData *)key   //加密
{
    
    //AES256加密，密钥应该是32位的
    const void * keyPtr2 = [key bytes];
    char (*keyPtr)[32] = keyPtr2;
    
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
    //所以在下边需要再加上一个块的大小
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding/*这里就是刚才说到的PKCS7Padding填充了*/ | kCCOptionECBMode,
                                          [key bytes], kCCKeySizeAES256,
                                          NULL,/* 初始化向量(可选) */
                                          [self bytes], dataLength,/*输入*/
                                          buffer, bufferSize,/* 输出 */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);//释放buffer
    return nil;
    
}

-(NSData *)AES256DecryptWithKey:(NSString *)key
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
    
}
+(NSString *)Aes256EncryptWithKey:(NSString *)secret
{
    NSString * key=AESKey;
    char keyPtr[32+1];
    bzero(keyPtr,sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *keyData1 = [[NSData alloc] initWithBytes:keyPtr length:32];
    
    NSData * plain=[secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData * cipher=[plain AES256EncryptWithKey:keyData1];
    
    NSString * string=[cipher base64EncodedStringWithOptions:0];
    
    return string;
}


@end
