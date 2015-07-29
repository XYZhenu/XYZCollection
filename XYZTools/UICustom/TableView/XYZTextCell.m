//
//  XYZTextCell.m
//  beauty
//
//  Created by xieyan on 15-2-26.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZTextCell.h"
#define ValidFloat(__parma__,__string__)     CGFloat __parma__ = [__string__ floatValue];\
__parma__ = __parma__>0.49?__parma__:0;
@interface XYZTextCell ()
@property(nonatomic,strong)UILabel*xyzLabel;
@end
@implementation XYZTextCell

-(void)afterInit{
    self.xyzLabel=[[UILabel alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.xyzLabel];
    self.xyzLabel.numberOfLines=0;
    self.xyzLabel.font = [UIFont systemFontOfSize:16];
    self.selectionStyle = NO;
}

+(CGFloat)cellHeightForDataDic:(NSDictionary *)datadic Width:(CGFloat)width{
    
    ValidFloat(top, datadic[@"top"])
    ValidFloat(bottom, datadic[@"bottom"])
    ValidFloat(left, datadic[@"left"])
    ValidFloat(right, datadic[@"right"])
    
    
    CGFloat font = [datadic[@"font"] floatValue];
    font = font>0.49?font:16;
    
    CGSize size = [datadic[@"data"] sizeWithFont:[UIFont systemFontOfSize:font]constrainedToSize:CGSizeMake(width-left-right, MAXFLOAT)];
    
    
    return size.height+top+bottom;
}
-(void)processOriginDataDic:(NSDictionary *)dataDic{
    ValidFloat(top, dataDic[@"top"])
    ValidFloat(bottom, dataDic[@"bottom"])
    ValidFloat(left, dataDic[@"left"])
    ValidFloat(right, dataDic[@"right"])
    
    CGFloat font = [dataDic[@"font"] floatValue];
    font = font>0.49?font:16;
    
    self.xyzLabel.font=[UIFont systemFontOfSize:font];
    self.xyzLabel.frame = CGRectMake(left, top, self.contentView.width-left-right, 44);
    self.xyzLabel.xyzTextAdjustHeight=dataDic[@"data"];
    
}


@end
