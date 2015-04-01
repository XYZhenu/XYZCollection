//
//  XYZTableViewCell.h
//  beauty
//
//  Created by xieyan on 15-2-11.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define XYZTableViewModel(__CellClass__,__Data__) @{@"class":NSStringFromClass([__CellClass__ class]),@"data":__Data__}
@class XYZTableViewCell;


@protocol XYZTableViewCellDelegate <NSObject>
-(void)XYZTableViewCellResponse:(XYZTableViewCell*)cell;
@end


@interface XYZTableViewCell : UITableViewCell
@property(nonatomic,assign)id<XYZTableViewCellDelegate>delegate;
@property(nonatomic)NSInteger index;
@property(nonatomic,strong)NSIndexPath*indexPath;
@property BOOL onState;
@property(nonatomic,strong)NSString*responseStr;
@property(nonatomic,strong)NSDictionary*responseDic;



@property(nonatomic,strong)NSDictionary*dataDic;
-(void)processOriginDataDic:(NSDictionary*)dataDic;
+(CGFloat)cellHeightForDataDic:(NSDictionary*)datadic Width:(CGFloat)width;

/**
 *  必须重写
 */
-(void)processDataFromDataDic:(id)data;

-(void)afterInit;

+(CGFloat)cellHeightForContent:(id)content Width:(CGFloat)width;

@end

