//
//  XYZSelectionIndicater.h
//  beauty
//
//  Created by xieyan on 15-3-5.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZSelectionIndicater : UIView
+(instancetype)xyzSelectionIndicaterNum:(int) num frame:(CGRect)frame length:(CGFloat)length;
@property(nonatomic,strong)UIColor*indicaterColor;
@property(nonatomic)NSInteger index;
@end
