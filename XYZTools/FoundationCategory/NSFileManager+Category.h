//
//  NSFileManager+Category.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FileManager [NSFileManager defaultManager]

#define xyzPathMain NSHomeDirectory()

#define xyzPathTmp NSTemporaryDirectory()

#define xyzPathLibrary [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]

#define xyzPathDocment [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define xyzPathCaches [xyzPathLibrary stringByAppendingPathComponent:@"Caches"]

#define xyzPathCacheIn(__folder__) [NSBundle xyzPathCacheOf:__folder__]


@interface  NSFileManager (NSFileManagerCategory)

+(NSString*)xyzPathCacheOf:(NSString*)interPath;
+(void)RemoveCachePath:(NSString*)path;

+(NSString*)xyzPathDocumentOf:(NSString*)interPath;
@end
 