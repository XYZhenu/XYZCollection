//
//  NSData+Encryption.h
//  city
//
//  Created by 郜路阳 on 15/2/4.
//  Copyright (c) 2015年 郜路阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSString;
@interface NSData (Encryption)
//-(NSData *)AES256EncryptWithKey:(NSString *)key; //加密
-(NSData *)AES256EncryptWithKey:(NSData *)key; //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
+(NSString *)Aes256EncryptWithKey:(NSString *)secret; //用此方法直接加密
-(NSString *)Aes256EncryptWithKey:(NSString *)secret; //用此方法直接加密
//- (NSString *)newStringInBase64FromData;           //追加64编码
//+ (NSString*)base64encode:(NSString*)str;
@end
