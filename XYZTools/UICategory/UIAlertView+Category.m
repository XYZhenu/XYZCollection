//
//  UIAlertView+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIAlertView+Category.h"
#import <objc/runtime.h>
@interface UIAlert ()<UIAlertViewDelegate>
@property(nonatomic,strong)void(^callback)();
@end
@implementation UIAlert

+(instancetype)instance{
    static UIAlert* alertManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertManager = [[UIAlert alloc] init];
    });
    return alertManager;
}
+(void)pushAlert:(NSString*)content{
    UIAlertView* aler = [[UIAlertView alloc] initWithTitle:nil message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [aler show];
}
+(void)pushAlert:(NSString*)content confirm:(void(^)())confirm{
    UIAlertView* aler = [[UIAlertView alloc] initWithTitle:nil message:content delegate:[UIAlert instance] cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [UIAlert instance].callback=confirm;
    [aler show];
}
+(void)pushCancelAlert:(NSString*)content confirm:(void(^)())confirm{
    UIAlertView* aler = [[UIAlertView alloc] initWithTitle:nil message:content delegate:[UIAlert instance] cancelButtonTitle:@"确定" otherButtonTitles: @"取消",nil];
    [UIAlert instance].callback=confirm;
    [aler show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        self.callback();
    }
}
@end
