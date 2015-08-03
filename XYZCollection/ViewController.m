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
#import "XYZScroll.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XYZButton *testButton;
@property (weak, nonatomic) IBOutlet XYZSegment *testSegment;
@property (weak, nonatomic) IBOutlet XYZScroll *testScroll;
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
    
    
    
    
    
    [self.testScroll set_createUI:^(UIView *theView) {
        LabelCreate(100)
        label_100.backgroundColor = [UIColor colorWithRed:0.191 green:0.534 blue:1.000 alpha:1.000];
        label_100.textColor = [UIColor whiteColor];
        label_100.textAlignment = NSTextAlignmentCenter;
        theView.backgroundColor = [UIColor colorWithRed:1.000 green:0.689 blue:0.336 alpha:1.000];
        
    } layOut:^(UIView *theView) {
        Label(100).frame = CGRectMake(0, 0, theView.width, 30);
        
    } indicatorRect:nil callBack:^(NSInteger index, UIView *theView, id message) {
        
    } messgaeSet:^(NSInteger index, UIView *theView, id message) {
        Label(100).text = message;
    }];
    
    
    
    self.testScroll.messageArray = @[@"first",@"second",@"third"];
    self.testScroll.enableIndicator=YES;
    self.testScroll.enableTimer = YES;
    self.testScroll.enableInfiniteScroll = NO;
    
    // Do any additional setup after loading the view, typically from a nib.
}

@end
