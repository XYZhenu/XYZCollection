//
//  BaseRefreshViewController.m
//  beauty
//
//  Created by xieyan on 15-2-6.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "BaseRefreshViewController.h"



@interface BaseRefreshViewController ()

@property(nonatomic)NSInteger currentPage;
@property BOOL isFirstRefresh;
@end

@implementation BaseRefreshViewController
//-(instancetype)init{
//    NSAssert(YES, @"init is forbiden! use -(instancetype)initWithURL:(NSString*)url ParameterDic:(NSDictionary*)dic CacheName:(NSString*)name  instead.");
//    return nil;
//}
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    NSAssert(YES, @"init is forbiden! use -(instancetype)initWithURL:(NSString*)url ParameterDic:(NSDictionary*)dic CacheName:(NSString*)name  instead.");
//    return nil;
//}



-(instancetype)initWithURL:(NSString*)url ParameterDic:(NSDictionary*)dic {
    self=[super init];
    if (self) {
        self.url=url;
        self.isFirstRefresh=YES;
        self.parmaDic=[NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return self;
}
-(NSString *)cacheName{
    return nil;
}
-(NSFileManager *)fileManager{
    if (!_fileManager) {
        _fileManager=[NSFileManager defaultManager];
    }
    return _fileManager;
}
-(NSMutableArray *)ModelRect{
    if (!_ModelRect) {
        _ModelRect=[NSMutableArray arrayWithCapacity:10];
    }
    return _ModelRect;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.xyzView.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
        [_tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tableView addFooterWithTarget:self action:@selector(loadMore)];
        
        [self.xyzView addSubview:_tableView];
    }
    return _tableView;
}
-(void)headerRefresh{
    self.currentPage=0;
    if (self.parmaDic[@"page"]) {
        self.parmaDic[@"page"]=@"0";
    }
    
    NSString* filename = nil;//[XYZToolsCommon getFilePath:self.cacheName];
    if (![self.fileManager fileExistsAtPath:filename]||self.cacheName==nil) {
        
        [XYZNetWork HttpRequestWithUrl:self.url parmater:self.parmaDic succeed:^(NSDictionary *responseDic) {
            
            [self.ModelRect removeAllObjects];
            [self resetModelsContainer];
            
            [self processData:responseDic];
            if (self.cacheName) {
                [responseDic writeToFile:filename atomically:YES];
            }
            [self.tableView headerEndRefreshing];
        } failed:^(NSString *reason) {
            [self.tableView headerEndRefreshing];
            [UIAlertView pushAlert:reason];
        } netFailed:^(NSString *error) {
            [self.tableView headerEndRefreshing];
            [UIAlertView pushAlert:NetFailed];
        } HUDInView:self.view];
        
        
        
    }else{
        [self.ModelRect removeAllObjects];
        [self resetModelsContainer];
        
        NSDictionary*jsondata = [NSDictionary dictionaryWithContentsOfFile:filename];
        if (self.isFirstRefresh) {
            [self processData:jsondata];
            self.isFirstRefresh=NO;
        }
        
        NSString * version_id=[self.jsonData objectForKey:@"version_id"];
        if (version_id) {
            if ([version_id isBlank]) {
                version_id=@"1";
            }
            [self.parmaDic setValue:version_id forKey:@"version_id"];
        }
        
        
        [XYZNetWork HttpRequestWithUrl:self.url parmater:self.parmaDic succeed:^(NSDictionary *responseDic) {
            
            [self.ModelRect removeAllObjects];
            [self resetModelsContainer];
            
            [self processData:responseDic];
            if (self.cacheName) {
                [responseDic writeToFile:filename atomically:YES];
            }
            [self.tableView headerEndRefreshing];
        } failed:^(NSString *reason) {
            [self.tableView headerEndRefreshing];
            [UIAlertView pushAlert:reason];
        } netFailed:^(NSString *error) {
            [self.tableView headerEndRefreshing];
            [UIAlertView pushAlert:NetFailed];
        } HUDInView:self.view];
    }
    
}

-(void)processData:(NSDictionary*)jsondata{
    self.jsonData=jsondata;
    
    
    [self DataToModel:jsondata];
    
    
    [self.tableView reloadData];
}

-(void)processDataForLoadMore:(NSDictionary*)jsondata{
    self.jsonData=jsondata;
    
    
    [self DataToModelForLoadMore:jsondata];
    
    
    [self.tableView reloadData];
}
-(void)DataToModel:(id)response{
    
    
    
}
-(void)DataToModelForLoadMore:(id)response{
    [self DataToModel:response];
}
-(void)resetModelsContainer{
    
}
/**
 *  加载更多时走缓存有问题 不能走缓存
 */
-(void)loadMore{
    self.currentPage++;
    if (self.parmaDic[@"page"]) {
        self.parmaDic[@"page"]=[NSString stringWithFormat:@"%d",self.currentPage];
    }
    
//    NSString* filename = [XYZToolsCommon getFilePath:[self.cacheName stringByAppendingFormat:@"%d",self.currentPage]];
//    if (![self.fileManager fileExistsAtPath:filename]||self.cacheName==nil) {
        
        [XYZNetWork HttpRequestWithUrl:self.url parmater:self.parmaDic succeed:^(NSDictionary *responseDic) {
            [self processDataForLoadMore:responseDic];
//            if (self.cacheName) {
//                [responseDic writeToFile:filename atomically:YES];
//            }
            [self.tableView footerEndRefreshing];
        } failed:^(NSString *reason) {
            [self.tableView footerEndRefreshing];
        } netFailed:^(NSString *error) {
            [self.tableView footerEndRefreshing];
        } HUDInView:self.view];
        
//    }else{
//        [self.ModelRect removeAllObjects];
//        NSDictionary*jsondata = [NSDictionary dictionaryWithContentsOfFile:filename];
//        [self processData:jsondata];
//        NSString * version_id=[self.jsonData objectForKey:@"version_id"];
//        if (version_id) {
//            if ([XYZToolsCommon isBlankString:version_id]) {
//                version_id=@"1";
//            }
//            [self.parmaDic setValue:version_id forKey:@"version_id"];
//        }
//        
//        [XYZNetWork HttpRequestWithUrl:self.url parmater:self.parmaDic succeed:^(NSDictionary *responseDic) {
//            [self processData:responseDic];
//            if (self.cacheName) {
//                [responseDic writeToFile:filename atomically:YES];
//            }
//            [self.tableView footerEndRefreshing];
//        } failed:^(NSString *reason) {
//            [self.tableView footerEndRefreshing];
//        } netFailed:^(NSString *error) {
//            [self.tableView footerEndRefreshing];
//        } HUDInView:self.view];
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ModelRect.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)self.ModelRect[section]).count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary*data = self.ModelRect[indexPath.section][indexPath.row];
    XYZTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:data[@"class"]];
    if (!cell) {
        cell                = [XYZCellManager cellForKey:data];
        cell.delegate       = self;
        
        cell.selectionStyle = NO;
    }
    cell.indexPath=indexPath;
    cell.dataDic        = data;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary*data = self.ModelRect[indexPath.section][indexPath.row];
    return [XYZCellManager CellHeightHeight:data Width:self.view.xyzWidth];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{;
    return 0.001;
}


-(void)afterInit{
    
    
    
}
-(void)loadXyzView{
    [self.tableView headerBeginRefreshing];
    
}
@end
