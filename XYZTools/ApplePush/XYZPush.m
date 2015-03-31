//
//  XYZPush.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZPush.h"
#import "XYZMacros.h"
#import <UIKit/UIKit.h>

@implementation XYZPush
+(void)AppFirstEnter{
    SetPushOn(YES);
    SetPushAlert(YES);
    SetPushSound(YES);
}

+(void)RemoteNotifiSwitch{
    if (!PushOn) {
        [Application unregisterForRemoteNotifications];
        return;
    }
    
    if (PushAlert) {
        if (PushSound) {
            if (IsiOS8_OR_Higher) {
                [Application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge) categories:nil]];
                [Application registerForRemoteNotifications];
            }
            else
            {
                [Application registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge ];
            }
        }else{
            if (IsiOS8_OR_Higher) {
                [Application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge) categories:nil]];
                [Application registerForRemoteNotifications];
            }
            else
            {
                [Application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge ];
            }
        }
    }else{
        if (PushSound) {
            if (IsiOS8_OR_Higher) {
                [Application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeBadge) categories:nil]];
                [Application registerForRemoteNotifications];
            }
            else
            {
                [Application registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge ];
            }
        }else{
            if (IsiOS8_OR_Higher) {
                [Application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge) categories:nil]];
                [Application registerForRemoteNotifications];
            }
            else
            {
                [Application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge ];
            }
        }
    }
}


+(void)dealWithRemoteNotification:(NSDictionary *)launchOptions{
    [self RemoteNotifiSwitch];
    NSDictionary*userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if(userInfo)
    {
        [self application:Application didReceiveRemoteNotification:userInfo];
    }
}

+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * token=[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]; //去掉"<>"
    token=[[token description] stringByReplacingOccurrencesOfString:@" " withString:@""]; //去掉中间空格
    XYZLOG(@"%@",token);
    if (token) {
        SetPushToken(token);
    }
}
+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    XYZLOG(@"收到推送消息 :  %@ \n%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"],userInfo);    
    
}
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
    
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    XYZLOG(@"Error in registratiion for APNS. Error:%@",error);
    application.applicationIconBadgeNumber-=1;
}
@end
