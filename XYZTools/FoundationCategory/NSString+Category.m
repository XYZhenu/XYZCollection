//
//  NSString+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+(NSString*)intString:(NSInteger)number{
    return [NSString stringWithFormat:@"%d",number];
}
+(NSString*)floatString:(CGFloat)number{
    return [NSString stringWithFormat:@"%02f",number];
}
@end
