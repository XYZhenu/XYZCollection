//
//  XYZSegment.m
//  XYZCollection
//
//  Created by xieyan on 15/7/27.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZSegment.h"
@interface XYZSegment (){
    NSMutableArray* _cellArray;
}
@property(nonatomic,strong)void(^createUI)(XYZView* theView,NSInteger index);
@property(nonatomic,strong)void(^layOut)(XYZView* theView,NSInteger index);
@property(nonatomic,strong)void(^messageSet)(XYZView* theView,NSInteger index);
@property(nonatomic,strong)void(^selectState)(XYZView* theView,BOOL selected);
@property(nonatomic,strong)void(^callBack)(NSInteger index);
@end
@implementation XYZSegment
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
    _selectedIndex = 0;
    _cellArray = [NSMutableArray new];
    
    
}



#define ButtonTag 123324

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width/_cellArray.count;
    for (int i=0; i<_cellArray.count; i++) {
        UIView* view = _cellArray[i];
        view.frame = CGRectMake(i*width, 0, width, self.frame.size.height);
        
        UIView* button = [view viewWithTag:ButtonTag+i];
        button.frame = view.bounds;
    }
    if (self.layOut) {
        for (int i=0; i<_cellArray.count; i++) {
            XYZView* view = _cellArray[i];
            self.layOut(view,i);
        }
    }
}





+(instancetype)new{
    return [[self alloc] init];
}
-(instancetype)set_Num:(NSInteger)number
              createUI:(void(^)(XYZView* theView,NSInteger index))createUI
                layOut:(void(^)(XYZView* theView,NSInteger index))layOut
           selectState:(void(^)(XYZView* theView,BOOL selected))selectState
              callBack:(void(^)(NSInteger index))callBack
            messageSet:(void(^)(XYZView* theView,NSInteger index))messageSet
{
    
    
    NSAssert(number>1, @"最少两个");
    
    for (UIView* view in _cellArray) {
        [view removeFromSuperview];
    }
    [_cellArray removeAllObjects];
    
    
    self.createUI = createUI;
    self.layOut = layOut;
    self.selectState = selectState;
    self.callBack = callBack;
    
    
    CGFloat width = self.frame.size.width/number;
    
    for (int i=0; i<number; i++) {
        XYZView* view = [[XYZView alloc] initWithFrame:CGRectMake(i*width, 0, width, self.frame.size.height)];
        [self addSubview:view];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = view.bounds;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = ButtonTag+i;
        [view addSubview:btn];
        
        [_cellArray addObject:view];
    }
    
    
    if (self.createUI) {
        for (int i=0;i<number; i++) {
            self.createUI(_cellArray[i],i);
        }
    }
    
    
    if (self.selectState) {
        for (int i=0; i<_cellArray.count; i++) {
            if (i==self.selectedIndex) {
                self.selectState(_cellArray[i],YES);
            }else{
                self.selectState(_cellArray[i],NO);
            }
        }
    }
    self.messageSet = messageSet;
    [self setNeedsLayout];
    return self;
}





-(void)buttonClick:(UIButton*)sender{
    self.selectedIndex = sender.tag-ButtonTag;
    if (self.callBack) {
        self.callBack(sender.tag-ButtonTag);
    }
}


-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (_selectedIndex==selectedIndex || (selectedIndex<0) || (selectedIndex >= _cellArray.count)) {
        return;
    }
    _selectedIndex = selectedIndex;
    if (self.selectState) {
        for (int i=0; i<_cellArray.count; i++) {
            if (i==selectedIndex) {
                self.selectState(_cellArray[i],YES);
            }else{
                self.selectState(_cellArray[i],NO);
            }
        }
    }
}

-(void)selectedIndexWithCallBack:(NSInteger)index{
    self.selectedIndex = index;
    if (self.callBack) {
        self.callBack(index);
    }
}
-(void)xyzMessageSet:(id)message{
    if (self.messageSet) {
        for (int i=0; i<_cellArray.count; i++) {
            XYZView* view = _cellArray[i];
            self.messageSet(view,i);
        }
    }
}
@end
