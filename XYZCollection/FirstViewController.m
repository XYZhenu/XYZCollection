//
//  FirstViewController.m
//  XYZCollection
//
//  Created by xieyan on 15/4/8.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
//    
//    self.tabBarController.tabBar.translucent=YES;
    PrintFrame
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    [self performSelector:@selector(go) withObject:nil afterDelay:5];
}
-(void)go{
    ViewController* vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
//        self.navigationController.navigationBar.translucent = YES;
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden=YES;
//    self.navigationController.navigationBar.translucent = YES;
//    
//    self.tabBarController.tabBar.translucent=YES;
    PrintFrame
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.navigationBarHidden=YES;
//    self.navigationController.navigationBar.translucent = YES;
//    
//    self.tabBarController.tabBar.translucent=YES;
    PrintFrame
    
}

@end
