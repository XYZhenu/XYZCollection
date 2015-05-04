//
//  UIImage+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (UIImageCategory)
+(instancetype)imageWithColor:(UIColor*)color W:(CGFloat)Width H:(CGFloat)Height{
    CGSize imageSize = CGSizeMake(Width, Height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}



-(UIImage*)xyzScaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}



+(UIImage*)xyzImageContext:(CGRect)rect View:(UIView*)view
{
    
    UIGraphicsBeginImageContext(view.frame.size); //currentView 当前的view
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //从全屏中截取指定的范围
    CGImageRef imageRef = viewImage.CGImage;
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    return sendImage;
    /******截取图片保存的位置，如果想要保存，请把return向后移动*********/
    NSData*data=UIImagePNGRepresentation(viewImage);
    NSString*path=[NSHomeDirectory() stringByAppendingString:@"/documents/1.png"];
    [data writeToFile:path atomically:YES];
    
    NSLog(@"%@",path);
    
    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);
    CGImageRelease(imageRefRect);
    /***************/
    
}

@end
