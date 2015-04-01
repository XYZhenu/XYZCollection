//
//  XYZImageScrollView.h
//  beauty
//
//  Created by xieyan on 15-3-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZImageScrollView : UIView
@property(nonatomic)UIEdgeInsets contentCellInset;
@property(nonatomic)CGFloat imageWidth;
@property(nonatomic,strong)NSArray*imageArray;
+(instancetype)XYZImageScrollViewWithCallBack:(void(^)(int index))callBack;
@end
