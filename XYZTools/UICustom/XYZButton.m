//
//  XYZButton.m
//  layout
//
//  Created by xieyan on 15/7/24.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZButton.h"
@interface XYZButton (){
    BOOL _isSelected;
}
@property(nonatomic,strong) void (^callBack) (BOOL isSelected,XYZView* theView);
@property(nonatomic,strong) void (^layOut) (XYZView* theView);
@property(nonatomic,strong) void (^touched) (BOOL isTouched,XYZView* theView);
@property(nonatomic,strong) void (^messageSet) (BOOL isSelected,XYZView* theView,id message);
@end
@implementation XYZButton

-(instancetype)init{
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepare];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}
-(void)prepare{
    _isSelected = NO;
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.touched) {
        self.touched(YES,self);
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.touched) {
        self.touched(NO,self);
    }
    if (self.callBack) {
        _isSelected = !_isSelected;
        self.callBack(_isSelected, self);
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.touched) {
        self.touched(NO,self);
    }
}



-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.layOut) {
        self.layOut(self);
    }
}


-(void)setMessage:(id)message{
    [self willChangeValueForKey:@"message"];
    _message = message;
    if (self.messageSet) {
        self.messageSet(_isSelected,self,message);
    }
    [self didChangeValueForKey:@"message"];
}


+(instancetype)new{
    return [[self alloc] init];
}
-(instancetype)set_customUI:(void(^)(XYZView* theView))customUI
                     layOut:(void(^)(XYZView* theView))layOut
                   callBack:(void(^)(BOOL isSelected,XYZView* theView))callBack
                    touched:(void(^)(BOOL isTouched, XYZView* theView))touched
                 messgaeSet:(void(^)(BOOL isSelected,XYZView* theView,id message))messageSet{
    self.callBack = callBack;
    self.layOut = layOut;
    self.touched = touched;
    self.messageSet = messageSet;
    if (customUI) {
        customUI(self);
    }
    return self;
}
@end
