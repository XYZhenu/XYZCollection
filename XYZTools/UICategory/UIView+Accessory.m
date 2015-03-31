//
//  UIView+Accessory.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIView+Accessory.h"
#import "JSBadgeView.h"
@interface UIView ()
@property(nonatomic,strong)JSBadgeView*jsBadge;
@end
@implementation UIView (UIViewAccessory)

- (void)xyzBadgeValueStr:(NSString *)strBadgeValue{
    if (!self.jsBadge) {
        self.jsBadge = [[JSBadgeView alloc] initWithParentView:self alignment:JSBadgeViewAlignmentTopRight];
    }
    if ([strBadgeValue integerValue]<=0) {
        [self.jsBadge removeFromSuperview];
    }else{
        self.jsBadge.badgeText=strBadgeValue;
    }
}
- (void)xyzBadgeValueInt:(NSInteger)BadgeValue{
    if (!self.jsBadge) {
        self.jsBadge = [[JSBadgeView alloc] initWithParentView:self alignment:JSBadgeViewAlignmentTopRight];
    }
    if (BadgeValue<=0) {
        [self.jsBadge removeFromSuperview];
    }else{
        self.jsBadge.badgeText=[NSString stringWithFormat:@"%d",BadgeValue];
    }
}
@end
