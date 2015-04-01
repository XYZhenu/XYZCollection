//
//  XYZCoverView.m
//  beauty
//
//  Created by xieyan on 15-3-3.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZCoverView.h"
@interface XYZCoverView ()
@property(nonatomic,assign)UIView* view;
@end
@implementation XYZCoverView

+(instancetype)xyzCoverView{
    return [[self alloc] initWithView:[Application.delegate window]];
    
}
+(instancetype)xyzCoverInView:(UIView*)view{
    
    return [[self alloc] initWithView:view];
}
-(instancetype)initWithView:(UIView*)view{
    self = [self initWithFrame:view.bounds];
    if (self) {
        self.view=view;
        
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        [button addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}
-(void)present{
    self.xyzY=self.view.xyzHeight;
    [self.view addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.xyzY=0;
    }];
}
-(void)disMiss{
    if (self.dismissCallback) {
        if (self.constructMessage) {
            self.dismissCallback(self.constructMessage());
        }
        self.dismissCallback(nil);
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.xyzY=self.view.xyzHeight;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
}
@end
