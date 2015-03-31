//
//  XYZPush.h
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZPush : NSObject
+(void)AppFirstEnter;//第一次开启应用
+(void)dealWithRemoteNotification:(NSDictionary *)launchOptions;//直接调用它就行

+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;//看里面的代码，自己定制




+(void)RemoteNotifiSwitch;
@end
