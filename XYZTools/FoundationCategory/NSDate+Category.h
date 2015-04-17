//
//  NSDate+Category.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDateCategory)
-(NSString*)xyzDate:(NSString*)formate;
-(NSString*)xyzDate;
-(NSString*)xyzTime;

+(instancetype)dateWithYear:(int)year Month:(int)month Day:(int)day Hour:(int)hour Minute:(int)minute;
-(NSDate*)weekDayFromNow:(NSInteger)weekday;

-(NSInteger)weekDay;

@end
