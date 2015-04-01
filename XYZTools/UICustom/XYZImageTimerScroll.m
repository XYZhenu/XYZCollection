//
//  XYZImageTimerScroll.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZImageTimerScroll.h"
@interface XYZImageTimerScroll ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView * scrollV;
@property (strong,nonatomic)UIPageControl * pageC;
@property(strong,nonatomic)void(^callBack)(int index);
@end
@implementation XYZImageTimerScroll

+(instancetype)XYZTimerScrollViewWithCallBack:(void(^)(int index))callBack{
    XYZImageTimerScroll* view = [[self alloc] init];
    view.callBack = callBack;
    return view;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.scrollV=[[UIScrollView alloc]init];
        self.scrollV.backgroundColor=[UIColor whiteColor];
        [self.scrollV setPagingEnabled:YES];
        self.scrollV.delegate=self;
        self.scrollV.showsVerticalScrollIndicator=NO;
        self.scrollV.showsHorizontalScrollIndicator=NO;
        [self addSubview:self.scrollV];
        
        
        self.pageC=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.xyzHeight-30,self.xyzWidth, 30)];
        self.pageC.backgroundColor=[UIColor clearColor];
        self.pageC.currentPageIndicatorTintColor=[UIColor whiteColor];
        self.pageC.currentPage=0;
        self.pageC.userInteractionEnabled=NO;
        [self addSubview:self.pageC];
        
        self.enableTimer=NO;
        
        self.contentCellInset=UIEdgeInsetsZero;
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.pageC.frame=CGRectMake(0, self.xyzHeight-30,self.xyzWidth, 30);
    
}
-(void)imageScroll{
    if (self.imageArray.count<2) {
        return;
    }
    int current = self.pageC.currentPage;
    if ((current+1)>self.pageC.numberOfPages-1) {
        self.pageC.currentPage = 0;
    }else{
        self.pageC.currentPage = current+1;
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        self.scrollV.contentOffset = CGPointMake(self.pageC.currentPage*self.xyzWidth, 0);
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth=self.xyzWidth;
    int page=floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    if (self.pageC.currentPage!=page) {
        self.pageC.currentPage=page;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset=scrollView.contentOffset;
    CGRect bounds=scrollView.frame;
    [self.pageC setCurrentPage:offset.x/bounds.size.width ];
}
-(void)dealloc{
    [self.timer invalidate];
}
-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(imageScroll) userInfo:nil repeats:YES];
    }
    return _timer;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (UIView*view in self.subviews) {
        view.backgroundColor=backgroundColor;
    }
}
-(void)setImageArray:(NSArray *)imageArray{
    self.scrollV.frame=self.bounds;
    self.scrollV.contentSize=CGSizeMake(self.xyzWidth*[imageArray count], self.xyzHeight);
    self.pageC.numberOfPages=[imageArray count];
    for (int i=0; i<_imageArray.count; i++) {
        [[self.scrollV viewWithTag:10000+i] removeFromSuperview];
    }
    _imageArray = imageArray;
    
    for (int i=0; i<self.pageC.numberOfPages; i++) {
        
        XYZButton* BTN = [XYZButton buttonWithFrame:CGRectMake(i*(self.bounds.size.width), 0, self.bounds.size.width, self.bounds.size.height) callBack:^(BOOL isSelected,int tag) {
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
    
    if (self.pageC.numberOfPages<2&&!self.enableTimer) {
        self.pageC.hidden=YES;
    }else{
        self.pageC.hidden=NO;
        [self.timer fire];
    }
    
}

@end
