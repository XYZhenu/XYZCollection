//
//  XYZImageCell.m
//  beauty
//
//  Created by xieyan on 15-2-26.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZImageCell.h"
#define ValidFloat(__parma__,__string__)     CGFloat __parma__ = [__string__ floatValue];\
__parma__ = __parma__>0.49?__parma__:0;

@implementation XYZImageCell

-(void)afterInit{
    self.coverImage = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.coverImage];
    self.coverImage.contentMode=UIViewContentModeScaleAspectFit;
}
+(CGFloat)cellHeightForContent:(id)content Width:(CGFloat)width{    
    CGFloat imageheight = [content[@"imageHeight"] integerValue];
    CGFloat imagewidth = [content[@"imageWidth"] integerValue];
    if (imagewidth<width) {
        return imageheight;
    }else{
        imageheight = (imageheight*width/imagewidth);
        return imageheight;
    }
}
+(CGFloat)cellHeightForDataDic:(NSDictionary *)datadic Width:(CGFloat)width{
    
    ValidFloat(top, datadic[@"top"])
    ValidFloat(bottom, datadic[@"bottom"])
    ValidFloat(left, datadic[@"left"])
    ValidFloat(right, datadic[@"right"])
    
    return [self cellHeightForContent:datadic[@"data"] Width:width-left-right]+top+bottom;
}
-(void)processOriginDataDic:(NSDictionary *)dataDic{
    NSDictionary* data = dataDic[@"data"];
    ValidFloat(top, dataDic[@"top"])
    ValidFloat(bottom, dataDic[@"bottom"])
    ValidFloat(left, dataDic[@"left"])
    ValidFloat(right, dataDic[@"right"])
    
    [XYZNetWork loadImage:data[@"imageUrl"] complete:^(UIImage *image) {
        CGRect frame;
        frame.origin=CGPointMake(left, top);
        frame.size.width=self.contentView.frame.size.width-left-right;
        frame.size.height=[XYZImageCell cellHeightForContent:data Width:frame.size.width];
        self.coverImage.frame=frame;
        self.coverImage.image=image;
    } placeholder:[UIImage imageNamed:@"defaultpicture"] underControl:YES];
    
}

@end
