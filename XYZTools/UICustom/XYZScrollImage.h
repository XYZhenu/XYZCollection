//
//  XYZScrollImage.h
//  layout
//
//  Created by xieyan on 15/7/24.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZScroll.h"

@interface XYZScrollImage : UIView
@property(nonatomic,strong)XYZScroll* scroll;


@property(nonatomic,assign)UIEdgeInsets scrollInset;
@property(nonatomic,assign)UIEdgeInsets pageInset;


@property(nonatomic)NSArray* imageArray;





+(instancetype)new;
-(instancetype)block_imageMessage2Url:(NSString*(^)(id message))message2Url
                             callBack:(void(^)(NSInteger index,id message))callBack;
@end
