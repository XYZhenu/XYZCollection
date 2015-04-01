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
@end
