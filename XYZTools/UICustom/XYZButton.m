//
//  XYZButton.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZButton.h"

@interface XYZButton ()
@property(nonatomic,strong)UIImageView* coverImage;
@property(nonatomic,strong)UILabel*coverLabel;
@property(nonatomic,strong)UIButton*button;


/**
 *  image and text button proporty
 */
@property(nonatomic)BOOL isImageTextButton;
@property(nonatomic)BOOL isCentralContentButton;
@property(nonatomic)CGFloat imageWidth;
@property(nonatomic)CGFloat buttonHeight;
@end
@implementation XYZButton

/**
 *  自动居中，大小固定，右图，左label
 */




/**
 *  自动居中，大小固定，左图，右label
 */

+(instancetype)ButtonCentralContentWithFrame:(CGRect)frame imageWidth:(CGFloat)width{
    return [[self alloc] initWithFrame:frame imageWidth:width];
}


-(instancetype)initWithFrame:(CGRect)frame imageWidth:(CGFloat)width{
    self=[super initWithFrame:frame];
    if (self) {
        _isCentralContentButton=YES;
        self.isImageTextButton = NO;
        _isSelected            = NO;
        _xyzImageSelected      = nil;
        _delegate              = nil;
        _xyzImage              = nil;
        self.callback          = nil;
        self.xyzInset          = UIEdgeInsetsZero;
        self.coverImage.xyzWidth=width;
        self.coverImage.contentMode=UIViewContentModeCenter;
        [self resizeCentralAdjustContent];
    }
    return self;
}
-(void)resizeCentralAdjustContent{
    
    self.coverImage.frame=CGRectMake(0, 0, self.coverImage.xyzWidth, self.xyzHeight);
    CGFloat labelWidth = [self.coverLabel.text sizeWithFont:self.coverLabel.font].width;
    self.coverLabel.frame=CGRectMake(0, 0, labelWidth, self.xyzHeight);
    
    self.coverImage.xyzX=self.xyzWidth/2-(self.coverImage.xyzWidth+self.coverLabel.xyzWidth)/2;
    self.coverLabel.xyzX=self.coverImage.xyzX1;
    
}

/**
 *  自动调整大小，左image 右label
 *
 */
+(instancetype)buttonWithImageWidth:(CGFloat)imageWidth height:(CGFloat)buttonHeight 
{
    return [[self alloc] initWithImageWidth:imageWidth height:buttonHeight];
}

-(instancetype)initWithImageWidth:(CGFloat)imageWidth height:(CGFloat)buttonHeight 
{
    self=[super initWithFrame:CGRectMake(0, 0, imageWidth, buttonHeight)];
    if (self) {
        self.imageWidth        = imageWidth;
        self.buttonHeight      = buttonHeight;
        self.isImageTextButton = YES;
        _isCentralContentButton=NO;
        self.coverImage        = nil;
        self.coverLabel        = nil;
        _isSelected            = NO;
        _xyzImageSelected      = nil;
        _delegate              = nil;
        _xyzImage              = nil;
        self.callback          = nil;
        self.xyzInset          = UIEdgeInsetsZero;
        
    }
    return self;
}
-(void)layoutImageText{
    self.coverImage.frame=CGRectMake(self.xyzInset.left, self.xyzInset.top, self.imageWidth, self.buttonHeight-self.xyzInset.bottom-self.xyzInset.top);
    CGFloat width =[self.xyzTitleText sizeWithFont:self.coverLabel.font].width;
    self.coverLabel.frame = CGRectMake(self.coverImage.xyzX1, self.xyzInset.top, width, self.buttonHeight-self.xyzInset.bottom-self.xyzInset.top);
    self.bounds=CGRectMake(0, 0, self.coverLabel.xyzX1+self.xyzInset.right, self.buttonHeight);
}

/**
 *  普通
 */
+(instancetype)buttonWithFrame:(CGRect)frame callBack:(void(^)(BOOL isSelected, int tag))callBack{
    return [[self alloc] initWithFrame:frame callBack:callBack];
}
-(instancetype)initWithFrame:(CGRect)frame callBack:(void(^)(BOOL isSelected, int tag))callBack{
    self=[super initWithFrame:frame];
    if (self) {
        self.isImageTextButton = NO;
        _isCentralContentButton=NO;
        self.coverImage        = nil;
        self.coverLabel        = nil;
        _isSelected            = NO;
        _xyzImageSelected      = nil;
        _xyzImage              = nil;
        _delegate              = nil;
        self.callback          = callBack;
        self.xyzInset          = UIEdgeInsetsZero;
    }
    return self;
}





/**
 *  公用
 *
 *  @param callback <#callback description#>
 */
