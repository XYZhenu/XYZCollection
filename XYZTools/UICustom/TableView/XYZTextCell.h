//
//  XYZTextCell.h
//  beauty
//
//  Created by xieyan on 15-2-26.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZTableViewCell.h"
#define XYZTableViewTextModel(__Data__,__font__,__top__,__bottom__,__left__,__right__) @{@"class":NSStringFromClass([XYZTextCell class]),@"data":__Data__,@"top":__top__,@"bottom":__bottom__,@"left":__left__,@"right":__right__,@"font":__font__}
@interface XYZTextCell : XYZTableViewCell

@end
