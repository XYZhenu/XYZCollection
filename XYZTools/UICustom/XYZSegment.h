//
//  XYZSegment.h
//  XYZCollection
//
//  Created by xieyan on 15/7/27.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZView.h"
@interface XYZSegment : XYZView
@property(nonatomic,assign)NSInteger selectedIndex;

+(instancetype)new;



-(instancetype)block_Num:(NSInteger)number 
                createUI:(void(^)(UIView* theView,NSInteger index))createUI 
                  layOut:(void(^)(UIView* theView))layOut 
             selectState:(void(^)(UIView* theView,BOOL selected))selectState 
                callBack:(void(^)(NSInteger index))callBack;

-(void)selectedIndexWithCallBck:(NSInteger)index;
@end
