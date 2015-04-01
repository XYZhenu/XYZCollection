//
//  XYZCellManager.h
//  beauty
//
//  Created by xieyan on 15-2-17.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYZTableViewCell.h"

#import "XYZTextCell.h"
#import "XYZImageCell.h"





@interface XYZCellManager : NSObject
+(XYZTableViewCell*)cellForKey:(id)key;
+(Class)cellManagerCellClassForKey:(id)key;
+(CGFloat)CellHeightHeight:(NSDictionary*)data Width:(CGFloat)width;
@end
