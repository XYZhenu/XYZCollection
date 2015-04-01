//
//  SKTagView.m
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "XYZAutoResizeView.h"
#define SetOrigin(__VIEW__,__X__,__Y__)     do {CGRect frame = __VIEW__.frame;frame.origin.x = __X__;frame.origin.y = __Y__;__VIEW__.frame=frame;} while (0)
@interface XYZAutoResizeView ()
@property (nonatomic, strong) NSMutableArray *tags;

@property (nonatomic) CGFloat HorizentialSpace;
@property (nonatomic) CGFloat VerticalSpace;
@property (nonatomic) CGFloat preferredMaxLayoutWidth;
@property (nonatomic) BOOL singleLine;

@end

@implementation XYZAutoResizeView
+(instancetype)XYZViewSingleLineHSpace:(CGFloat)space{
    return [self XYZViewSingleLineOriginX:0 Y:0 HSpace:space EdgeInset:UIEdgeInsetsZero];
}
+(instancetype)XYZViewSingleLineOriginX:(CGFloat)X Y:(CGFloat)Y HSpace:(CGFloat)space{
    return [self XYZViewSingleLineOriginX:X Y:Y HSpace:space EdgeInset:UIEdgeInsetsZero];
}
+(instancetype)XYZViewSingleLineOriginX:(CGFloat)X Y:(CGFloat)Y HSpace:(CGFloat)space EdgeInset:(UIEdgeInsets)padding{
    XYZAutoResizeView* view = [[XYZAutoResizeView alloc] initWithFrame:CGRectMake(X, Y, 0, 0)];
    view.HorizentialSpace=space;
    view.padding=padding;
    view.singleLine=YES;
    view.indention=0;
    return view;
}

