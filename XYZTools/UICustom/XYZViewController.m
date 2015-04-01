//
//  XYZViewController.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZViewController.h"

@interface XYZViewController (){
    BOOL _isAdjusted;
    BOOL _needLoad;
}
@property(nonatomic,strong)UIButton* maskButton;
@end

@implementation XYZViewController

-(UIView *)xyzView{
    if (!_xyzView) {
        self.xyzView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:self.xyzView];
    }
    return _xyzView;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (IsiOS6_OR_Lower) {
        for (UIView* sub in self.xyzView.subviews) {
            if ([sub isKindOfClass:[UIScrollView class]]) {
                UIScrollView* view = (UIScrollView*)sub;
                view.contentInset=UIEdgeInsetsZero;
            }
        }
    }
//    CGRect frame = self.view.frame;
//    frame=self.xyzView.frame;
}   
-(void)viewWillAppear:(BOOL)animated{
//    CGRect frame=self.view.frame;
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    [super viewWillAppear:animated];
    
    if (_needLoad) {
        _needLoad=NO;
        [self adjustXyzView];
        [self loadXyzView];
    }
    
    if (self.tabBarController) {
        if (self.navigationController) {
            if (self.navigationController.viewControllers[0]==self) {
                self.tabBarController.tabBar.hidden=NO;
            }else{
                self.tabBarController.tabBar.hidden=YES;
            }
        }else{
            self.tabBarController.tabBar.hidden=NO;
        }
    }
    
//    frame = self.view.frame;
//    frame=self.xyzView.frame;
}
-(void)adjustXyzView{
    CGFloat Height=self.xyzView.frame.size.height;
    if (self.navigationController) {
        Height-=IsiOS6_OR_Lower?44:64;
        if (self.tabBarController&&[self.navigationController.viewControllers[0] isEqual:self]) {
            Height-=self.tabBarController.tabBar.frame.size.height;
            if (IsiOS7_OR_Higher) {
                self.tabBarController.tabBar.translucent=YES;
            }
        }
        self.navigationController.navigationBar.translucent=YES;
    }
    CGFloat y = IsiOS6_OR_Lower?44:64;
    CGRect frame = self.xyzView.frame;
    self.xyzView.frame = CGRectMake(0, y, frame.size.width,Height);
//    XYZLOG(@"%@",NSStringFromCGRect(self.xyzView.frame));
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    
}




/**
 *  键盘屏蔽层
 */

-(UIButton *)maskButton{
    if (!_maskButton) {
        _maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskButton.frame = self.xyzView.frame;
        _maskButton.backgroundColor = [UIColor clearColor];
        [_maskButton addTarget:self action:@selector(maskButtomClick:) forControlEvents:UIControlEventTouchUpInside];
        _maskButton.tag=999999999;
        _maskButton.hidden=YES;
        [self.view addSubview:_maskButton];
    }
    return _maskButton;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.maskButton.hidden=NO;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.maskButton.hidden=YES;
    [self textFieldResignFirstResponder];
    return YES;
}
-(void)textFieldResignFirstResponder{
    
}
-(void)maskButtomClick:(UIButton*)sender{
    self.maskButton.hidden=YES;
    [self textFieldResignFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.maskButton.hidden=NO;
}
@end
