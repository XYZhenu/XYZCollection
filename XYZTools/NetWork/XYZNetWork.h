//
//  XYZNetWork.h
//  beauty
//
//  Created by xieyan on 15-2-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RequestTimeOut 5
#define NetFailed @"网络异常"

@interface XYZNetWork : NSObject
+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed;

+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed netFailed:(void(^)(NSString *error))netFailed;

+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed HUDInView:(UIView*)view;

+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed netFailed:(void(^)(NSString *error))netFailed HUDInView:(UIView*)view;

//+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed HUDInViewWithAlert:(UIView*)view;
//
//+(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed netFailed:(void(^)(NSString *error))netFailed HUDInViewWithAlert:(UIView*)view;

+(void)HttpRequestWithUrl:(NSString*)url ConstructParmater:(NSDictionary*(^)())constructor succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed netFailed:(void(^)(NSString *error))netFailed HUDInView:(UIView*)view;
+(void)HttpRequestWithUrl:(NSString*)url ConstructParmater:(NSDictionary*(^)())constructor succeed:(void(^)(NSDictionary* responseDic))succeed failed:(void(^)(NSString* reason))failed HUDInView:(UIView*)view;



/**
 *  图片处理
 */
+(void)loadImage:(NSString*) imageUrl complete:(void(^)(UIImage* image))complete placeholder:(UIImage *)pImage  underControl:(BOOL)underControl;
+(void)loadImage:(NSString*) imageUrl complete:(void(^)(UIImage* image))complete;
@end





