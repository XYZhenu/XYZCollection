//
//  UIView+Geometry.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIView+Geometry.h"
@implementation UIView (XYZGeometry)

-(float)getXyzWidth{
    return self.frame.size.width;
}
-(void)setXyzWidth:(float)xyzWidth{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, xyzWidth, self.frame.size.height);
}



-(float)getXyzHeight{
    return self.frame.size.height;
}
-(void)setXyzHeight:(float)xyzHeight{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,xyzHeight);
}




-(void)setXyzX:(float)xyzX{
    self.frame=CGRectMake(xyzX, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzX{
    return self.frame.origin.x;
}




-(void)setXyzY:(float)xyzY{
    self.frame=CGRectMake(self.frame.origin.x, xyzY, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzY{
    return self.frame.origin.y;
}






-(void)setXyzX1:(float)xyzX1{
    self.frame=CGRectMake(xyzX1-self.frame.size.width, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzX1{
    return self.frame.origin.x+self.frame.size.width;
}




-(void)setXyzY1:(float)xyzY1{
    self.frame=CGRectMake(self.frame.origin.x, xyzY1, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzY1{
    return self.frame.origin.y;
}







-(void)setXyzX2:(float)xyzX2{
    self.frame=CGRectMake(xyzX2, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzX2{
    return self.frame.origin.x;
}




-(void)setXyzY2:(float)xyzY2{
    self.frame=CGRectMake(self.frame.origin.x, xyzY2-self.frame.size.height, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzY2{
    return self.frame.origin.y+self.frame.size.height;
}






-(void)setXyzX3:(float)xyzX3{
    self.frame=CGRectMake(xyzX3-self.frame.size.width, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzX3{
    return self.frame.origin.x+self.frame.size.width;
}




-(void)setXyzY3:(float)xyzY3{
    self.frame=CGRectMake(self.frame.origin.x, xyzY3-self.frame.size.height, self.frame.size.width,self.frame.size.height);
}
-(float)getXyzY3{
    return self.frame.origin.y+self.frame.size.height;
}





-(void)setXyzXcentral:(float)xyzXcentral{
    self.center = CGPointMake(xyzXcentral, self.center.y);
}
-(float)getXyzXcentral{
    return self.center.x;
}


-(void)setXyzYcentral:(float)xyzYcentral{
    self.center = CGPointMake(self.center.x,xyzYcentral);
}
-(float)getXyzYcentral{
    return self.center.y;
}


-(void)xyzSetBoundsWidth:(float)width Height:(float)height{
    self.bounds=CGRectMake(0, 0, width, height);
}
-(void)xyzSetCenterX:(float)X Y:(float)Y{
    self.center=CGPointMake(X, Y);
}


-(CGFloat)xyz_Y2_InWindow{
    UIWindow* window = Application.delegate.window;
    CGPoint point =[window convertPoint:CGPointZero toView:self];
    return  -point.y+self.xyzHeight;
}
@end

