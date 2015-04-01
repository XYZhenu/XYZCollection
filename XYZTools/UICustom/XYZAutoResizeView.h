//
//  XYZAutoResizeView.h
//  layout
//
//  Created by xieyan on 15-2-11.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZAutoResizeView : UIView
@property(nonatomic)CGFloat indention;
@property (nonatomic) UIEdgeInsets padding;
-(void)setXYZTags:(NSArray*)tags;
-(void)removeAllSubviews;
/**
 *  单行
 */
+(instancetype)XYZViewSingleLineHSpace:(CGFloat)space;
+(instancetype)XYZViewSingleLineOriginX:(CGFloat)X Y:(CGFloat)Y HSpace:(CGFloat)space;
+(instancetype)XYZViewSingleLineOriginX:(CGFloat)X Y:(CGFloat)Y HSpace:(CGFloat)space EdgeInset:(UIEdgeInsets)padding;
/**
 *  多行
 */

+(instancetype)XYZViewOriginX:(CGFloat)X Y:(CGFloat)Y MaxWidth:(CGFloat)Width;
+(instancetype)XYZViewOriginX:(CGFloat)X Y:(CGFloat)Y MaxWidth:(CGFloat)Width HorizenSpace:(CGFloat)HSpace VertiSpace:(CGFloat)VSpace;
+(instancetype)XYZViewOriginX:(CGFloat)X Y:(CGFloat)Y MaxWidth:(CGFloat)Width HorizenSpace:(CGFloat)HSpace VertiSpace:(CGFloat)VSpace EdgeInset:(UIEdgeInsets)padding;



+(CGFloat)XYZHeightWithTags:(NSArray*)tags MaxWidth:(CGFloat)Width HorizenSpace:(CGFloat)HSpace VertiSpace:(CGFloat)VSpace EdgeInset:(UIEdgeInsets)padding Indention:(CGFloat)indention;
/**
 *  只返回单行所有subview长度和空隙总长度，不包括edgeinset
 *
 */
+(CGFloat)XYZSingleLineWidthWithTags:(NSArray*)tags HorizenSpace:(CGFloat)HSpace;

//- (void)addTag:(UIView *)tag;
//- (void)insertTag:(SKTag *)tag atIndex:(NSUInteger)index;
//- (void)removeTag:(SKTag *)tag;
//- (void)removeTagAtIndex:(NSUInteger)index;
//- (void)removeAllTags;

//@property (nonatomic, copy) void (^didClickTagAtIndex)(NSUInteger index);
@end
