//
//  XYZImageCell.h
//  beauty
//
//  Created by xieyan on 15-2-26.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZTableViewCell.h"
#define XYZTableViewImageModel(__Data__,__top__,__bottom__,__left__,__right__) @{@"class":NSStringFromClass([XYZImageCell class]),@"data":__Data__,@"top":__top__,@"bottom":__bottom__,@"left":__left__,@"right":__right__}

@interface XYZImageCell : XYZTableViewCell
@property(nonatomic,strong)UIImageView* coverImage;
@property(nonatomic,assign)UIEdgeInsets insets;
@end
