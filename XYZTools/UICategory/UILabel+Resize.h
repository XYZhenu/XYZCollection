//
//  UILabel+Resize.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  UILabel (UILabelResize)
@property(nonatomic,strong,getter=text)NSString*xyzTextAdjustWidth;
@property(nonatomic,strong,getter=text)NSString*xyzTextAdjustHeight;
@property(nonatomic,strong,getter=text)NSString*xyzTextAdjustWidthFromRight;

@property(nonatomic)CGFloat xyzIndention;


-(void)xyzResizeParagraphStyle:(NSMutableParagraphStyle*(^)(NSMutableParagraphStyle*))paragraph;
@end
