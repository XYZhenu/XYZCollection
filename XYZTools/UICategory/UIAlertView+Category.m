//
//  UIAlertView+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIAlertView+Category.h"
@interface UIAlertView ()<UIAlertViewDelegate>
@property(nonatomic,strong)void(^callback)();
@end
@implementation UIAlertView (UIAlertViewCategory)
+(void)pushAlert:(NSString*)content{
    UIAlertView* aler = [[UIAlertView alloc] initWithTitle:nil message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [aler show];
}
+(void)pushAlert:(NSString*)content confirm:(void(^)())confirm{
    
    UIAlertView* aler = [[UIAlertView alloc] initWithTitle:nil message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    aler.callback=confirm;
    [aler show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        self.callback();
    }
}
@end
