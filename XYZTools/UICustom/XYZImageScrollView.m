//
//  XYZImageScrollView.m
//  beauty
//
//  Created by xieyan on 15-3-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZImageScrollView.h"

@interface XYZImageScrollView ()
@property (strong,nonatomic)UIScrollView * scrollV;
@property(strong,nonatomic)void(^callBack)(int index);
@end
@implementation XYZImageScrollView
+(instancetype)XYZImageScrollViewWithCallBack:(void(^)(int index))callBack{
    XYZImageScrollView* view = [[self alloc] init];
    view.callBack = callBack;
    return view;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.scrollV=[[UIScrollView alloc]init];
        self.scrollV.backgroundColor=[UIColor whiteColor];
        [self.scrollV setPagingEnabled:YES];
        self.scrollV.showsVerticalScrollIndicator=NO;
        self.scrollV.showsHorizontalScrollIndicator=NO;
        [self addSubview:self.scrollV];
        
        self.contentCellInset=UIEdgeInsetsZero;
    }
    return self;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (UIView*view in self.subviews) {
        view.backgroundColor=backgroundColor;
    }
}
-(void)setImageArray:(NSArray *)imageArray{
    
    self.scrollV.frame=self.bounds;
    self.scrollV.contentSize=CGSizeMake(self.imageWidth*[imageArray count], self.xyzHeight);
    for (int i=0; i<_imageArray.count; i++) {
        [[self.scrollV viewWithTag:10000+i] removeFromSuperview];
    }
    _imageArray = imageArray;
    
    for (int i=0; i<imageArray.count; i++) {
        
        XYZButton* BTN = [XYZButton buttonWithFrame:CGRectMake(i*self.imageWidth, 0, self.imageWidth, self.bounds.size.height) callBack:^(BOOL isSelected,int tag) {
            if (self.callBack) {
                self.callBack(tag-10000);
            }
        }];
        BTN.xyzInset=self.contentCellInset;
        BTN.tag=10000+i;
        if ([imageArray[i] isKindOfClass:[NSString class]]) {
            NSString* str = imageArray[i];
            if ([str rangeOfString:@"://"].location!=NSNotFound) {
                [XYZNetWork loadImage:str complete:^(UIImage *image) {
                    BTN.xyzImage=image;
                }];
                //                [BTN xyzImageWithURL:str];
            }else{
                UIImage* image = [UIImage imageNamed:str];
                if (image) {
                    BTN.xyzImage=image;
                }
            }
            
        }else if ([imageArray[i] isKindOfClass:[UIImage class]]) {
            BTN.xyzImage = imageArray[i];
        }else {
            XYZLOG(@"NO IMAGE!!!!");
        }
        
        [self.scrollV addSubview:BTN];
    }
}

@end
