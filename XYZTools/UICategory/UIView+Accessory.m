//
//  UIView+Accessory.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "UIView+Accessory.h"
#import "JSBadgeView.h"
#import <objc/runtime.h>
@interface UIView ()
@property(nonatomic,weak)JSBadgeView*jsBadge;
@end
@implementation UIView (UIViewAccessory)
static char JSBadge;


-(void)setJsBadge:(JSBadgeView *)jsBadge{
//    [self willChangeValueForKey:<#(NSString *)#>];
//    [self didChangeValueForKey:<#(NSString *)#>];
    
    objc_setAssociatedObject(self, &JSBadge, jsBadge, OBJC_ASSOCIATION_ASSIGN);
    
}
-(JSBadgeView *)jsBadge{
    return objc_getAssociatedObject(self, &JSBadge);
}
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
