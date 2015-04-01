//
//  UILabel+Factory.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UILabel+Factory.h"

@implementation UILabel (UILabelFactory)
+(UILabel*)xyzLabelFrame:(CGRect)frame Font:(NSInteger)size TextColor:(UIColor*)textColor BGColor:(UIColor *)bgColor Content:(NSString*)content Aliment:(NSTextAlignment)aliment{
    if (!textColor) {
        textColor = [UIColor blackColor];
    }
    if (!bgColor) {
        bgColor = [UIColor whiteColor];
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    
    label.font=[UIFont systemFontOfSize:size];
    
    label.textAlignment = aliment;
    
    label.text = content;
    
    label.textColor = textColor;
    
    label.backgroundColor=bgColor;
    
    return label;
}
+(UILabel*)xyzLabelFrame:(CGRect)frame Font:(NSInteger)size TextColor:(UIColor*)textColor BGColor:(UIColor *)bgColor Content:(NSString*)content{
    return [UILabel xyzLabelFrame:frame Font:size TextColor:textColor BGColor:bgColor Content:content Aliment:NSTextAlignmentLeft];
}
@end
