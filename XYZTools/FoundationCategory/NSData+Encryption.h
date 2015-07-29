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
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
+(NSString *)Aes256EncryptWithKey:(NSString *)secret; //用此方法直接加密
@end
