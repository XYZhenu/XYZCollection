//
//  LocalNotificationManager.m
//  shell
//
//  Created by xieyan on 15/4/13.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "LocalNotificationManager.h"
#import "JSONKit.h"
#import <Foundation/NSDate.h>

@implementation LocalNotificationManager
+(instancetype)instance{
    static LocalNotificationManager* manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager=[[LocalNotificationManager alloc] init];
    });
    return manager;
}


/**
 *  闹钟
 */
-(NSMutableArray *)localAlerts{
    if (!_localAlerts) {
        _localAlerts = [NSMutableArray arrayWithCapacity:10];
        
        [_localAlerts addObjectsFromArray:self.defaultNotification];
        
        NSArray* array = [self parseAlertDics];
        for (int i=0; i<array.count; i++) {
            XYZAlertmodel* model = [[XYZAlertmodel alloc] init];
            model.dataDic = array[i];
            [_localAlerts addObject:model];
        }
    }
    return _localAlerts;
}

-(void)addAlert:(XYZAlertmodel*)model{
    [self.localAlerts insertObject:model atIndex:0];
    [self storeAlerts];
}
-(void)removeAlert:(XYZAlertmodel*)model{
    [model unschedule];
    for (int i=0; i<self.localAlerts.count; i++) {
        [self.localAlerts removeObject:model];
    }
    
    [self storeAlerts];
}



#pragma mark -- 存储闹钟

-(void)addAlertDic:(NSDictionary*)AlertDic{
    NSMutableArray* arrar = [NSMutableArray arrayWithArray:[self parseAlertDics]];
    [arrar insertObject:AlertDic atIndex:0];
    [self storeAlertDics:arrar];
}
-(void)storeAlerts{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
    
    for (int i=0; i<self.localAlerts.count; i++) {
        XYZAlertmodel* model = self.localAlerts[i];
        [array addObject:model];
    }
    
    [self storeAlertDics:array];
}

-(void)storeAlertDics:(NSArray*)AlertDicArray{
    NSData* data = [AlertDicArray JSONData];
    SetLocalAlert(data);
}
-(NSArray*)parseAlertDics{
    NSData* data = LocalAlert;
    NSArray* array = [data objectFromJSONData];
    return array;
}





/**
 *  本地通知
 *
 */

+(void)registNotify:(NSDate*)firedate repeatScheme:(NSCalendarUnit)scheme message:(NSString*)message userInfo:(NSDictionary*)info{
    UILocalNotification* notify = [[UILocalNotification alloc] init];
    
    notify.fireDate = firedate;
    notify.timeZone = [NSTimeZone defaultTimeZone];
    notify.repeatInterval = scheme;
    notify.soundName = UILocalNotificationDefaultSoundName;
    notify.alertBody = message;
    notify.userInfo=info;
    
    [Application scheduleLocalNotification:notify];
}
+(void)unRegistNotify:(NSString*)key{
    if (!key) {
        return;
    }
    NSArray* notifies = [self findLocalNotify:key];
    for (UILocalNotification* noti in notifies) {
        [Application cancelLocalNotification:noti];
    }
}

+(NSArray*)findLocalNotify:(NSString*)key{
    UIApplication* app = Application;
    NSArray* scheduleNotify = app.scheduledLocalNotifications;
    //    UILocalNotification* notify = nil;
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:5];
    
    for (UILocalNotification* noti in scheduleNotify) {
        NSDictionary* dic = noti.userInfo;
        NSString* dickey = dic[@"identifier"];
        if (dickey&&[dickey isEqualToString:key]) {
            [array addObject:noti];
        }
    }
    return array;
}
+(NSString*)stringDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    return [dateFormatter stringFromDate:date];
}
+(NSDate*)dateFromString:(NSString*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    return [dateFormatter dateFromString:date];
}
@end
void schedulNotificationWithYear(int year,int month,int day,int hour, int minute, NSString * message){
    
    // Set up the fire time
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:day];
    [dateComps setMonth:month];
    [dateComps setYear:year];
    [dateComps setHour:hour];
    // Notification will fire in one minute
    [dateComps setMinute:minute];
    [dateComps setSecond:0];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    // Notification details
    localNotif.alertBody = message;
    // Set the action button
    localNotif.alertAction = @"查看";
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    //    localNotif.applicationIconBadgeNumber = 1;
    
    // Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
    
    // Schedule the notification
    [Application scheduleLocalNotification:localNotif];
}


