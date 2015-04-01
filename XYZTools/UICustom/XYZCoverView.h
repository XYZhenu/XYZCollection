//
//  XYZCoverView.h
//  beauty
//
//  Created by xieyan on 15-3-3.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZCoverView : UIView
+(instancetype)xyzCoverView;
+(instancetype)xyzCoverInView:(UIView*)view;
-(void)present;
-(void)disMiss;
@property(nonatomic,strong)void(^dismissCallback)(id message);
@property(nonatomic,strong)id (^constructMessage)();
@end
