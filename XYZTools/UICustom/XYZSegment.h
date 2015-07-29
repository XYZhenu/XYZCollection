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



-(instancetype)set_Num:(NSInteger)number
                createUI:(void(^)(XYZView* theView,NSInteger index))createUI 
                  layOut:(void(^)(XYZView* theView,NSInteger index))layOut
             selectState:(void(^)(XYZView* theView,BOOL selected))selectState 
                callBack:(void(^)(NSInteger index))callBack;

-(void)selectedIndexWithCallBack:(NSInteger)index;
@end
