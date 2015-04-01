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
//static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//kongtou_beauty_1710
@implementation NSData (Encryption)
//-(NSData *)AES256EncryptWithKey:(NSString *)key
//{
//    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
//    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
//    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
//    
//    // fetch key data
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    NSUInteger dataLength = [self length];
//    
//    //See the doc: For block ciphers, the output size will always be less than or
//    //equal to the input size plus the size of one block.
//    //That's why we need to add the size of one block here
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
//                                          keyPtr, kCCKeySizeAES256,
//                                          NULL /* initialization vector (optional) */,
//                                          [self bytes], dataLength, /* input */
//                                          buffer, bufferSize, /* output */
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        //the returned NSData takes ownership of the buffer and will free it on deallocation
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//    
//    free(buffer); //free the buffer;
//    return nil;
//    
//}

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

//+(NSString *)Aes256EncryptWithKey:(NSString *)secret
//{
//    NSString * key=AESKey;
//    NSData * plain=[secret dataUsingEncoding:NSUTF8StringEncoding];
//    NSData * cipher=[plain AES256EncryptWithKey:key];
//    NSString * string=[cipher base64EncodedStringWithOptions:0];
//    return string;
//    //return [cipher newStringInBase64FromData];
//}

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



/*-(NSString *)Aes256EncryptWithKey:(NSString *)secret
{
    NSString * key=AESKey;
    NSData * plain=[secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData * cipher=[plain AES256EncryptWithKey:key];
    NSString * string=[cipher base64EncodedStringWithOptions:0];
    return string;
    //return [cipher newStringInBase64FromData];
}*/
/*- (NSString *)newStringInBase64FromData            //追加64编码

{
    
    NSMutableString *dest = [[NSMutableString alloc] initWithString:@""];
    
    unsigned char * working = (unsigned char *)[self bytes];
    
    NSInteger srcLen = [self length];
    
    for (int i=0; i<srcLen; i += 3) {
        
        for (int nib=0; nib<4; nib++) {
            
            int byt = (nib == 0)?0:nib-1;
            
            int ix = (nib+1)*2;
            
            if (i+byt >= srcLen) break;
            
            unsigned char curr = ((working[i+byt] << (8-ix)) & 0x3F);
            
            if (i+nib < srcLen) curr |= ((working[i+nib] >> ix) & 0x3F);
            
            [dest appendFormat:@"%c", base64[curr]];
            
        }
        
    }
    
    return dest;
    
}



+ (NSString*)base64encode:(NSString*)str

{
    
    if ([str length] == 0)
        
        return @"";
    
    const char *source = [str UTF8String];
    
    int strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    
    if (characters == NULL)
        
        return nil;
    
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    
    while (i < strlength) {
        
        char buffer[3] = {0,0,0};
        
        short bufferLength = 0;
        
        while (bufferLength < 3 && i < strlength)
            
            buffer[bufferLength++] = source[i++];
        
        characters[length++] = base64[(buffer[0] & 0xFC) >> 2];
        
        characters[length++] = base64[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        
        if (bufferLength > 1)
            
            characters[length++] = base64[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        
        else characters[length++] = '=';
        
        if (bufferLength > 2)
            
            characters[length++] = base64[buffer[2] & 0x3F];
        
        else characters[length++] = '=';
        
    }
    NSString * g=[[NSString alloc]initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];

    
    return g;
    
}*/

@end
