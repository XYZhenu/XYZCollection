//
//  XYZNetWork.m
//  beauty
//
//  Created by xieyan on 15-2-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZNetWork.h"
#import "AFNetworking.h"
#import "NSData+Encryption.h"
#import "MBProgressHUD.h"
#import "KVNProgress.h"
#import "JSONKit.h"

@implementation XYZNetWork
+(void)HttpRequestWithUrl:(NSString *)url parmater:(NSDictionary *)parmaDic succeed:(void (^)(NSDictionary *))succeed failed:(void (^)(NSString *))failed{
    [self HttpRequestWithUrl:url parmater:parmaDic succeed:succeed failed:failed netFailed:nil];
}

+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed netFailed:(void(^)(NSString *error))netFailed{    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary* tokenDic = [NSMutableDictionary dictionaryWithDictionary:parmaDic];
    NSString* time = [NSString stringWithFormat:@"%llu",(long long)[NSDate date].timeIntervalSince1970*1000];
    [tokenDic setValue:time forKey:@"token_time"];
    
    NSString *token = [tokenDic JSONString];
    NSString* parmater = [NSData Aes256EncryptWithKey:token];
    
    NSDictionary * dddddddd;
    if (parmater) {
        dddddddd=[NSDictionary dictionaryWithObject:parmater forKey:@"token"];
    }
    
//    XYZLOG(@"tokenDic ####   %@\nurl  #### %@\n",tokenDic,url);
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:dddddddd success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dic = responseObject;
        switch ([dic[@"status"] integerValue]) {
            case 1:{
                succeed(dic);
                break;
            }
            case 0:{
                failed(dic[@"reason"]);
                break;
            }
            default:
                break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XYZLOG(@"Error: %@", error);
        if (netFailed) {
            netFailed(error.description);
        }
    }];
}
+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary *)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed HUDInView:(UIView*)view{
    BOOL useKVN = NO;
    void(^hideHUD)();
    if (useKVN) {
//        [UIActivityIndicatorView ];
        [KVNProgress show];
        hideHUD=^{[KVNProgress dismiss];};
    }else{
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        hideHUD=^{[MBProgressHUD hideHUDForView:view animated:YES];};
    }
    [self HttpRequestWithUrl:url parmater:parmaDic succeed:^(NSDictionary *responseDic) {
        hideHUD();
        succeed(responseDic);
    } failed:^(NSString *reason) {
        hideHUD();
        failed(reason);
    } netFailed:^(NSString *error) {
        [UIAlertView pushAlert:NetFailed];
        hideHUD();
    }];
}

+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed netFailed:(void(^)(NSString *error))netFailed HUDInView:(UIView*)view{
    BOOL useKVN = NO;
    void(^hideHUD)();
    if (useKVN) {
        [KVNProgress show];
        hideHUD=^{[KVNProgress dismiss];};
    }else{
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        hideHUD=^{[MBProgressHUD hideHUDForView:view animated:YES];};
    }
    [self HttpRequestWithUrl:url parmater:parmaDic succeed:^(NSDictionary *responseDic) {
        succeed(responseDic);
        hideHUD();
    } failed:^(NSString *reason) {
        failed(reason);
        hideHUD();
    } netFailed:^(NSString *error) {
        netFailed(error);
        hideHUD();
    }];
}


