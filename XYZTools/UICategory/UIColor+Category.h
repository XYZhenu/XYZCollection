//
//  UIColor+Category.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CCC0x(__HEX__) [UIColor hex0xColor:__HEX__]
#define CCC3(_R_,_G_,_B_) [UIColor colorWithRed:_R_/255.0 green:_G_/255.0  blue:_B_/255.0  alpha:1]

#define CCC4(_R_,_G_,_B_,_A_) [UIColor colorWithRed:_R_/255.0 green:_G_/255.0  blue:_B_/255.0  alpha:_A_]
@interface UIColor (UIColorCategory)
+(instancetype)hexStringColor:(NSString*)hexColor;
+(instancetype)hex0xColor:(NSInteger)OxNum;
@end
