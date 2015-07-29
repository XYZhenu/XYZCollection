//
//  ProgressLoader.m
//  XYZCollection
//
//  Created by xieyan on 15/5/4.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "ProgressLoader.h"

@implementation ProgressLoader
-(void)downloadWithUrl:(id)url
             cachePath:(NSString*)cachePath
         progressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progressBlock
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    self.cachePath = cachePath;
    //获取缓存的长度
    long long cacheLength = [[self class] cacheFileWithPath:self.cachePath];
    
    NSLog(@"cacheLength = %llu",cacheLength);
    
    //获取请求
    NSMutableURLRequest* request = [[self class] requestWithUrl:url Range:cacheLength];
    
    
    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [self.requestOperation setOutputStream:[NSOutputStream outputStreamToFileAtPath:self.cachePath append:NO]];
    
    //处理流
    [self readCacheToOutStreamWithPath:self.cachePath];
    
    
    [self.requestOperation addObserver:self forKeyPath:@"isPaused" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    //获取进度块
    self.progressBlock = progressBlock;
    
    
    //重组进度block
    [self.requestOperation setDownloadProgressBlock:[self getNewProgressBlockWithCacheLength:cacheLength]];
    
    
    //获取成功回调块
    void (^newSuccess)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"responseHead = %@",[operation.response allHeaderFields]);
        
        success(operation,responseObject);
    };
    
    
    [self.requestOperation setCompletionBlockWithSuccess:newSuccess
                                                 failure:failure];
    [self.requestOperation start];
    
    
}


#pragma mark - 获取本地缓存的字节
+(long long)cacheFileWithPath:(NSString*)path
{
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:path];
    
    NSData* contentData = [fh readDataToEndOfFile];
    return contentData ? contentData.length : 0;
    
}


#pragma mark - 重组进度块
-(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))getNewProgressBlockWithCacheLength:(long long)cachLength
{
    typeof(self)newSelf = self;
    void(^newProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) = ^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
    {
        NSData* data = [NSData dataWithContentsOfFile:self.cachePath];
        [self.requestOperation setValue:data forKey:@"responseData"];
        //        self.requestOperation.responseData = ;
        newSelf.progressBlock(bytesRead,totalBytesRead + cachLength,totalBytesExpectedToRead + cachLength);
    };
    
    return newProgressBlock;
}


#pragma mark - 读取本地缓存入流
-(void)readCacheToOutStreamWithPath:(NSString*)path
{
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData* currentData = [fh readDataToEndOfFile];
    
    if (currentData.length) {
        //打开流，写入data ， 未打卡查看 streamCode = NSStreamStatusNotOpen
        [self.requestOperation.outputStream open];
        
        NSInteger       bytesWritten;
        NSInteger       bytesWrittenSoFar;
        
        NSInteger  dataLength = [currentData length];
        const uint8_t * dataBytes  = [currentData bytes];
        
        bytesWrittenSoFar = 0;
        do {
            bytesWritten = [self.requestOperation.outputStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
            assert(bytesWritten != 0);
            if (bytesWritten == -1) {
                break;
            } else {
                bytesWrittenSoFar += bytesWritten;
            }
        } while (bytesWrittenSoFar != dataLength);
        
        
    }
}

#pragma mark - 获取请求

+(NSMutableURLRequest*)requestWithUrl:(id)url Range:(long long)length
{
    NSURL* requestUrl = [url isKindOfClass:[NSURL class]] ? url : [NSURL URLWithString:url];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:5*60];
    
    
    if (length) {
        [request setValue:[NSString stringWithFormat:@"bytes=%lld-",length] forHTTPHeaderField:@"Range"];
    }
    
    NSLog(@"request.head = %@",request.allHTTPHeaderFields);
    
    return request;
    
}



