//
//  XYZInPutBar.h
//  chuanyue_sidebar
//
//  Created by xieyan on 15-1-23.
//  Copyright (c) 2015年 郜路阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZInPutBar : UIView<UITextFieldDelegate>
@property(nonatomic,getter=getXyzFrame)CGRect xyzFrame;
@property (nonatomic,strong)void(^callBack)(NSString* message);
+(instancetype)xyzInPutBarWithViewController:(UIViewController*)vc returnStr:(void(^)(NSString* message))callBack;
@end