+(void)HttpRequestWithUrl:(NSString*)url ConstructParmater:(NSDictionary*(^)())constructor succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed netFailed:(void(^)(NSString *error))netFailed HUDInView:(UIView*)view{
    BOOL useKVN = NO;
    void(^hideHUD)();
    if (useKVN) {
        [KVNProgress show];
        hideHUD=^{[KVNProgress dismiss];};
    }else{
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        hideHUD=^{[MBProgressHUD hideHUDForView:view animated:YES];};
    }
    NSDictionary*dic = constructor();
    [self HttpRequestWithUrl:url parmater:dic succeed:^(NSDictionary *responseDic) {
        succeed(responseDic);
        hideHUD();
    } failed:^(NSString *reason) {
        failed(reason);
        hideHUD();
    } netFailed:^(NSString *error) {
        netFailed(error);
        hideHUD();
    }];
}
+(void)HttpRequestWithUrl:(NSString*)url ConstructParmater:(NSDictionary*(^)())constructor succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed HUDInView:(UIView*)view{
    
    BOOL useKVN = NO;
    void(^hideHUD)();
    if (useKVN) {
        [KVNProgress show];
        hideHUD=^{[KVNProgress dismiss];};
    }else{
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        hideHUD=^{[MBProgressHUD hideHUDForView:view animated:YES];};
    }
    NSDictionary*dic = constructor();
    [self HttpRequestWithUrl:url parmater:dic succeed:^(NSDictionary *responseDic) {
        succeed(responseDic);
        hideHUD();
    } failed:^(NSString *reason) {
        failed(reason);
        hideHUD();
    } netFailed:^(NSString *error) {
        hideHUD();
    }];
}










+(void)loadImage:(NSString*) imageUrl complete:(void(^)(UIImage* image))complete placeholder:(UIImage *)pImage underControl:(BOOL)underControl
{
    
    NSArray * arr=[imageUrl componentsSeparatedByString:@"/"];
    if (arr && [arr count]>0) {
        
        NSString * s=[arr lastObject];
        if (!s) {
            s=@"";
        }
        
        NSArray *arrarPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filename = [arrarPath objectAtIndex:0];
        NSString* filename1 = [filename stringByAppendingPathComponent:@"images"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = FALSE;
        BOOL isDirExist = [fileManager fileExistsAtPath:filename1 isDirectory:&isDir];
        if(!(isDirExist && isDir))
        {
            BOOL bCreateDir = [fileManager createDirectoryAtPath:filename1 withIntermediateDirectories:YES attributes:nil error:nil];
            if(!bCreateDir){
                NSLog(@"Create Audio Directory Failed.");
            }
        }
        
        s=[filename stringByAppendingPathComponent:[NSString stringWithFormat:@"images/%@",s]];
        
        UIImage * image=[UIImage imageWithContentsOfFile:s];
        if (!image) {
            complete(pImage);
//            if (!ImageOn) {
//                SetImageOn(@"1");
//            }
//            if ([ImageOn isEqualToString:@"1"]||!underControl) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    // 下载图片
                    NSURL * url=[NSURL URLWithString:imageUrl];
                    NSData * data=[NSData dataWithContentsOfURL:url];
                    if (data) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 图片下载完
                            [data writeToFile:s atomically:YES];
                            complete([UIImage imageWithData:data]);
                        });
                    }
                    
                });
//            }
        }else{
            complete(image);
        }
        
    }
    
}
+(void)loadImage:(NSString*) imageUrl complete:(void(^)(UIImage* image))complete{
    NSArray * arr=[imageUrl componentsSeparatedByString:@"/"];
    if (arr && [arr count]>0) {
        
        NSString * s=[arr lastObject];
        if (!s) {
            s=@"";
        }
        
        NSArray *arrarPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filename = [arrarPath objectAtIndex:0];
        NSString* filename1 = [filename stringByAppendingPathComponent:@"images"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = FALSE;
        BOOL isDirExist = [fileManager fileExistsAtPath:filename1 isDirectory:&isDir];
        if(!(isDirExist && isDir))
        {
            BOOL bCreateDir = [fileManager createDirectoryAtPath:filename1 withIntermediateDirectories:YES attributes:nil error:nil];
            if(!bCreateDir){
                NSLog(@"Create Audio Directory Failed.");
            }
        }
        
        s=[filename stringByAppendingPathComponent:[NSString stringWithFormat:@"images/%@",s]];
        
        UIImage * image=[UIImage imageWithContentsOfFile:s];
        if (!image) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                // 下载图片
                NSURL * url=[NSURL URLWithString:imageUrl];
                NSData * data=[NSData dataWithContentsOfURL:url];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 图片下载完
                    [data writeToFile:s atomically:YES];
                    complete([UIImage imageWithData:data]);
                });
            });
        }else{
            complete(image);
        }
        
    }
}
@end
