//
//  XYZSwitch.h
//  shell
//
//  Created by xieyan on 15/3/18.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZSwitch : UIView
+(instancetype)xyzSwitchWithFrame:(CGRect)frame switchNum:(NSInteger)number customView:(UIView*(^)(CGRect frame,NSInteger index))eachView viewSelectedState:(void(^)(UIView* theView,BOOL seleted,NSInteger index))confirmState callBack:(void(^)(NSInteger index))callback;
@property(nonatomic)NSInteger seletedIndex;
@property(nonatomic)CGFloat separterHeight;
@end
