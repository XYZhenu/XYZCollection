//
//  UILabel+Resize.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UILabel+Resize.h"
#import "UIView+Geometry.h"

@implementation UILabel (UILabelResize)
-(void)setXyzTextAdjustWidth:(NSString *)xyzTextAdjustWidth{
    CGFloat width = [xyzTextAdjustWidth sizeWithFont:self.font].width;
    self.xyzWidth=width;
    self.text=xyzTextAdjustWidth;
}
-(void)setXyzTextAdjustHeight:(NSString *)xyzTextAdjustHeight{
    CGFloat height = [xyzTextAdjustHeight sizeWithFont:self.font constrainedToSize:CGSizeMake(self.xyzWidth,MAXFLOAT)].height;
    
    self.xyzHeight=height+0.5;
    self.text=xyzTextAdjustHeight;
}
-(void)setXyzTextAdjustWidthFromRight:(NSString *)xyzTextAdjustWidthFromRight{
    CGFloat width = [xyzTextAdjustWidthFromRight sizeWithFont:self.font].width;
    CGFloat rightX = self.xyzX1;
    self.xyzWidth=width;
    self.xyzX1 = rightX;
    self.text=xyzTextAdjustWidthFromRight;
}

-(void)setXyzIndention:(CGFloat)xyzIndention
{
    NSMutableAttributedString *attributedString = [[ NSMutableAttributedString alloc ] initWithString : self.text ];
    
    NSMutableParagraphStyle *paragraphStyle = [[ NSMutableParagraphStyle alloc ] init ];
    
    [paragraphStyle setFirstLineHeadIndent : xyzIndention ]; //首行缩进 
    
    [attributedString addAttribute : NSParagraphStyleAttributeName value :paragraphStyle range : NSMakeRange ( 0 , [ self.text length ])];
    
    
    self.attributedText = attributedString;
    
    self.xyzHeight = [self.text sizeWithAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:self.font,NSViewSizeDocumentAttribute:[NSValue valueWithCGSize:CGSizeMake(self.xyzWidth, MAXFLOAT)]}].height+2;
}
-(CGFloat)xyzIndention{
    return 0;
}
-(void)xyzResizeParagraphStyle:(NSMutableParagraphStyle*(^)(NSMutableParagraphStyle*))paragraph{
    
    NSMutableParagraphStyle *paragraphStyle = paragraph([[ NSMutableParagraphStyle alloc ] init ]);
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSViewSizeDocumentAttribute:[NSValue valueWithCGSize:CGSizeMake(self.xyzWidth, MAXFLOAT)]}];
    
    self.xyzHeight = [self.attributedText size].height+0.5;
}


@end
