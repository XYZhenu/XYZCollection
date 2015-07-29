//
//  UIView+Line.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (UIViewLine)

+(UIView*)xyzSeparaterX:(CGFloat)x Y:(CGFloat)y W:(CGFloat)width{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 1)];
    view.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:226.0/255.0 alpha:1];
    return view;
}
+(UIView*)xyzSeparaterX:(CGFloat)x Y:(CGFloat)y H:(CGFloat)height{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 1, height)];
    view.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:226.0/255.0 alpha:1];
    return view;
}
-(void)xyzSeparaterLeft:(CGFloat)left right:(CGFloat)right top:(CGFloat)top bottom:(CGFloat)bottom{
    if (left>1) {
        UIView* view = [UIView xyzSeparaterX:0 Y:(self.height-left)/2 H:left];
        [self addSubview:view];
    }
    if (right>1) {
        UIView* view = [UIView xyzSeparaterX:self.width-1 Y:(self.height-right)/2 H:right];
        [self addSubview:view];
    }
    if (top>1) {
        UIView* separ = [UIView xyzSeparaterX:(self.width-top)/2 Y:0 W:top];
        [self addSubview:separ];
    }
    if (bottom>1) {
        UIView* separ = [UIView xyzSeparaterX:(self.width-bottom)/2 Y:self.height-1 W:bottom];
        [self addSubview:separ];
    }
    
}
-(void)xyzShowBorder:(UIColor*)bordercolor cornerRadius:(CGFloat)radius{
    self.layer.borderWidth=1;
    self.layer.cornerRadius=radius;
    if (bordercolor) {
        self.layer.borderColor=bordercolor.CGColor;
    }else{
        self.layer.borderColor=[UIColor grayColor].CGColor;
    }
    self.layer.masksToBounds=YES;
}
@end
