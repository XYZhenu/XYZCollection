//
//  XYZButton.h
//  layout
//
//  Created by xieyan on 15/7/24.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZView.h"

@interface XYZButton : XYZView
@property(nonatomic,strong)id message;
+(instancetype)new;
/**
 *  添加处理block
 *  ——————————————————都可以传空————————————————
 
   ————————为兼容代码和自动布局，界面frame另外设置，button会通过block：layout自动适配————————
 
 *  @param customUI 增加UI  所有界面元素依靠tag识别  可以与IB混合使用
 *  @param callBack 处理点击事件 和  处理点击后效果
 *  @param layOut   处理控件layout  使用frame
 *  @param touched  处理点击时的状态  如：高亮状态
 *  @param messageSet  处理收到消息改变button状态  如：更换图片
 *
 *  @return 为了代码创建方便，返回自身；    XYZButton* button = [[XYZButton new] block_customUI:nil callBack:nil layOut:nil touched:nil];

 
 ------该函数设计只能调用一次，多次调用会覆盖前一次，但是customUI设计为不会覆盖任何元素-------
 */
-(instancetype)set_customUI:(void(^)(XYZView* theView))customUI
                       layOut:(void(^)(XYZView* theView))layOut
                   callBack:(void(^)(BOOL isSelected,XYZView* theView))callBack
                      touched:(void(^)(BOOL isTouched, XYZView* theView))touched
                   messgaeSet:(void(^)(BOOL isSelected,XYZView* theView,id message))messageSet;
@end