-(void)setCallback:(void (^)(BOOL, int))callback{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=self.bounds;
        [_button addTarget:self action:@selector(callbackInside) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    _callback=callback;
}
-(void)setDelegate:(id<XYZButtonDelegate>)delegate{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=self.bounds;
        [_button addTarget:self action:@selector(callbackInside) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    _delegate=delegate;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (self.isImageTextButton) {
        return;
    }
    if (self.isCentralContentButton) {
        [self resizeCentralAdjustContent];
        return;
    }
    if (self.coverImage) {
        self.coverImage.frame=self.bounds;
    }
    if (self.coverLabel) {
        self.coverLabel.frame=self.bounds;
    }
}
-(void)setXyzInset:(UIEdgeInsets)xyzInset{
    _xyzInset            = xyzInset;
    CGRect frame      = self.bounds;
    frame.origin.x    += xyzInset.left;
    frame.origin.y    += xyzInset.top;
    frame.size.width  -= xyzInset.left+xyzInset.right;
    frame.size.height -= xyzInset.bottom+xyzInset.top;
    if (self.isImageTextButton) {
        [self layoutImageText];
    }else if(self.isCentralContentButton){
        
    }else{
        if (self.coverImage) {
            self.coverImage.frame=frame;
        }
        if (self.coverLabel) {
            self.coverLabel.frame=frame;
        }
    }
}
-(void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    if (self.isImageTextButton) {
        return;
    }
    if (self.isCentralContentButton) {
        [self resizeCentralAdjustContent];
        return;
    }
    if (self.coverImage) {
        self.coverImage.frame=bounds;
    }
    if (self.coverLabel) {
        self.coverLabel.frame=bounds;
    }
}
-(void)setIsSelected:(BOOL)isSelected{
    if (self.xyzImageSelected) {
        self.coverImage.image=isSelected?self.xyzImageSelected:self.xyzImage;
    }
    
    _isSelected=isSelected;
}
-(void)callbackInside{
    if (self.xyzImageSelected) {
        self.isSelected=!self.isSelected;
    }
    if (self.callback) {
        self.callback(self.isSelected,self.tag);
    }
    if (self.delegate) {
        [self.delegate XYZButtonCallBack:self.isSelected tag:self.tag];
    }
}





-(void)checkImageNil{
    if (_coverImage==nil) {
        _coverImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_coverImage];
    }
}
-(void)setXyzImage:(UIImage *)xyzImage{
    [self checkImageNil];
    if (_xyzImageSelected==nil) {
        self.coverImage.image=xyzImage;
    }else{
        if (!_isSelected) {
            self.coverImage.image=xyzImage;
        }
    }
    _xyzImage=xyzImage;
}
-(void)setXyzImageSelected:(UIImage *)xyzImageSelected{
    [self checkImageNil];
    if (_xyzImage==nil) {
        //        self.coverImage.image=xyzImageSelected;
        
    }else{
        if (_isSelected) {
            self.coverImage.image=xyzImageSelected;
        }
    }
    _xyzImageSelected=xyzImageSelected;
}
-(void)setXyzImageContentMode:(UIViewContentMode)xyzContentMode{
    _xyzImageContentMode=xyzContentMode;
    [self checkImageNil];
    self.coverImage.contentMode=xyzContentMode;
}
-(UIImageView *)coverImage{
    [self checkImageNil];
    return _coverImage;
}



-(UILabel *)coverLabel{
    [self checkLabelNil];
    return _coverLabel;
}

-(void)checkLabelNil{
    if (_coverLabel==nil) {
        _coverLabel=[[UILabel alloc] initWithFrame:self.bounds];
        //        _coverLabel.numberOfLines=0;
        _coverLabel.textColor=[UIColor blackColor];
        _coverLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_coverLabel];
        
    }
}
-(void)setXyzTitleFont:(float)xyzFont{
    _xyzTitleFont=xyzFont;
    [self checkLabelNil];
    self.coverLabel.font=[UIFont systemFontOfSize:xyzFont];
    if (self.isImageTextButton) {
        [self layoutImageText];
    }else if (self.isCentralContentButton){
        [self resizeCentralAdjustContent];
    }else{
        
    }
}
-(void)setXyzTitleColor:(UIColor *)xyzTitleColor{
    _xyzTitleColor=xyzTitleColor;
    [self checkLabelNil];
    self.coverLabel.textColor=xyzTitleColor;
    
}
-(void)setXyzTitleAlignment:(NSTextAlignment)xyzAlignment{
    _xyzTitleAlignment=xyzAlignment;
    [self checkLabelNil];
    self.coverLabel.textAlignment=xyzAlignment;
}
-(void)setXyzTitleText:(NSString *)xyzTitleText{
    _xyzTitleText=xyzTitleText;
    [self checkLabelNil];
    self.coverLabel.text=xyzTitleText;
    if (self.isImageTextButton) {
        [self layoutImageText];
    }else if (self.isCentralContentButton){
        [self resizeCentralAdjustContent];
    }else{
        
    }
}



@end
