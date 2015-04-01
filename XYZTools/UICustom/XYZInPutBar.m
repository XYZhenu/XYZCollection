//
//  XYZInPutBar.m
//  chuanyue_sidebar
//
//  Created by xieyan on 15-1-23.
//  Copyright (c) 2015年 郜路阳. All rights reserved.
//

#import "XYZCustomUI.h"
#import "AppDelegate.h"
@interface XYZInPutBar (){
    CGSize __bounds;
    UIButton* _sendBtn;
    CGRect _originRect;
    UIButton* maskButton;
}
@property (strong,nonatomic)UITextField * textField;
@end
@implementation XYZInPutBar
+(instancetype)xyzInPutBarWithViewController:(UIViewController*)vc returnStr:(void(^)(NSString* message))callBack{
    return [[self alloc] initWithViewController:vc returnStr:callBack];
}

-(void)createTextField
{
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(5, 5, 250, 34)];
    self.textField.backgroundColor=[UIColor whiteColor];
    self.textField.layer.cornerRadius=5.0;
    self.textField.layer.borderColor=[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1].CGColor;
    self.textField.layer.borderWidth=0.5;
    self.textField.delegate=self;
    self.textField.placeholder=@"  我也说一句...";
    [self addSubview:self.textField];
}
-(void)createdSendBtn
{
    _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn setFrame:CGRectMake(260, 5, 55, 34)];
    [_sendBtn setTitleColor:ColorBlue forState:UIControlStateNormal];
    _sendBtn.backgroundColor=[UIColor whiteColor];
    [_sendBtn addTarget:self action:@selector(sendBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendBtn];
}
-(void)sendBtnPress{
    self.callBack(self.textField.text);
    self.textField.text=@"";
    [self maskButtonClick];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendBtnPress];
    return YES;
}
-(void)setXyzFrame:(CGRect)xyzFrame{
    _originRect=xyzFrame;
    self.frame=xyzFrame;
}
-(CGRect)getXyzFrame{
    return _originRect;
}
-(instancetype)initWithViewController:(UIViewController*)vc returnStr:(void(^)(NSString* message))callBack{
    self=[super init];
    if (self) {
        
        
        maskButton = [XYZToolsCommon buttonMaskWithFrame:vc.view.bounds color:ColorCoverViewBg target:self func:@selector(maskButtonClick) tag:3];
        [vc.view addSubview:maskButton];
        
        
        
        __bounds=vc.view.frame.size;
        self.frame=CGRectMake(0, __bounds.height-44, __bounds.width, 44);
        _originRect=self.frame;
        NSLog(@"%@",NSStringFromCGRect(self.frame));
        self.backgroundColor=[UIColor whiteColor];
        [vc.view addSubview:self];
        [self createTextField];
        [self createdSendBtn];
        self.callBack=callBack;
        

        
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}
-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)maskButtonClick{
    [self resignFirstResponder];
    [maskButton removeFromSuperview];
    [self removeFromSuperview];
}
-(float)convertYFromWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
    return o.y;
    
}
-(float)convertYToWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return o.y;
    
}
-(float)getHeighOfWindow
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate.window.frame.size.height;
}
-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat y = [self convertYToWindow:self.frame.origin.y]-_keyboardRect.origin.y+self.frame.size.height;
    
    
    

    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0,-(y));
    }];
}
-(void)keyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform=CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
    
}
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = [self convertYToWindow:_originRect.origin.y]-_keyboardRect.origin.y+_originRect.size.height;
//    
//    
//    NSLog(@"%@  %f  %f  %f",NSStringFromCGRect(_keyboardRect),[self convertYToWindow:self.frame.origin.y],self.frame.origin.y,y);
    
    self.transform = CGAffineTransformMakeTranslation(0,-y);
}

-(BOOL)becomeFirstResponder{
    [self.textField becomeFirstResponder];
    return YES;
}
-(BOOL)resignFirstResponder{
    [self.textField resignFirstResponder];
    return YES;
}


@end
