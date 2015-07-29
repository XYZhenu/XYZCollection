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
@property(nonatomic,strong) void (^callBack) (BOOL isSelected,UIView* theView);
@property(nonatomic,strong) void (^layOut) (UIView* theView);
@property(nonatomic,strong) void (^touched) (BOOL downOrUp,UIView* theView);
@property(nonatomic,strong) void (^messageSet) (BOOL isSelected,UIView* theView,id message);
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
-(instancetype)block_customUI:(void(^)(UIView* theView))customUI 
                     callBack:(void(^)(BOOL isSelected,UIView* theView))callBack 
                       layOut:(void(^)(UIView* theView))layOut 
                      touched:(void(^)(BOOL isSelected, UIView* theView))touched 
                   messgaeSet:(void(^)(BOOL isSelected,UIView* theView,id message))messageSet{
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
