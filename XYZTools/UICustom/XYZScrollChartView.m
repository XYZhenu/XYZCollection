//
//  XYZScrollChartView.m
//  表格
//
//  Created by xieyan on 15/5/14.
//  Copyright (c) 2015年 zzy. All rights reserved.
//

#import "XYZScrollChartView.h"
@interface XYZScrollChartView ()<UIScrollViewDelegate>
{
    UIScrollView* _titleScroll;
    
    UIScrollView* _leftScroll;
    UIScrollView* _rightScroll;
    
    
    CGFloat _cellHeight;
    CGFloat _cellWidth;
    CGFloat _topHeight;
    CGFloat _leftWidth;
    
    BOOL _isSet;
    BOOL _isBuild;
    NSInteger _leftNum;
    NSInteger _topNum;
    
    NSMutableArray* _contentArray;
    NSMutableDictionary* _contentDic;
    
    NSMutableArray* _tagArray;
    NSMutableDictionary* _tagDic;
}
@property(nonatomic,strong)UIView*(^buildLeft)(CGRect frame);
@property(nonatomic,strong)void(^buildLeftLabel)(UIView* view,NSInteger index);

@property(nonatomic,strong)UIView*(^buildTop)(CGRect frame);
@property(nonatomic,strong)void(^buildTopLabel)(UIView* view,NSInteger index);

@property(nonatomic,strong)void(^buildTag)(UIView* view,id content);
@property(nonatomic,strong)void(^clickTag)(UIView* view,id content);

@property(nonatomic,strong)CGRect(^getFrame)(CGFloat cellWidth,CGFloat cellHeight,CGFloat totalWidth,CGFloat totalHeight,id content);

@property(nonatomic)BOOL showGrid;
@end

@implementation XYZScrollChartView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepare];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}
-(void)prepare{
    _isSet = NO;
    _isBuild = NO;
}



-(instancetype)set_cellHeight:(CGFloat)cellheight cellWidth:(CGFloat)cellwidth topHeight:(CGFloat)topheight leftWidth:(CGFloat)leftWidth topNum:(NSInteger)topNum leftNum:(NSInteger)leftNum{
    if (_isBuild) {
        return self;
    }else{
        _isBuild = YES;
    }
    _cellHeight = cellheight;
    _cellWidth = cellwidth;
    _topHeight = topheight;
    _leftWidth = leftWidth;
    _topNum = topNum;
    _leftNum = leftNum;    
    _contentArray = [NSMutableArray arrayWithCapacity:5];
    _tagArray = [NSMutableArray arrayWithCapacity:5];
    [self buildInterface];
    return self;
}




