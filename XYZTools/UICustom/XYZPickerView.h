//
//  XYZPickerView.h
//  shell
//
//  Created by xieyan on 15/3/26.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZPickerView : UIView

-(instancetype)initWithFrame:(CGRect)frame COMnum:(NSInteger)COMnum RowOfComp:(NSInteger(^)(NSInteger comIndex))rowNum title:(NSString*(^)(NSInteger compo,NSInteger row))title selectionCallBack:(void(^)(NSInteger compo,NSInteger row,NSArray*data))callback;
@property(nonatomic)CGFloat rowHeight;
@property(nonatomic,strong)CGFloat (^widthForCompo)(NSInteger compo);
@property(nonatomic,strong)NSAttributedString*(^attribuateTitle)(NSInteger compo,NSInteger row);
@property(nonatomic,strong)UIView*(^customView)(NSInteger compo,NSInteger row);
@end
