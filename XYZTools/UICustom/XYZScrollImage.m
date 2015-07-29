//
//  XYZScrollImage.m
//  layout
//
//  Created by xieyan on 15/7/24.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZScrollImage.h"

@interface XYZScrollImage ()
@property(nonatomic,strong)void(^callBack)(NSInteger index,id message);
@property(nonatomic,strong)NSString* (^message2Url)(id message);
@end
@implementation XYZScrollImage
-(instancetype)init{
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepare];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}
-(void)prepare{
    _scrollInset = UIEdgeInsetsZero;
    _pageInset = UIEdgeInsetsZero;
    __weak typeof(self)weakSelf = self;
    self.scroll = [[XYZScroll new] block_createUI:^(UIView *theView) {
        UIView* imageview = [[UIImageView alloc] init];
        imageview.tag = 100;
        [theView addSubview:imageview];
    } layOut:^(UIView *theView) {
        UIView* imageview = [theView viewWithTag:100];
        imageview.frame = CGRectMake(weakSelf.pageInset.left, weakSelf.pageInset.top, theView.frame.size.width-weakSelf.pageInset.left-weakSelf.pageInset.right, theView.frame.size.height-weakSelf.pageInset.bottom-weakSelf.pageInset.top);
        
    } indicatorRect:^CGRect(CGRect bound) {
        return CGRectMake(0, bound.size.height-15, bound.size.width, 15);
    } callBack:^(NSInteger index, UIView *theView, id message) {
        if (weakSelf.callBack) {
            weakSelf.callBack(index,weakSelf.imageArray[index]);
        }
    } messgaeSet:^(NSInteger index, UIView *theView, id message) {
        UIImageView* imageview = (UIImageView*)[theView viewWithTag:100];
        
    }];
    
}





-(void)setImageArray:(NSArray *)imageArray{
    self.scroll.messageArray = imageArray;
}
-(NSArray *)imageArray{
    return self.scroll.messageArray;
}
-(void)setScrollInset:(UIEdgeInsets)scrollInset{
    _scrollInset = scrollInset;
    [self layoutIfNeeded];
}

-(void)setPageInset:(UIEdgeInsets)pageInset{
    _pageInset = pageInset;
    __weak typeof(self)weakSelf = self;
    self.scroll.layOut=^(UIView *theView) {
        UIView* imageview = [theView viewWithTag:100];
        imageview.frame = CGRectMake(weakSelf.pageInset.left, weakSelf.pageInset.top, theView.frame.size.width-weakSelf.pageInset.left-weakSelf.pageInset.right, theView.frame.size.height-weakSelf.pageInset.bottom-weakSelf.pageInset.top);
    };
}





-(void)layoutSubviews{
    [super layoutSubviews];
    _scroll.frame = CGRectMake(self.scrollInset.left, self.scrollInset.top, self.frame.size.width-self.scrollInset.left-self.scrollInset.right, self.frame.size.height-self.scrollInset.bottom-self.scrollInset.top);
}





+(instancetype)new{
    return [[self alloc] init];
}
-(instancetype)block_imageMessage2Url:(NSString*(^)(id message))message2Url
                             callBack:(void(^)(NSInteger index,id message))callBack{
    self.message2Url = message2Url;
    self.callBack = callBack;
    return self;
}
@end
