//
//  XYZAppDelegate.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZAppDelegate.h"
@interface XYZAppDelegate ()

@end
@implementation XYZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController=[[UIViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
    return YES;
}

-(void)AppFirstEnter{
    if (FirstEnter) {
        return;
    }else{
        SetFirstEnter(@"1");
    }
    
    
    SetIsLogIn(NO);

    
}

-(void)AllAppearanceSelector{
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //    [[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(-4, 0) forBarMetrics:UIBarMetricsCompact];
    
//    [[UINavigationBar appearance] setBackgroundImage:[XYZToolsCommon imageWithColor:ColorBlue width:self.window.xyzWidth height:2] forBarMetrics:UIBarMetricsDefault];    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes]; 
    
    [[UITableView appearance] setSeparatorColor:ColorSeparateLine];
    if (IsiOS7_OR_Higher) {
        [[UITableView appearance] setSeparatorInset:UIEdgeInsetsZero];        
        if (IsiOS8_OR_Higher) {
            [[UITableView appearance] setLayoutMargins:UIEdgeInsetsZero];  
        }
    }
    [[UITableView appearance] setTableFooterView:[[UIView alloc] init]];
}
@end
