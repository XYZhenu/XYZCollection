//
//  UILabel+Factory.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  UILabel (UILabelFactory)
+(UILabel*)xyzLabelFrame:(CGRect)frame Font:(NSInteger)size TextColor:(UIColor*)textColor BGColor:(UIColor *)bgColor Content:(NSString*)content Aliment:(NSTextAlignment)aliment;
+(UILabel*)xyzLabelFrame:(CGRect)frame Font:(NSInteger)size TextColor:(UIColor*)textColor BGColor:(UIColor *)bgColor Content:(NSString*)content;

@end