@interface XYZAlertmodel ()
@property(nonatomic,strong)NSArray*LocalNotifies;
@end
@implementation XYZAlertmodel
@synthesize alertTime = _alertTime;
@synthesize onState=_onState;
-(instancetype)init{
    self=[super init];
    if (self) {
        _title=@"未设置内容";
        _content=_title;
        _isDefault=NO;
        
        _subIdentifier=[NSDate date].description;
        _onState=NO;
        _weekdays=@"0,0,0,0,0,0,0";
        _scheme=XYZAlertWeakly;
        
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    _title=title;
    if (self.dataDic) {
        [self.dataDic setValue:title forKey:@"title"];
    }
}
-(void)setIcon:(NSString *)icon{
    _icon=icon;
    if (self.dataDic) {
        [self.dataDic setValue:icon forKey:@"icon"];
    }
}
-(void)setContent:(NSString *)content{
    _content = content;
    if (self.dataDic) {
        [self.dataDic setValue:content forKey:@"content"];
    }
}
-(void)setSubIdentifier:(NSString *)subIdentifier{
    _subIdentifier=subIdentifier;
    if (self.dataDic) {
        [self.dataDic setValue:subIdentifier forKey:@"subIdentifier"];
    }
}
-(void)setWeekdays:(NSString *)weekdays{
    _weekdays=weekdays;
    if (self.dataDic) {
        [self.dataDic setValue:weekdays forKey:@"weekdays"];
    }
}

-(void)setScheme:(XYZAlertScheme)scheme{
    _scheme=scheme;
    if (self.dataDic) {
        [self.dataDic setValue:[NSString stringWithFormat:@"%d",scheme] forKey:@"scheme"];
    }
}
-(void)setAlertTime:(NSDate *)alertTime{
    _alertTime=alertTime;
    if (self.dataDic) {
        [self.dataDic setValue:[LocalNotificationManager stringDate:alertTime] forKey:@"alerttime"];
    }
}
-(NSDate *)alertTime{
    if (!_alertTime) {
        return [NSDate date];
    }else{
        return _alertTime;
    }
}
-(NSString *)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:self.alertTime];
}
-(NSString *)repeatString{
    NSString* string = @"未设置";
    switch (self.scheme) {
        case XYZAlertYearly:{
            string=@"每年";
            break;
        }
        case XYZAlertMonthly:{
            string=@"每月";
            break;
        }
        case XYZAlertWeakly:{
            NSArray* array = [self.weekdays componentsSeparatedByString:@","];
            NSArray* chars = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
            NSMutableString* constructstr = [NSMutableString string];
            
            for (int i=0; i<7; i++) {
                NSString* str = array[i];
                if ([str isEqualToString:@"1"]) {
                    [constructstr appendFormat:@"，%@",chars[i]];
                }
            }
            
            if (constructstr.length<2) {
            }else{
                string=[@"每周" stringByAppendingString:[constructstr substringFromIndex:1]];
            }
            break;
        }
            
        default:
            break;
    }
    return string;
}
-(void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    self.title=_dataDic[@"title"];
    self.icon=_dataDic[@"icon"];
    self.content=_dataDic[@"content"];
    self.subIdentifier=_dataDic[@"subIdentifier"];
    self.weekdays=_dataDic[@"weekdays"];
    NSString* string = _dataDic[@"scheme"];
    if (string) {
        self.scheme = [string intValue];
    }
    string = _dataDic[@"alerttime"];
    if (string) {
        self.alertTime = [LocalNotificationManager dateFromString:string];
    }
}
-(NSString *)superIdentifier{
    return @"shell";
}
-(void)setSuperIdentifier:(NSString *)superIdentifier{
    
}
-(NSString *)identifier{
    return [self.superIdentifier stringByAppendingString:_subIdentifier];
}
-(NSArray *)LocalNotifies{
    if (!_LocalNotifies) {
        _LocalNotifies = [LocalNotificationManager findLocalNotify:self.identifier];
    }
    return _LocalNotifies;
}
-(BOOL)onState{
    if (self.dataDic==nil) {
        return NO;
    }
    NSArray* array = self.LocalNotifies;
    if (!array) {
        return NO;
    }
    if (array.count==0) {
        return NO;
    }
    return YES;
}
-(void)setOnState:(BOOL)onState{
    _onState=onState;
    if (onState) {
        [self scheduleup];
    }else{
        [self unschedule];
    }
}
-(NSString *)state{
    if (!self.onState) {
        return @"未开启";
    }
    if (self.LocalNotifies.count==0) {
        return @"未开启";
    }
    NSDate* date = [NSDate distantFuture];
    
    for (UILocalNotification* notify in self.LocalNotifies) {
        date = [date earlierDate:notify.fireDate];
    }
    NSString* state = @"";
    
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSDateComponents* component = [calender components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date] toDate:date options:0];
    NSInteger unit = component.month;
    if (unit>0) {
        [state stringByAppendingFormat:@"%d月 ",unit];
    }
    
    unit = component.day;
    if (unit>0) {
        [state stringByAppendingFormat:@"%d天 ",unit];
    }

    unit = component.hour;
    if (unit>0) {
        [state stringByAppendingFormat:@"%d小时 ",unit];
    }
    
    unit = component.minute;
    if (unit>0) {
        [state stringByAppendingFormat:@"%d分钟 ",unit];
    }
    return state;
}
-(void)unschedule{
    [LocalNotificationManager unRegistNotify:self.identifier];
}
-(void)scheduleup{
    [self unschedule];
    switch (self.scheme) {
        case XYZAlertYearly:{
            [LocalNotificationManager registNotify:self.alertTime repeatScheme:NSCalendarUnitYear message:self.content userInfo:@{@"identifier":self.identifier,@"weekdays":self.weekdays}];
            break;
        }
        case XYZAlertMonthly:{
            [LocalNotificationManager registNotify:self.alertTime repeatScheme:NSCalendarUnitMonth message:self.content userInfo:@{@"identifier":self.identifier,@"weekdays":self.weekdays}];
            break;
        }
        case XYZAlertWeakly:{
            NSArray* array = [self.weekdays componentsSeparatedByString:@","];
            
            NSMutableArray* validarray = [NSMutableArray arrayWithCapacity:7];
            for (int i=0; i<7; i++) {
                if (array.count<i+1) {
                    [validarray addObject:@"0"];
                }else{
                    [validarray addObject:array[i]];
                }
            }
            
            for (int i=0; i<7; i++) {
                if ([validarray[i] isEqualToString:@"1"]) {
                    int j=i+1;
                    if (j==7) {
                        j=0;
                    }
                    
                    [LocalNotificationManager registNotify:[self WeekDayFromNow:j+1] repeatScheme:NSCalendarUnitWeekday message:self.content userInfo:@{@"identifier":self.identifier,@"weekdays":self.weekdays}];
                }
            }
            
            break;
        }
            
        default:
            break;
    }
    
}
-(NSDate*)WeekDayFromNow:(NSInteger)weekday{
    NSDate* date = [NSDate date];    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger nowWeekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDateComponents * intervalCompo = [[NSDateComponents alloc] init];
    intervalCompo.day=weekday - nowWeekday;
    
    NSDate* finaldate = [calendar dateByAddingComponents:intervalCompo toDate:date options:NSCalendarWrapComponents];
    
//    int delta = weekday-nowWeekday;
//    if (delta==0) {
//        
//    }

    return finaldate;
}
@end