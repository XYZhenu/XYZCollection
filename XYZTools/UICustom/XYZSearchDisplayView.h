//
//  XYZSearchDisplayView.h
//  beauty
//
//  Created by xieyan on 15-2-27.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZSearchDisplayView : UIView<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UISearchBar*search;
@property(nonatomic,strong)UITableView*display;
@property(atomic,strong)NSArray*DataArray;
@property(nonatomic,strong)void(^selectCallBack)(NSInteger row);
@property(nonatomic,strong)void(^textChange)(NSString*text);
@property(nonatomic,strong)void(^willHide)();
@property(nonatomic,strong)void(^willShow)();
+(instancetype)xyzSearchDisplayView;

-(void)show;
-(void)hide;
@end
