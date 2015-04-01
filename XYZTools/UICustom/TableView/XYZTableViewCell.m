//
//  XYZTableViewCell.m
//  beauty
//
//  Created by xieyan on 15-2-11.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZTableViewCell.h"

@implementation XYZTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self afterInit];
    }
    return self;
}
-(void)afterInit{
    
}
+(CGFloat)cellHeightForContent:(id)content Width:(CGFloat)width{
    return 0;
}
+(CGFloat)cellHeightForDataDic:(NSDictionary*)datadic Width:(CGFloat)width{
    return [self cellHeightForContent:datadic[@"data"] Width:width];
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self processOriginDataDic:dataDic];
}
-(void)processOriginDataDic:(NSDictionary*)dataDic{
    [self processDataFromDataDic:dataDic[@"data"]];
}
-(void)processDataFromDataDic:(id)data{
    
}
@end