-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    CGFloat topHeight = _topHeight;
    CGFloat leftWidth = _leftWidth;
    _titleScroll.frame = CGRectMake(leftWidth, 0, size.width-leftWidth, topHeight);
    _leftScroll.frame = CGRectMake(0, topHeight, size.width, size.height-topHeight);
    _rightScroll.frame = CGRectMake(leftWidth, 0, size.width-leftWidth, _leftNum*_cellHeight);
}
#define ColorClear [UIColor clearColor]
-(void)buildInterface{

    _titleScroll = [[UIScrollView alloc] init];
    _titleScroll.contentSize = CGSizeMake(_topNum*_cellWidth,0);
    _titleScroll.bounces=NO;
    _titleScroll.delegate = self;
    _titleScroll.backgroundColor = ColorClear;
    _titleScroll.showsHorizontalScrollIndicator=NO;
    [self addSubview:_titleScroll];
    
    
    
    _leftScroll = [[UIScrollView alloc] init];
    _leftScroll.contentSize = CGSizeMake(0, _leftNum*_cellHeight);
    _leftScroll.bounces=NO;
    _leftScroll.backgroundColor = ColorClear;
    [self addSubview:_leftScroll];
    
    
    _rightScroll = [[UIScrollView alloc] init];
    _rightScroll.contentSize = CGSizeMake(_topNum*_cellWidth, 0);
    _rightScroll.delegate=self;
    _rightScroll.bounces=NO;
    _rightScroll.backgroundColor = [UIColor whiteColor];
    _rightScroll.showsHorizontalScrollIndicator=NO;
    [_leftScroll addSubview:_rightScroll];
    

    [self createTopLabel];
    [self createLeftLabel];
}
#define RandColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define SeparatorColor ColorSeparateLine
-(void)createTopLabel{
    
    
    CGFloat separHeight = _leftScroll.contentSize.height;
    if (self.buildTop) {
        UIView* topview = self.buildTop(CGRectMake(0, 0, _cellWidth*_topNum, _cellHeight));
        topview.tag = 10000;
        [_titleScroll addSubview:topview];
        
        for (int i=0; i<_topNum; i++) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(i*_cellWidth+_cellWidth, 0, 1, separHeight)];
            view.backgroundColor = SeparatorColor;
            view.tag = 10000;
            [_rightScroll addSubview:view];
        }
    }else{
        for (int i=0; i<_topNum; i++) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(i*_cellWidth+_cellWidth, 0, 1, separHeight)];
            view.backgroundColor = SeparatorColor;
            view.tag = 10000;
            [_rightScroll addSubview:view];
            
            if (self.buildTopLabel) {
                UIView* view = [[UIView alloc] initWithFrame:CGRectMake(i*_cellWidth, 0, _cellWidth, _topHeight)];
                self.buildTopLabel(view,i);
                view.tag=10000;
                [_titleScroll addSubview:view];
            }else{
                UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i*_cellWidth, 0, _cellWidth, _topHeight)];
                label.text = [NSString stringWithFormat:@"%d",i];
                label.backgroundColor = RandColor;
                label.tag=10000;
                [_titleScroll addSubview:label];
            }
        }
    }
}
-(void)createLeftLabel{
    
    CGFloat separWidth = _rightScroll.contentSize.width;
    if (self.buildLeft) {
        UIView* leftview = self.buildLeft(CGRectMake(0, 0,_leftWidth, _cellHeight*_leftNum));
        leftview.tag=10000;
        [_leftScroll addSubview:leftview];
        for (int i=0; i<_leftNum; i++) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, i*_cellHeight+_cellHeight, separWidth, 1)];
            view.backgroundColor = SeparatorColor;
            view.tag=10000;
            [_rightScroll addSubview:view];
        }
    }else{
        for (int i=0; i<_leftNum; i++) {
            if (self.buildLeftLabel) {
                UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, i*_cellHeight, _leftWidth, _cellHeight)];
                self.buildLeftLabel(view,i);
                view.tag=10000;
                [_leftScroll addSubview:view];
            }else{
                UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, i*_cellHeight, _leftWidth, _cellHeight)];
                label.text = [NSString stringWithFormat:@"%d",i];
                label.backgroundColor = RandColor;
                label.tag=10000;
                [_leftScroll addSubview:label];
            }
            
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, i*_cellHeight+_cellHeight, separWidth, 1)];
            view.backgroundColor = SeparatorColor;
            view.tag=10000;
            [_rightScroll addSubview:view];
            
        }
    }
}
-(void)clear{
    for (UIView* view in _leftScroll.subviews) {
        if (view.tag==10000) {
            [view removeFromSuperview];
        }
    }
    for (UIView* view in _titleScroll.subviews) {
        if (view.tag==10000) {
            [view removeFromSuperview];
        }
    }
    for (UIView* view in _rightScroll.subviews) {
        if (view.tag==10000) {
            [view removeFromSuperview];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_rightScroll) {
        CGPoint offset = _rightScroll.contentOffset;
        _titleScroll.contentOffset = offset;
    }else if (scrollView==_titleScroll){
        CGPoint offset = _titleScroll.contentOffset;
        _rightScroll.contentOffset = offset;
    }
}

-(void)resetTag{
    for (UIView* view in _tagArray) {
        [view removeFromSuperview];
    }
    [_tagArray removeAllObjects];
    [_contentArray removeAllObjects];
}
-(void)addTagContent:(id)content{
    if (!self.getFrame) {
        return;
    }
    
    if ([_contentArray containsObject:content]) {
        return;
    }
    
    
    UIView* view = [[UIView alloc]initWithFrame:self.getFrame(_cellWidth,_cellHeight,_cellWidth*_topNum,_cellHeight*_leftNum,content)];
    if (self.buildTag) {
        self.buildTag(view,content);
    }
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.bounds;
    [button addTarget:self action:@selector(tagClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 10000+_contentArray.count;
    [view addSubview:button];
    [_rightScroll addSubview:view];
    
    [_contentArray addObject:content];
    [_tagArray addObject:view];
}
-(void)tagClicked:(UIButton*)sender{
    if (self.clickTag) {
        self.clickTag(_tagArray[sender.tag-10000],_contentArray[sender.tag-10000]);
    }
}




-(instancetype)block_getFrame:(CGRect(^)(CGFloat cellWidth,CGFloat cellHeight,CGFloat totalWidth,CGFloat totalHeight,id content))getFrame 
       buildLeftLabel:(void(^)(UIView* view,NSInteger index))buildLeftLabel 
        buildTopLabel:(void(^)(UIView* view,NSInteger index))buildTopLabel 
             buildTag:(void(^)(UIView* view,id content))buildTag 
             clickTag:(void(^)(UIView* view,id content))clickTag
            buildLeft:(UIView*(^)(CGRect frame))buildLeft 
             buildTop:(UIView*(^)(CGRect frame))buildTop
{
    if (_isSet) {
        return self;
    }else{
        _isSet=YES;
    }
    
    self.getFrame = getFrame;
    self.buildLeftLabel = buildLeftLabel;
    self.buildTopLabel = buildTopLabel;
    self.buildTag = buildTag;
    self.clickTag = clickTag;
    self.buildLeft = buildLeft;
    self.buildTop = buildTop;
    [self clear];
    [self createTopLabel];
    [self createLeftLabel];
    return self;
}

@end
