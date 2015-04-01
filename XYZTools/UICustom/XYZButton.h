//
//  XYZButton.h
//  XYZCollection
//
//  Created by xieyan on 15/4/1.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XYZButtonDelegate <NSObject>
-(void)XYZButtonCallBack:(BOOL)isSelected tag:(int)tag;
@end
@interface XYZButton : UIView
@property (nonatomic,strong) UIImage           *xyzImage;
@property (nonatomic,strong) UIImage           *xyzImageSelected;
@property (nonatomic       ) UIViewContentMode xyzImageContentMode;
@property(nonatomic)BOOL isSelected;
@property (nonatomic       ) UIEdgeInsets      xyzInset;


- (void)xyzImageWithURL:(NSString *)url;
- (void)xyzImageWithURL:(NSString *)url
       placeholderImage:(UIImage *)placeholderImage;

@property (nonatomic       ) float           xyzTitleFont;
@property (nonatomic,strong) UIColor         *xyzTitleColor;
@property (nonatomic       ) NSTextAlignment xyzTitleAlignment;
@property (nonatomic,strong) NSString        *xyzTitleText;


@property (nonatomic,weak) id<XYZButtonDelegate>delegate;
@property(nonatomic,strong)void(^callback)(BOOL isSelected, int tag);

+(instancetype)buttonWithImageWidth:(CGFloat)imageWidth height:(CGFloat)buttonHeight;

+(instancetype)buttonWithFrame:(CGRect)frame callBack:(void(^)(BOOL isSelected, int tag))callBack;

+(instancetype)ButtonCentralContentWithFrame:(CGRect)frame imageWidth:(CGFloat)width;
@end
