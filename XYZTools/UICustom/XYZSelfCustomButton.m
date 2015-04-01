//
//  XYZSelfCustomButton.m
//  shell
//
//  Created by xieyan on 15/3/18.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZSelfCustomButton.h"
@interface XYZSelfCustomButton ()
@property(nonatomic,strong)void(^confirmState)(UIView* selfView,BOOL seleted,id message,void*contex);
@property(nonatomic,strong)void(^callback)(NSInteger index,BOOL seleted,void*contex);
@end
@implementation XYZSelfCustomButton

+(instancetype)buttonWithFrame:(CGRect)frame customView:(void(^)(UIView* selfView))innerView SelectedState:(void(^)(UIView* selfView,BOOL seleted,id message,void*contex))confirmState callback:(void(^)(NSInteger index,BOOL seleted,void*contex))callback{
    return [[self alloc]initWithFrame:frame customView:innerView SelectedState:confirmState callback:callback];
}
-(instancetype)initWithFrame:(CGRect)frame customView:(void(^)(UIView* selfView))innerView SelectedState:(void(^)(UIView* selfView,BOOL seleted,id message,void*contex))confirmState callback:(void(^)(NSInteger index,BOOL seleted,void*contex))callback{
    self=[super initWithFrame:frame];
    if (self) {
        innerView(self);
        self.confirmState=confirmState;
        self.callback=callback;
        _isSelected=NO;
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=self.bounds;
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//        [button xyzShowBorder:nil cornerRadius:0];
        [self addSubview:button];
    }
    return self;
}
-(void)setIsSelected:(BOOL)isSelected{
    _isSelected=isSelected;
    if (self.confirmState) {
        self.confirmState(self,_isSelected,_message,_contex);
    }
}
-(void)setIsSelectedWithCallback:(BOOL)isSelectedWithCallback{
    _isSelectedWithCallback=isSelectedWithCallback;
    self.isSelected=isSelectedWithCallback;
    if (self.callback) {
        self.callback(self.tag,_isSelected,_contex);
    }
}
-(void)setMessage:(id)message{
    _message=message;
    if (self.confirmState) {
        self.confirmState(self,_isSelected,_message,_contex);
    }
}
-(void)setContex:(void *)contex{
    _contex=contex;
    if (self.confirmState) {
        self.confirmState(self,_isSelected,_message,_contex);
    }
}
-(void)buttonClick{
    _isSelected=!_isSelected;
    if (self.confirmState) {
        self.confirmState(self,_isSelected,_message,_contex);
    }
    if (self.callback) {
        self.callback(self.tag,_isSelected,_contex);
    }
}
@end