+(instancetype)XYZViewOriginX:(CGFloat)X Y:(CGFloat)Y MaxWidth:(CGFloat)Width HorizenSpace:(CGFloat)HSpace VertiSpace:(CGFloat)VSpace EdgeInset:(UIEdgeInsets)padding{
    XYZAutoResizeView* view = [[XYZAutoResizeView alloc] initWithFrame:CGRectMake(X, Y, 0, 0)];
    view.HorizentialSpace=HSpace;
    view.VerticalSpace=VSpace;
    view.preferredMaxLayoutWidth=Width;
    view.padding=padding;
    view.singleLine=NO;
    view.indention=0;
    return view;
}
+(instancetype)XYZViewOriginX:(CGFloat)X Y:(CGFloat)Y MaxWidth:(CGFloat)Width{
    return [self XYZViewOriginX:X Y:Y MaxWidth:Width HorizenSpace:0 VertiSpace:0 EdgeInset:UIEdgeInsetsZero];
}
+(instancetype)XYZViewOriginX:(CGFloat)X Y:(CGFloat)Y MaxWidth:(CGFloat)Width HorizenSpace:(CGFloat)HSpace VertiSpace:(CGFloat)VSpace{
    return [self XYZViewOriginX:X Y:Y MaxWidth:Width HorizenSpace:HSpace VertiSpace:VSpace EdgeInset:UIEdgeInsetsZero];
}
-(void)removeAllSubviews{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[UIView class]])
        {
            [(UIView*)obj removeFromSuperview];
        }else{
            NSAssert(NO, @"Error:unknown class type:%@",obj);
        }
    }];
    [_tags removeAllObjects];
    
}
-(void)setXYZTags:(NSArray*)tags
{
    if (!tags.count)
    {
        return;
    }
    
    NSArray *subviews = tags;
    BOOL isFirst = YES;
    CGFloat leftOffset = self.padding.left;
    CGFloat bottomOffset = self.padding.bottom;
    CGFloat rightOffset = self.padding.right;
    CGFloat topOffset = self.padding.top;
    CGFloat HorizentialSpace = self.HorizentialSpace;
    CGFloat VerticalSpace = self.VerticalSpace;
    CGFloat currentX = leftOffset;
    if ((int)self.indention) {
        currentX=self.indention;
    }
    CGFloat currentY = topOffset;
    CGFloat intrinsicHeight = topOffset;
    CGFloat intrinsicWidth = leftOffset;
    CGFloat cellHeight = ((UIView *)subviews.firstObject).frame.size.height;
    
    //Remove old constraints
    [self removeAllSubviews];
    [_tags addObjectsFromArray:tags];
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0)
    {
        for (UIView *view in subviews)
        {
            CGSize size = view.frame.size;
            if (isFirst)
            {
                //first one
                SetOrigin(view, currentX, currentY);
                currentX += size.width;
                isFirst=NO;
            }
            else
            {
                CGFloat width = size.width;
                currentX += HorizentialSpace;
                if (currentX + width + rightOffset <= self.preferredMaxLayoutWidth)
                {
                    SetOrigin(view, currentX, currentY);
                    currentX += size.width;
                }
                else
                {
                    currentX=leftOffset;
                    currentY+=VerticalSpace+cellHeight;
                    //new line
                    SetOrigin(view, currentX, currentY);
                    currentX+=size.width;
                }
            }
            [self addSubview:view];
        }
        intrinsicHeight = currentY+bottomOffset+cellHeight;
        intrinsicWidth = self.preferredMaxLayoutWidth;
    }
    else
    {
        for (UIView *view in subviews)
        {
            CGSize size = view.frame.size;
            if (!isFirst)
            {
                currentX+= HorizentialSpace;
                SetOrigin(view, currentX, currentY);
                currentX += size.width;
            }
            else
            {
                //first one
                SetOrigin(view, currentX, currentY);
                currentX += size.width;
                isFirst=NO;
            }
            [self addSubview:view];
        }
        intrinsicHeight = cellHeight+topOffset+bottomOffset;
        intrinsicWidth = currentX+rightOffset;
    }
    CGRect finalFrame = self.frame;
    finalFrame.size.width=intrinsicWidth;
    finalFrame.size.height=intrinsicHeight;
    self.frame=finalFrame;
}
+(CGFloat)XYZHeightWithTags:(NSArray*)tags MaxWidth:(CGFloat)Width HorizenSpace:(CGFloat)HSpace VertiSpace:(CGFloat)VSpace EdgeInset:(UIEdgeInsets)padding Indention:(CGFloat)indention
{
    if (!tags.count){return 0;}
    
    NSArray *subviews = tags;
    BOOL isFirst = YES;
    CGFloat leftOffset = padding.left;
    CGFloat bottomOffset = padding.bottom;
    CGFloat rightOffset = padding.right;
    CGFloat topOffset = padding.top;
    CGFloat HorizentialSpace = HSpace;
    CGFloat VerticalSpace = VSpace;
    
    CGFloat currentX = ((int)indention)?indention:leftOffset;
    CGFloat cellHeight = ((UIView *)subviews.firstObject).frame.size.height;
    
    NSInteger lineCount = 0;
    for (UIView *view in subviews)
    {
        CGSize size = view.frame.size;
        if (!isFirst)
        {
            CGFloat cellwidth = size.width;
            currentX += HorizentialSpace;
            if (currentX + cellwidth + rightOffset <= Width)
            {
                currentX += size.width;
            }
            else
            {
                //New line
                lineCount ++;
                currentX = leftOffset+size.width;                
            }
            
        }
        else
        {
            //First one
            lineCount ++;
            currentX += size.width;
            isFirst=NO;
        }
    }
    return topOffset+bottomOffset + (VerticalSpace+cellHeight)* lineCount-VerticalSpace;

}
+(CGFloat)XYZSingleLineWidthWithTags:(NSArray*)tags HorizenSpace:(CGFloat)HSpace{
    CGFloat width=0;
    for (UIView* view in tags) {
        width+=view.bounds.size.width;
    }
    return width+(tags.count-1)*HSpace;
}
- (NSMutableArray *)tags
{
    if(!_tags)
    {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
@end
