//
//  XYZScrollChartView.h
//  表格
//
//  Created by xieyan on 15/5/14.
//  Copyright (c) 2015年 zzy. All rights reserved.
//

#import "XYZView.h"

@interface XYZScrollChartView : XYZView
-(instancetype)initWithFrame:(CGRect)frame cellHeight:(CGFloat)cellheight cellWidth:(CGFloat)cellwidth topHeight:(CGFloat)topheight leftWidth:(CGFloat)leftWidth topNum:(NSInteger)topNum leftNum:(NSInteger)leftNum;


-(void)addTagContent:(id)content;
-(void)resetTag;

-(instancetype)block_getFrame:(CGRect(^)(CGFloat cellWidth,CGFloat cellHeight,CGFloat totalWidth,CGFloat totalHeight,id content))getFrame 
       buildLeftLabel:(void(^)(UIView* view,NSInteger index))buildLeftLabel 
        buildTopLabel:(void(^)(UIView* view,NSInteger index))buildTopLabel 
             buildTag:(void(^)(UIView* view,id content))buildTag 
             clickTag:(void(^)(UIView* view,id content))clickTag
            buildLeft:(UIView*(^)(CGRect frame))buildLeft 
             buildTop:(UIView*(^)(CGRect frame))buildTop;
@end
