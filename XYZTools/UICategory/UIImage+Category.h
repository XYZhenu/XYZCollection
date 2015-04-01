//
//  UIImage+Category.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define XYZImage(__COLOR__) [UIImage imageWithColor:__COLOR__ width:1 height:1]

@interface UIImage (UIImageCategory)
+(instancetype)imageWithColor:(UIColor*)color W:(CGFloat)Width H:(CGFloat)Height;


-(UIImage*)xyzScaleToSize:(CGSize)size;
@end
