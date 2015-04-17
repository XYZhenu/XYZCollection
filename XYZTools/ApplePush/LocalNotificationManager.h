//
//  LocalNotificationManager.h
//  shell
//
//  Created by xieyan on 15/4/13.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  所有本地通知
 */
#define SetLocalAlert(__alert__) UserSetObj(__alert__,@"localalerts")
#define LocalAlert UserGetData(@"localalerts")

typedef enum{XYZAlertWeakly,XYZAlertMonthly,XYZAlertYearly} XYZAlertScheme;
@interface XYZAlertmodel : NSObject
@property (nonatomic,strong) NSString    * title;
@property (nonatomic,strong) NSString    * icon;
@property (nonatomic,strong) NSString    * content;
@property (nonatomic,strong) NSString    * state;

@property (nonatomic,strong) NSString    * identifier;
@property (nonatomic,strong) NSString    * superIdentifier;
@property (nonatomic,strong) NSString    * subIdentifier;

@property (nonatomic       ) BOOL onState;


@property (nonatomic,strong) NSString    * weekdays;

@property (nonatomic       ) XYZAlertScheme scheme;
@property (nonatomic,strong) NSString    * repeatString;

@property(nonatomic,strong) NSMutableDictionary* dataDic;
@property(nonatomic,strong,setter=setAlertTime:) NSDate* alertTime;
@property (nonatomic,strong) NSString    * time;


@property(nonatomic) BOOL isDefault;
-(void)scheduleup;
-(void)unschedule;

@end





void schedulNotificationWithYear(int year,int month,int day,int hour, int minute, NSString * message);



@interface LocalNotificationManager : NSObject
+(instancetype)instance;

@property(nonatomic,strong) NSMutableArray* localAlerts;//查
-(void)addAlert:(XYZAlertmodel*)model;//增
-(void)removeAlert:(XYZAlertmodel*)model;//删

//改   放入model中



+(void)registNotify:(NSDate*)firedate repeatScheme:(NSCalendarUnit)scheme message:(NSString*)message userInfo:(NSDictionary*)info;
+(void)unRegistNotify:(NSString*)key;
+(NSArray*)findLocalNotify:(NSString*)key;



@property(nonatomic,strong) NSArray* defaultNotification;
@end
/*
 NSMutableArray* array = [NSMutableArray arrayWithCapacity:3];
 
 XYZAlertmodel* (^buildModel)(NSString* title,NSString*icon,NSString* content,NSString* identifier) = ^(NSString* title,NSString*icon,NSString* content,NSString* identifier){
 XYZAlertmodel* model = [[XYZAlertmodel alloc] init];
 model.title=title;
 model.icon=icon;
 model.content=content;
 model.subIdentifier=identifier;
 model.scheme=XYZAlertWeakly;
 
 NSArray* array = [LocalNotificationManager findLocalNotify:identifier];
 if (array.count>0) {
 UILocalNotification* noti = array[0];
 NSDictionary* dic = noti.userInfo;
 model.weekdays=dic[@"weekdays"];
 if (!model.weekdays) {
 model.weekdays=@"0,0,0,0,0,0,0";
 }
 }else{
 model.weekdays=@"0,0,0,0,0,0,0";
 }
 model.isDefault=YES;
 return model;
 };
 
 [array addObject:buildModel(@"firstdefault",@"finder-feed",@"this is default alert message",@"firstdefault")];
 [array addObject:buildModel(@"seconddefault",@"finder-fertilier",@"this is default alert message",@"seconddefault")];
 [array addObject:buildModel(@"seconddefault",@"finder-refreWater",@"this is default alert message",@"seconddefault")];
 [LocalNotificationManager instance].defaultNotification=array;


*/