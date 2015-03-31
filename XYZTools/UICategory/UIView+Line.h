//
//  UIView+Line.h
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  UIView (UIViewLine)
+(UIView*)separaterOriginX:(CGFloat)x Y:(CGFloat)y W:(CGFloat)width;
+(UIView*)separaterOriginX:(CGFloat)x Y:(CGFloat)y H:(CGFloat)height;

-(void)setSeparaterLeft:(CGFloat)left right:(CGFloat)right top:(CGFloat)top bottom:(CGFloat)bottom;
-(void)xyzShowBorder:(UIColor*)bordercolor cornerRadius:(CGFloat)radius;

@end
