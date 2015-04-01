//
//  BaseDetailViewController.m
//  beauty
//
//  Created by xieyan on 15-2-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "BaseDetailViewController.h"

@interface BaseDetailViewController ()

@end

@implementation BaseDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor=ColorBackGround;    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault]; 
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav_shadow"] forBarMetrics:UIBarMetricsDefault];    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    
}
@end
