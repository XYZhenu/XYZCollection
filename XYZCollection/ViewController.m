//
//  ViewController.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "ViewController.h"
#import "XYZButton.h"
#import "XYZSegment.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XYZButton *testButton;
@property (weak, nonatomic) IBOutlet XYZSegment *testSegment;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.testButton set_customUI:^(XYZView *theView) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
        [theView addSubview:label];
        label.tag = 100;
        label.backgroundColor = [UIColor redColor];
        label.text = @"test the button";
    } layOut:^(XYZView *theView) {
        UIView* label = [theView viewWithTag:100];
        label.frame =CGRectMake(10, 10, 100, 40);
    } callBack:^(BOOL isSelected, XYZView *theView) {
        UIView* view = [theView viewWithTag:101];
        if (isSelected) {
            view.backgroundColor = [UIColor yellowColor];
        }else{
            view.backgroundColor = [UIColor redColor];
        }
    } touched:^(BOOL isTouched, XYZView *theView) {
        theView.backgroundColor = isTouched?[UIColor greenColor]:[UIColor blueColor];
    } messgaeSet:^(BOOL isSelected, XYZView *theView, id message) {
        UILabel* label = (UILabel* )[theView viewWithTag:100];
        label.text = message;
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.testButton.message = @"the button have received message";
    });
    
    NSArray* array = @[@"first",@"second",@"third",@"forth"];
    [self.testSegment set_Num:4 createUI:^(XYZView *theView, NSInteger index) {
        UILabel* label = [[UILabel alloc] init];
        label.tag=100;
        label.text = array[index];
        label.backgroundColor = [UIColor clearColor];
        [theView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        theView.separatorColor = [UIColor greenColor];
        theView.separatorInset = UIEdgeInsetsMake(0, 0, 0, theView.height);
    } layOut:^(XYZView *theView,NSInteger index) {
        UIView* view = [theView viewWithTag:100];
        view.frame = theView.bounds;
    } selectState:^(XYZView *theView, BOOL selected) {
        UIView* view = [theView viewWithTag:100];
        
        if (selected) {
            view.backgroundColor = [UIColor grayColor];
        }else{
            view.backgroundColor = [UIColor clearColor];
        }
        
    } callBack:^(NSInteger index) {
        
    }];
    self.testSegment.separatorColor = [UIColor greenColor];
    self.testSegment.separatorInset = UIEdgeInsetsMake(self.testSegment.width, self.testSegment.height, self.testSegment.width, self.testSegment.height);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

@end
