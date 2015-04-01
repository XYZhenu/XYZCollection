//
//  XYZSelectionIndicater.m
//  beauty
//
//  Created by xieyan on 15-3-5.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZSelectionIndicater.h"
@interface XYZSelectionIndicater ()

@end
@implementation XYZSelectionIndicater
+(instancetype)xyzSelectionIndicaterNum:(int) num frame:(CGRect)frame length:(CGFloat)length{
    NSAssert(num>0, @"num must larger than 0");
    return [[self alloc] initWithFrame:frame Num:num length:length];
}
-(instancetype)initWithFrame:(CGRect)frame Num:(int)num length:(CGFloat)length{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        CGFloat tab = frame.size.width/num;
        for (int i=0; i<num; i++) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, length, frame.size.height)];
            view.center=CGPointMake(tab*i+tab/2, frame.size.height/2);
            view.tag=100+i;
            [self addSubview:view];
        }
    }
    return self;
}
-(UIColor *)indicaterColor{
    if (!_indicaterColor) {
        _indicaterColor=[UIColor blackColor];
    }
    return _indicaterColor;
}

-(void)setIndex:(NSInteger)index{
    
    for (UIView* aview in self.subviews) {
        aview.backgroundColor=self.backgroundColor;
    }
    
    
    UIView* view = [self viewWithTag:100+index];
    if (view) {
        view.backgroundColor=self.indicaterColor;
    }
}
@end
