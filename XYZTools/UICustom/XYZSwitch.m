//
//  XYZSwitch.m
//  shell
//
//  Created by xieyan on 15/3/18.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZSwitch.h"
@interface XYZSwitch ()
@property(nonatomic,strong)NSMutableArray*viewsArray;
@property(nonatomic,strong)void(^confirmState)(UIView* theView,BOOL seleted,NSInteger index);
@property(nonatomic,strong)void(^callback)(NSInteger index);
@end
@implementation XYZSwitch


+(instancetype)xyzSwitchWithFrame:(CGRect)frame switchNum:(NSInteger)number customView:(UIView*(^)(CGRect frame,NSInteger index))eachView viewSelectedState:(void(^)(UIView* theView,BOOL seleted,NSInteger index))confirmState callBack:(void(^)(NSInteger index))callback{
    return [[self alloc] initWithFrame:frame switchNum:number customView:eachView viewSelectedState:confirmState callBack:(void(^)(NSInteger index))callback];
}

-(instancetype)initWithFrame:(CGRect)frame switchNum:(NSInteger)number customView:(UIView*(^)(CGRect frame,NSInteger index))eachView viewSelectedState:(void(^)(UIView* theView,BOOL seleted,NSInteger index))confirmState callBack:(void(^)(NSInteger index))callback{
    self=[super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width/number;
        for (int i=0; i<number; i++) {
            CGRect viewFrame = CGRectMake(i*width, 0, width, frame.size.height);
            UIView* view = eachView(viewFrame,i);
            [self addSubview:view];
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=viewFrame;
            button.tag=100+i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            [self.viewsArray addObject:view];
        }
        self.confirmState=confirmState;
        self.callback=callback;
        _seletedIndex=0;
    }
    
    return self;
}
-(NSMutableArray *)viewsArray{
    if (!_viewsArray) {
        _viewsArray=[NSMutableArray arrayWithCapacity:10];
    }
    return _viewsArray;
}
-(void)buttonClick:(UIButton*)sender{
    NSInteger tag = sender.tag-100;
    if (self.seletedIndex!=tag) {
        self.seletedIndex=tag;
    }
    
}
-(void)setSeletedIndex:(NSInteger)seletedIndex{
    _seletedIndex=seletedIndex;
    if (self.confirmState) {
        
        for (int i=0; i<self.viewsArray.count; i++) {
            UIView* view = self.viewsArray[i];
            self.confirmState(view,seletedIndex==i,i);
            
        }
        
    }
    if (self.callback) {
        self.callback(seletedIndex);
    }
}
-(void)setSeparterHeight:(CGFloat)separterHeight{
    _separterHeight=separterHeight;
    NSInteger number = self.viewsArray.count;
    CGFloat width = self.xyzWidth/number;
    for (UIView* view in self.subviews) {
        if (view.tag>=300) {
            [view removeFromSuperview];
        }
    }
    for (int i=0; i<number-1; i++) {
        UIView* view= [XYZToolsCommon separaterOriginX:(i+1)*width Y:(self.xyzHeight-separterHeight)/2 H:separterHeight];
        view.tag=i+300;
        [self addSubview:view];
    }
    
    
}
@end
