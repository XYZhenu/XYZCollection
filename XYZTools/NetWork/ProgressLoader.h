//
//  ProgressLoader.h
//  XYZCollection
//
//  Created by xieyan on 15/5/4.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define ImageOn UserGetString(@"imageon")
#define SetImageOn(__KEY__) UserSetObj(__KEY__,@"imageon")

@interface ProgressLoader : NSObject
@property(nonatomic , strong) NSURL* url;
@property(nonatomic , copy) NSString* cachePath;
@property(nonatomic , strong) AFHTTPRequestOperation* requestOperation;
@property(nonatomic , copy) void(^progressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);


-(void)downloadWithUrl:(id)url
             cachePath:(NSString*)cachePath
         progressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progressBlock
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


+(instancetype)imageView:(UIImageView*)imageView 
               loadImage:(NSString*)imageUrl 
        defaultImageName:(NSString*)imageName 
            underControl:(BOOL)underControl 
                complete:(void(^)(UIImage* image))complete;
@end
