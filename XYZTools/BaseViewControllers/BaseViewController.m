//
//  BaseViewController.m
//  beauty
//
//  Created by xieyan on 15-2-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "BaseViewController.h"
//#import "LoginViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController
-(void)viewDidLoad{
    [super viewDidLoad];
//    UIButton * btnB=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnB.frame=CGRectMake(0, 0, 44, 44);
//    [btnB setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
//    btnB.tag=999;
//    
////    [btnB setBackgroundImage:[UIImage imageNamed:@"backSelected"] forState:UIControlStateHighlighted];
//    [btnB addTarget:self action:@selector(NavReturnClick) forControlEvents:UIControlEventTouchUpInside];
//    [btnB setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    
    
//    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc]initWithCustomView:btnB];
    
    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(NavReturnClick)];
    [rightBtn setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
//    [rightBtn setTitlePositionAdjustment:UIOffsetMake(-4, -4) forBarMetrics:UIBarMetricsCompact];
    
    self.navigationItem.backBarButtonItem=rightBtn;
   
}

-(void)NavReturnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic SuccessDataArray:(void(^)(NSArray* DataArray))success{
//    [XYZNetWork HttpRequestWithUrl:url parmater:parmaDic succeed:^(NSDictionary *responseDic) {
//        NSArray* respon = responseDic[@"data"];
//        success(respon);
//    } failed:^(NSString *reason) {
//        [XYZToolsCommon pushAlert:reason];
//    } HUDInView:self.view];
//}
//-(void)HttpRequestWithUrl:(NSString*)url parmater:(NSDictionary*)parmaDic SuccessDataDic:(void(^)(NSDictionary* DataDic))success{
//    [XYZNetWork HttpRequestWithUrl:url parmater:parmaDic succeed:^(NSDictionary *responseDic) {
//        NSDictionary* respon = responseDic[@"data"];
//        success(respon);
//    } failed:^(NSString *reason) {
//        [XYZToolsCommon pushAlert:reason];
//    } HUDInView:self.view];
//}




//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
//}





//-(void)cellOriginY:(CGFloat)y tag:(int)tag image:(UIImage*)image title:(NSString*)title{
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.xyzView.xyzWidth, 42)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.xyzView addSubview:view];
//    
//    
//    UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 30, 30)];
//    icon.image = image;
//    [view addSubview:icon];
//    
//    UILabel* label = [XYZToolsCommon labelWithFrame:CGRectMake(icon.right+10, 0, 200, view.xyzHeight) fontSize:13 color:[UIColor blackColor] content:title textAli:NSTextAlignmentLeft];
//    [view addSubview:label];
//    
//    [self separater:view x:label.xyzX y:view.xyzHeight-1];
//    [self rightArrow:view centery:label.xyzYcentral];
//    
//    
//    UIButton* button = [XYZToolsCommon buttonMaskWithFrame:view.bounds color:[UIColor clearColor] target:self func:@selector(buttonClick:) tag:tag];
//    [view addSubview:button];
//    
//    
//}
//-(void)separater:(UIView*)view x:(CGFloat)x y:(CGFloat)y{
//    UIView * separ = [XYZToolsCommon separaterOriginX:x Y:y W:view.xyzWidth-x];
//    [view addSubview:separ];
//}
//-(void)rightArrow:(UIView*)view centery:(CGFloat)centery{
//    UIImageView* right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right-arrow-gray"]];
//    right.frame = CGRectMake(view.xyzWidth-15-9, 0, 9, 14);
//    right.xyzYcentral = centery;
//    [view addSubview:right];
//    
//}
//-(UIButton*)buttonFrame:(CGRect)frame title:(NSString*)title sele:(SEL)selector{
//    UIButton* button = [XYZToolsCommon buttonWithFrame:frame color:ColorBlue target:self func:selector tag:0];
//    button.layer.cornerRadius=5;
//    button.layer.masksToBounds=YES;
//    [button setTitle:title forState:UIControlStateNormal];
//    return button;
//}

//-(void)loginCheckComplete:(void(^)())callback{
//    
//    if (IsLogIn) {
//        callback();
//    }else{
//        [XYZToolsCommon pushAlert:@"请先登陆！" confirm:^{
//            LoginViewController* vc = [[LoginViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }];
//    }
//}
//
//-(void)changeUserInfo:(NSMutableDictionary*(^)(NSMutableDictionary* dicForCommit))infoDicModify complete:(void(^)())complete{
//    NSMutableDictionary* infodic = [NSMutableDictionary dictionaryWithDictionary:@{@"account":Account,@"password":PassWord,@"openid":OpenID,@"name":Name,@"birthday":Birthday,@"height":HeightString,@"city":CityLocation,@"is_marry":IsMerried,@"contact_area":Contact_area,@"contact_address":Contact_address,@"contact_zipcode":Contact_zipcode,@"contact_name":Contact_name,@"contact_phone":Contact_phone}];
//    infodic = infoDicModify(infodic);
//    [XYZNetWork HttpRequestWithUrl:UrlSubmitUserInfo parmater:infodic succeed:^(NSDictionary *responseDic) {
//
//        ALLUSERSETTINGS(infodic)
//        
//        [XYZToolsCommon pushAlert:@"修改成功！" confirm:complete];
//    } failed:^(NSString *reason) {
//        [XYZToolsCommon pushAlert:reason];
//    } HUDInView:self.xyzView];
//    
//}
@end
