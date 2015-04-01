//
//  XYZTimerAnimateView.h
//  shell
//
//  Created by xieyan on 15/3/19.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZTimerAnimateView : UIView
+(instancetype)viewWithFrame:(CGRect)frame repeatInterval:(NSTimeInterval)repeatInterval buildView:(UIView*(^)(CGRect frame))build prepareView:(BOOL(^)(UIView* theView,NSInteger*currentIndex))preparation animations:(void(^)(UIView* previousView,UIView*newView))animations;

@end
