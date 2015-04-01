//
//  UIAlertView+Category.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (UIAlertViewCategory)
+(void)pushAlert:(NSString*)content;
+(void)pushAlert:(NSString*)content confirm:(void(^)())confirm;
@end
