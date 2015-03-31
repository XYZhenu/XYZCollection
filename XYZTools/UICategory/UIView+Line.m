//
//  UIView+Line.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (UIViewLine)

+(UIView*)separaterOriginX:(CGFloat)x Y:(CGFloat)y W:(CGFloat)width{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 1)];
    view.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:226.0/255.0 alpha:1];
    return view;
}
+(UIView*)separaterOriginX:(CGFloat)x Y:(CGFloat)y H:(CGFloat)height{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 1, height)];
    view.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:226.0/255.0 alpha:1];
    return view;
}
-(void)setSeparaterLeft:(CGFloat)left right:(CGFloat)right top:(CGFloat)top bottom:(CGFloat)bottom{
    if (left>1) {
        UIView* view = [UIView separaterOriginX:0 Y:(self.xyzHeight-left)/2 H:left];
        [self addSubview:view];
    }
    if (right>1) {
        UIView* view = [UIView separaterOriginX:self.xyzWidth-1 Y:(self.xyzHeight-right)/2 H:right];
        [self addSubview:view];
    }
    if (top>1) {
        UIView* separ = [UIView separaterOriginX:(self.xyzWidth-top)/2 Y:0 W:top];
        [self addSubview:separ];
    }
    if (bottom>1) {
        UIView* separ = [UIView separaterOriginX:(self.xyzWidth-bottom)/2 Y:self.xyzHeight-1 W:bottom];
        [self addSubview:separ];
    }
    
}
-(void)xyzShowBorder:(UIColor*)bordercolor cornerRadius:(CGFloat)radius{
    self.layer.borderWidth=1;
    self.layer.cornerRadius=radius;
    if (bordercolor) {
        self.layer.borderColor=bordercolor.CGColor;
    }else{
        self.layer.borderColor=ColorSeparateLine.CGColor;
    }
    self.layer.masksToBounds=YES;
}
@end
