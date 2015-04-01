//
//  BaseRefreshViewController.h
//  beauty
//
//  Created by xieyan on 15-2-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface BaseRefreshViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView*tableView;

/**
 *  是一个二维数组，数组里面是数组。
 */
@property(nonatomic,strong)NSMutableArray*ModelRect;
/**
 *  每一次请求的json字典；
 */
@property(nonatomic,strong)NSDictionary*jsonData;
/**
 *  defaultmanager
 */
@property(nonatomic,strong)NSFileManager * fileManager;
/**
 *  参数
 */
@property (nonatomic,copy) NSString* cacheName;
@property (atomic,strong) NSMutableDictionary* parmaDic;
@property (atomic,copy) NSString* url;
-(instancetype)initWithURL:(NSString*)url ParameterDic:(NSDictionary*)dic;




-(void)DataToModel:(id)response;
-(void)DataToModelForLoadMore:(id)response;//默认调用 -(void)DataToModel:(id)response;

-(NSString*)cacheName;
-(void)loadMore;
-(void)resetModelsContainer;



@end
