//
//  NSFileManager+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "NSFileManager+Category.h"

@implementation NSFileManager (NSFileManagerCategory)
+(NSString*)xyzPathCacheOf:(NSString*)interPath{
    NSString * path=[xyzPathCaches stringByAppendingPathComponent:interPath];
    
    NSFileManager *fileManager = FileManager;
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL CreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!CreateDir){
            NSLog(@"Create Audio Directory Failed.");
        }
    }
    return path;
}
+(void)RemoveCachePath:(NSString*)path{
    NSFileManager *fileManager = FileManager;
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
}
+(NSString*)xyzPathDocumentOf:(NSString*)interPath{
    NSString * path=[xyzPathDocment stringByAppendingPathComponent:interPath];
    
    NSFileManager *fileManager = FileManager;
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL CreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!CreateDir){
            NSLog(@"Create Audio Directory Failed.");
        }
    }
    return path;
}
@end
