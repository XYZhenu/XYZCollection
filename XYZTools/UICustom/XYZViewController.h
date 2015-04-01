//
//  XYZViewController.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZViewController : UIViewController</*XYZTableViewCellDelegate,*/UITextFieldDelegate,UITextViewDelegate>
-(void)afterInit;
-(void)loadXyzView;
@property(nonatomic,strong)UIView*xyzView;



/**
 *  通知中心处理
 */
-(void)addNotification:(NSString*)frequency callBack:(void(^)(id object)) callBack;

/**
 * 键盘事件
 */
-(void)textFieldResignFirstResponder;
-(void)textFieldDidBeginEditing:(UITextField *)textField;
-(void)textViewDidBeginEditing:(UITextView *)textView;
@end
