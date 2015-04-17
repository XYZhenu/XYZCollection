//
//  NSDate+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (NSDateCategory)
-(NSString*)xyzDate:(NSString*)formate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm +0800"];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter stringFromDate:self];
}
-(NSString*)xyzDate{
    return [self xyzDate:@"yyyy-MM-dd"];
}
-(NSString*)xyzTime{
    return [self xyzDate:@"HH:mm"];
}
+(instancetype)dateWithYear:(int)year Month:(int)month Day:(int)day Hour:(int)hour Minute:(int)minute{
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:day];
    [dateComps setMonth:month];
    [dateComps setYear:year];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:0];
    return  [calendar dateFromComponents:dateComps];
}
-(NSInteger)weekDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger nowWeekday = [comps weekday]-1; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    if (nowWeekday==0) {
        nowWeekday=7;
    }
    return nowWeekday;
}
-(NSDate*)weekDayFromNow:(NSInteger)weekday{    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger nowWeekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDateComponents * intervalCompo = [[NSDateComponents alloc] init];
    int interval = weekday - nowWeekday;
    if (interval<0) {
        interval+=7;
    }
    intervalCompo.day=interval;
    NSDate* finaldate = [calendar dateByAddingComponents:intervalCompo toDate:self options:NSCalendarWrapComponents];
    
    return finaldate;
}
@end
