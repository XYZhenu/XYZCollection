//
//  UIView+Geometry.h
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (XYZGeometry)
@property(nonatomic,getter=getXyzWidth)float xyzWidth;
@property(nonatomic,getter=getXyzHeight)float xyzHeight;

@property(nonatomic,getter=getXyzX)float xyzX;
@property(nonatomic,getter=getXyzY)float xyzY;


@property(nonatomic,getter=getXyzX1)float xyzX1;
@property(nonatomic,getter=getXyzY1)float xyzY1;


@property(nonatomic,getter=getXyzX2)float xyzX2;
@property(nonatomic,getter=getXyzY2)float xyzY2;



@property(nonatomic,getter=getXyzX3)float xyzX3;
@property(nonatomic,getter=getXyzY3)float xyzY3;


@property(nonatomic,getter=getXyzXcentral)float xyzXcentral;
@property(nonatomic,getter=getXyzYcentral)float xyzYcentral;


-(void)xyzSetBoundsWidth:(float)width Height:(float)height;
-(void)xyzSetCenterX:(float)X Y:(float)Y;


-(CGFloat)xyz_Y2_InWindow;
@end
