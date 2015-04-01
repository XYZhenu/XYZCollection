//
//  XYZSearchDisplayView.m
//  beauty
//
//  Created by xieyan on 15-2-27.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZSearchDisplayView.h"

@implementation XYZSearchDisplayView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.search=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, size.width, 44)];
        self.search.delegate=self;
        self.search.showsCancelButton=YES;
        [self addSubview:self.search];
        
        self.display=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, size.width, size.height-64) style:UITableViewStylePlain];
        self.display.delegate=self;
        self.display.dataSource=self;
        [self addSubview:self.display];
    }
    return self;
}
+(instancetype)xyzSearchDisplayView{
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
}
-(void)setDataArray:(NSArray *)DataArray{
    _DataArray=DataArray;
    [self.display reloadData];
}
-(void)show{
    
    if (self.willShow) {
        self.willShow();
    }
    
    UIWindow*window = [Application.delegate window];
    [window addSubview:self];
    [self.search becomeFirstResponder];
}
-(void)hide{
    if (self.willHide) {
        self.willHide();
    }
    [self.search resignFirstResponder];
    [self removeFromSuperview];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (self.textChange) {
        self.textChange(searchText);
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    if (self.textChange) {
        self.textChange(@"");
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;{
    [self hide];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* searchcell = [tableView dequeueReusableCellWithIdentifier:@"searchresult"];
    if (!searchcell) {
        searchcell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchresult"];
    }
    searchcell.textLabel.text=self.DataArray[indexPath.row];
    return searchcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectCallBack) {
        self.selectCallBack(indexPath.row);
    }
    
    [self hide];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count;
}
@end
