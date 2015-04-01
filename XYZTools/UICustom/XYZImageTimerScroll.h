//
//  XYZImageTimerScroll.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZImageTimerScroll : UIView
@property(nonatomic)UIEdgeInsets contentCellInset;

@property(nonatomic,strong)NSTimer*timer;
@property(nonatomic,strong)NSArray*imageArray;
+(instancetype)XYZTimerScrollViewWithCallBack:(void(^)(int index))callBack;
@property BOOL enableTimer;
@end
