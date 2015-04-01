//
//  XYZSelfCustomButton.h
//  shell
//
//  Created by xieyan on 15/3/18.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZSelfCustomButton : UIView
+(instancetype)buttonWithFrame:(CGRect)frame customView:(void(^)(UIView* selfView))innerView SelectedState:(void(^)(UIView* selfView,BOOL seleted,id message,void*contex))confirmState callback:(void(^)(NSInteger index,BOOL seleted,void*contex))callback;
@property(nonatomic)BOOL isSelected;
@property(nonatomic)BOOL isSelectedWithCallback;
@property(nonatomic,strong)id message;
@property(nonatomic)void*contex;
@end