#pragma mark - 监听暂停
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keypath = %@ changeDic = %@",keyPath,change);
    //暂停状态
    if ([keyPath isEqualToString:@"isPaused"] && [[change objectForKey:@"new"] intValue] == 1) {
        
        
        
        long long cacheLength = [[self class] cacheFileWithPath:self.cachePath];
        //暂停读取data 从文件中获取到NSNumber
        cacheLength = [[self.requestOperation.outputStream propertyForKey:NSStreamFileCurrentOffsetKey] unsignedLongLongValue];
        NSLog(@"cacheLength = %lld",cacheLength);
        [self.requestOperation setValue:@"0" forKey:@"totalBytesRead"];
        //重组进度block
        [self.requestOperation setDownloadProgressBlock:[self getNewProgressBlockWithCacheLength:cacheLength]];
    }
}










-(NSString*)cachedFilePath:(NSString*)imageUrl{
    NSArray * pathComponents = [imageUrl componentsSeparatedByString:@"/"];
    NSString * fileName;
    if (pathComponents && [pathComponents count]>0) {
        fileName = [pathComponents lastObject];
    }else{
        fileName = imageUrl;
    }
    
    if (!fileName) {
        fileName=@"";
    }
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray objectAtIndex:0];
    NSString* imagePath = [cachePath stringByAppendingPathComponent:@"images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:imagePath isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"Create Directory Failed.");
        }
    }
    
    fileName=[imagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    return fileName;
}

#define ProgressTag 131324

-(void)imageView:(UIImageView*)imageView 
       loadImage:(NSString*)imageUrl 
defaultImageName:(NSString*)imageName 
    underControl:(BOOL)underControl 
        complete:(void(^)(UIImage* image))complete{
    
    NSString* filePath = [self cachedFilePath:imageUrl];
    
    UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    
    UIView* progressCoverView = [imageView viewWithTag:ProgressTag];
    
    if (image) {
        imageView.image=image;
        if (progressCoverView) {
            progressCoverView.hidden=YES;
            
            if (complete) {
                complete(image);
            }
        }
        return;
    }
    
    if (!progressCoverView) {
        UIView* cover = [[UIView alloc] initWithFrame:imageView.bounds];
        cover.backgroundColor=ColorBackGroundGray;
        UIProgressView* progrss = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        
//        progrss.progressTintColor = ColorBlue;
        
        progrss.frame=CGRectMake(0, cover.height/2, cover.width, 2);
        
        progrss.tag = ProgressTag+1;
        
        [cover addSubview:progrss];
        
        cover.tag = ProgressTag;
        
        [imageView addSubview:cover];
    }
    
    
    
    NSString* imageon = ImageOn;
    
    if (!imageon) {
        SetImageOn(@"1");
    }
    
    
    
    if ([imageon isEqualToString:@"1"] || !underControl) {
        progressCoverView.hidden=NO;
        
        
        [self downloadWithUrl:imageUrl cachePath:filePath progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            UIView* view1 = [imageView viewWithTag:ProgressTag];
            
            
            UIProgressView* progrssView = [view1 viewWithTag:ProgressTag+1];
            
            
            float progress = totalBytesRead / (float)totalBytesExpectedToRead;
            
            [progrssView setProgress:progress animated:YES];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIImage* imageDownloaded = [UIImage imageWithContentsOfFile:filePath];
            
            if (complete) {
                complete(imageDownloaded);
            }
            
            UIView* cover = [imageView viewWithTag:ProgressTag];
            
            cover.hidden=YES;
            imageView.image = imageDownloaded;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIView* cover = [imageView viewWithTag:ProgressTag];
            
            cover.hidden=YES;
            
            imageView.image = [UIImage imageNamed:imageName];
        }];
    }else{
        progressCoverView.hidden=YES;
        
        imageView.image = [UIImage imageNamed:imageName];
    }
}


+(instancetype)imageView:(UIImageView*)imageView 
               loadImage:(NSString*)imageUrl 
        defaultImageName:(NSString*)imageName 
            underControl:(BOOL)underControl 
                complete:(void(^)(UIImage* image))complete{
    ProgressLoader* SELF = [[self alloc] init];
    
    [SELF imageView:imageView loadImage:imageUrl defaultImageName:imageName underControl:underControl complete:complete];
    
    return SELF;
}
@end
