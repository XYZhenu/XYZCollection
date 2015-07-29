//
//  XYZScroll.h
//  layout
//
//  Created by xieyan on 15/7/24.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZScroll : UIScrollView
-(void)prepare;//继承重写用



@property(nonatomic,assign)BOOL enableInfiniteScroll;//可以循环滚动默认开启

@property(atomic,strong)NSArray* messageArray;//设置内容
@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,assign)CGFloat scrollInterval;//滚动间隔时间  >1s
@property(nonatomic,assign)CGFloat animateInterval;//动画时间  >0.1s  <1s
@property(nonatomic,assign)BOOL enableTimer;//默认关闭


@property(nonatomic,assign)BOOL enableIndicator;//指示器，默认不显示
@property(nonatomic)UIColor* indicatorColor;
@property(nonatomic)UIColor* indicatorBGColor;


@property(nonatomic,strong)void(^layOut)(UIView* theView);

+(instancetype)new;

/**
 *  添加处理block
 *  ——————————————————都可以传空————————————————
 
 ————————为兼容代码和自动布局，界面frame另外设置，Scroll会通过block：layout自动适配————————
 
 *  @param messgaeSet 设置UI内容
 *  @param callBack 处理点击事件
 *  @param createUI   创建UI
 *  @param layOut   处理控件layout  使用frame
 *
 *  @return 为了代码创建方便，返回自身；      [[XYZScroll new] block_callBack:nil layOut:nil messgaeSet:nil];
 
 
 ------该函数设计只能调用一次，多次调用会覆盖前一次，设置messageArray会自动调用-------
 */
-(instancetype)set_createUI:(void(^)(UIView* theView))createUI
                       layOut:(void(^)(UIView* theView))layOut 
                indicatorRect:(CGRect(^)(CGRect bound))indicatorRect
                     callBack:(void(^)(NSInteger index,UIView* theView,id message))callBack 
                   messgaeSet:(void(^)(NSInteger index,UIView* theView,id message))messageSet;
@end
