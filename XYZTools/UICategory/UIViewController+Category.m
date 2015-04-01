//
//  UIViewController+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIViewController+Category.h"

@interface UIViewController ()
@property(nonatomic,strong)NSMutableDictionary*notificationDic;
@end

@implementation UIViewController (UIViewControllerCategory)

-(void)xyzTabBarnormal:(NSString*)normal selected:(NSString*)selected title:(NSString*)title{
    if (IsiOS6_OR_Lower) {
        self.tabBarItem = [[UITabBarItem alloc] init];
        self.title=title;
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:selected] withFinishedUnselectedImage:[UIImage imageNamed:normal]];
    }else{
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:normal] selectedImage:[UIImage imageNamed:selected]];
    }
    
}


@end
