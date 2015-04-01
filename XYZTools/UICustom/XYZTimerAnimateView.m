//
//  XYZTimerAnimateView.m
//  shell
//
//  Created by xieyan on 15/3/19.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZTimerAnimateView.h"
@interface XYZTimerAnimateView ()
{
    NSInteger _index;
    BOOL _view1current;
}
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)UIView* view2;
@property(nonatomic,strong)BOOL(^preparation)(UIView* theView,NSInteger*currentIndex);
@property(nonatomic,strong)void(^animations)(UIView* previousView,UIView*newView);
@property(nonatomic,strong)NSTimer* timer;
@end
@implementation XYZTimerAnimateView
+(instancetype)viewWithFrame:(CGRect)frame repeatInterval:(NSTimeInterval)repeatInterval buildView:(UIView*(^)(CGRect frame))build prepareView:(BOOL(^)(UIView* theView,NSInteger*currentIndex))preparation animations:(void(^)(UIView* previousView,UIView*newView))animations{
    return [[self alloc] initWithFrame:frame repeatInterval:repeatInterval buildView:build prepareView:preparation animations:animations];
}
-(instancetype)initWithFrame:(CGRect)frame repeatInterval:(NSTimeInterval)repeatInterval buildView:(UIView*(^)(CGRect frame))build prepareView:(BOOL(^)(UIView* theView,NSInteger*currentIndex))preparation animations:(void(^)(UIView* previousView,UIView*newView))animations{
    self=[super initWithFrame:frame];
    if (self) {
        _index=0;
        _view1current=YES;;
        self.preparation=preparation;
        self.animations=animations;
        self.view1=build(self.bounds);
        [self addSubview:self.view1];
        
        self.view2=build(self.bounds);
        [self addSubview:self.view2];
        
        
        self.layer.masksToBounds=YES;
        
        
//        self.timer=[NSTimer timerWithTimeInterval:repeatInterval target:self selector:@selector(timeClick) userInfo:nil repeats:YES];
        self.timer=[NSTimer scheduledTimerWithTimeInterval:repeatInterval target:self selector:@selector(timeClick) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    return self;
}



-(void)timeClick{
    if (_preparation) {
        UIView* view = _view1current?self.view1:self.view2;
        [self bringSubviewToFront:view];
        
        BOOL shouldContinue = self.preparation(view,&_index);
        if (shouldContinue&&_animations) {
            if (_view1current) {
                self.animations(self.view2,self.view1);
            }else{
                self.animations(self.view1,self.view2);
            }
            _view1current=!_view1current;
        }
    }
    
}

-(void)dealloc{
    
}

//-(UIView *)view1{
//    if (!_view1) {
//        _view1=[[UIView alloc] initWithFrame:self.bounds];
//    }
//    return _view1;
//}
//-(UIView *)view2{
//    if (!_view2) {
//        _view2=[[UIView alloc] initWithFrame:self.bounds];
//    }
//    return _view2;
//}
@end
