//
//  XYZMacros.h
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#ifndef XYZCollection_XYZMacros_h
#define XYZCollection_XYZMacros_h
/**
 *  数学方法宏
 *
 */
#define DegreesToRadians(x) ((x) * M_PI / 180.0)

/**
 * 所有预先定义宏
 */
#define Application [UIApplication sharedApplication]
#define UserDefault [NSUserDefaults standardUserDefaults]
#define Device [UIDevice currentDevice]
#define NotificationCenter [NSNotificationCenter defaultCenter]

//#define XYZLOG NSLog(@"\n\n||||||||||  FILE      %s\n\n----------  FUNCTION  %s\n\n^^^^^^^^^^  LINE      %d\n\n",__FILE__,__FUNCTION__,__LINE__);NSLog


#define XYZLOG(...) NSLog(@"\n\n||||||||||  FILE      %s\n\n----------  FUNCTION  %s\n\n^^^^^^^^^^  LINE      %d\n\n",__FILE__,__FUNCTION__,__LINE__);NSLog(__VA_ARGS__);
/**
 *  通知中心
 */
#define PostNotification(__signal__,__object__) \
[NotificationCenter postNotificationName:__signal__ object:__object__]

#define RegistNotification(__signal__,__function__)\
[NotificationCenter addObserver:self selector:@selector(__function__) name:__signal__ object:nil]

#define RemoveNotification(__signal__)\
[NotificationCenter removeObserver:self name:__signal__ object:nil]


/**
 *  设备信息 
 */

#define DeviceID [[Device identifierForVendor]UUIDString]
#define DeviceName [Device name]
#define DeviceModel [Device model]
#define SystemName [Device systemName]
#define SystemVersionFloat [Device systemVersion].floatValue
#define IsiOS6_OR_Lower  (6.9998>SystemVersionFloat)
#define IsiOS7_OR_Higher (6.998<SystemVersionFloat)
#define IsiOS7 (6.998<SystemVersionFloat&&7.0998>SystemVersionFloat)
#define IsiOS7_1 (7.0998<SystemVersionFloat&&7.998>SystemVersionFloat)
#define IsiOS8_OR_Higher (7.998<SystemVersionFloat)
/**
 *  所有用户信息User为前缀
 */
/**
 *  set方法
 */
#define UserSetObj(__OBJECT__,__KEY__) [UserDefault setObject:__OBJECT__ forKey:__KEY__];[UserDefault synchronize] 
#define UserSetBool(__BOOL__,__KEY__) [UserDefault setBool:__BOOL__ forKey:__KEY__];[UserDefault synchronize] 
#define UserSetInt(__INT__,__KEY__) [UserDefault setInteger:__INT__ forKey:__KEY__];[UserDefault synchronize] 
#define UserSetFloat(__FLOAT__,__KEY__) [UserDefault setFloat:__FLOAT__ forKey:__KEY__];[UserDefault synchronize] 
#define UserSetDouble(__DOUBLE__,__KEY__) [UserDefault setDouble:__DOUBLE__ forKey:__KEY__];[UserDefault synchronize] 
//#define UserSetObj(__OBJECT__,__KEY__) [UserDefault setObject:__OBJECT__ forKey:__KEY__];[UserDefault synchronize] 
/**
 *  get方法 如果要防止得到空值，可以在这里统一修改！！！！
 */
#define UserGetString(__KEY__) [UserDefault stringForKey:__KEY__]
#define UserGetArray(__KEY__) [UserDefault arrayForKey:__KEY__]
#define UserGetDictionary(__KEY__) [UserDefault dictionaryForKey:__KEY__]
#define UserGetData(__KEY__) [UserDefault dataForKey:__KEY__]
#define UserGetInt(__KEY__) [UserDefault integerForKey:__KEY__]
#define UserGetBool(__KEY__) [UserDefault boolForKey:__KEY__]
#define UserGetFloat(__KEY__) [UserDefault floatForKey:__KEY__]
#define UserGetDouble(__KEY__) [UserDefault doubleForKey:__KEY__]


#define FirstEnter UserGetString(@"FirstEnter")
#define SetFirstEnter(__KEY__) UserSetObj(__KEY__,@"FirstEnter")



#define PushToken UserGetString(@"PushToken")
#define SetPushToken(__token__) UserSetObj(__token__,@"PushToken")

#define PushOn UserGetBool(@"pushon")
#define SetPushOn(__BOOL__) UserSetBool(__BOOL__,@"pushon")

#define PushAlert UserGetBool(@"pushalert")
#define SetPushAlert(__BOOL__) UserSetBool(__BOOL__,@"pushalert")

#define PushSound UserGetBool(@"pushsound")
#define SetPushSound(__BOOL__) UserSetBool(__BOOL__,@"pushsound")

#define SetIsLogIn(__BOOL__) UserSetBool(__BOOL__,@"islogin")
#define IsLogIn UserGetBool(@"islogin")




#define Name [XYZToolsCommon validateStr:UserGetString(@"name")]
#define SetName(__OBJECT__) UserSetObj(__OBJECT__,@"name")

#define Phone [XYZToolsCommon validateStr:UserGetString(@"phone")]
#define SetPhone(__OBJECT__) UserSetObj(__OBJECT__,@"phone")

#define PassWord [XYZToolsCommon validateStr:UserGetString(@"password")]
#define SetPassWord(__OBJECT__) UserSetObj(__OBJECT__,@"password")

#define Icon [XYZToolsCommon validateStr:UserGetString(@"icon")]
#define SetIcon(__OBJECT__) UserSetObj(__OBJECT__,@"icon")

#define Account [XYZToolsCommon validateStr:UserGetString(@"account")]
#define SetAccount(__OBJECT__) UserSetObj(__OBJECT__,@"account")

#define OpenID [XYZToolsCommon validateStr:UserGetString(@"openid")]
#define SetOpenID(__OBJECT__) UserSetObj(__OBJECT__,@"openid")


/**
 *  所有颜色  必须以Color开头命名
 */

#define ColorBackGround ColorMaker(239.0,239.0,244.0)


#define ColorSeparateLine ColorMaker(209.0,209.0,209.0)
#define ColorTextGray ColorMaker(190.0,190.0,190.0)
#define ColorTextRed ColorMaker(251.0,91.0,121.0)


#define ColorButtonGray ColorMaker(210.0,210.0,210.0)
#define ColorButtonLogIn ColorMaker(255.0,87.0,119.0)
#define ColorBackGroundGray ColorMaker(210.0,210.0,210.0)

//#define ColorBlue OXColor(@"17b6ed")

#define ColorCoverViewBg [UIColor colorWithRed:0.0 green:0.0  blue:0.0  alpha:0.7]


/**
 *  所有字体 必须以Font开头命名
 */
#define FontMaker(_SIZE_) [UIFont systemFontOfSize:_SIZE_] 
#define FontNavTitle FontMaker(16)




/**
 *  加载xib
 */
#define LoadNib(__CLASS__) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([__CLASS__ class]) owner:nil options:nil] lastObject]
#define LoadXib(__NAME__) [[[NSBundle mainBundle] loadNibNamed:__NAME__ owner:nil options:nil] lastObject]





#endif
