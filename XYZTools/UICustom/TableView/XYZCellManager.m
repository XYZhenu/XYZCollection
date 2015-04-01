//
//  XYZCellManager.m
//  beauty
//
//  Created by xieyan on 15-2-17.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZCellManager.h"
#import "XYZCellModel.h"

#define ADDCELLFORKEY(__CellClass__) [self.cellDic setValue:NSStringFromClass([__CellClass__ class]) forKey:NSStringFromClass([__CellClass__ class])]

#define ADDCELLFORMODEL(__MODEL__,__CELL__) [self.cellDic setObject:NSStringFromClass([__CELL__ class]) forKey:NSStringFromClass([__MODEL__ class])]

@interface XYZCellManager ()
@property(nonatomic,strong)NSMutableDictionary* cellDic;
@end
@implementation XYZCellManager
+(instancetype)Instance{
    static XYZCellManager* manager=nil;
    @synchronized (self) {
        if (manager==nil) {
            manager = [[self alloc] init];
            [manager addPair];
        }
    }
    return manager;
}
-(NSMutableDictionary *)cellDic{
    if (_cellDic==nil) {
        _cellDic=[NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _cellDic;
}
-(NSString*)getCellClassStr:(id)key{
    NSString*classstr=nil;
    if ([key isKindOfClass:[NSDictionary class]]) {
        classstr = key[@"class"];
    }else if([key isKindOfClass:[XYZCellModel class]]){
        classstr = self.cellDic[NSStringFromClass([key class])];
    }else{
        classstr = @"XYZTableViewCell";
    }
    return classstr;
}
+(CGFloat)CellHeightHeight:(NSDictionary*)data Width:(CGFloat)width{
    Class clas = NSClassFromString(data[@"class"]);
    CGFloat height=[clas cellHeightForDataDic:data Width:width];
    
    return height;
}
+(Class)cellManagerCellClassForKey:(id)key{
    return NSClassFromString([[self Instance] getCellClassStr:key]);
}
+(XYZTableViewCell*)cellForKey:(id)key{
    
    NSString* classStr = [[self Instance] getCellClassStr:key];
    Class aclass = NSClassFromString(classStr);
    XYZTableViewCell*cell=nil;
    NSBundle* bund = [NSBundle mainBundle];
    if ([bund pathForResource:classStr ofType:@"nib"]) {
        NSArray* objects = [[NSBundle mainBundle] loadNibNamed:classStr owner:nil options:nil];
        cell=[objects lastObject];
    }else{
        cell = [[aclass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    return cell;
}
-(void)addPair{
    ADDCELLFORMODEL(XYZTableViewCell, XYZCellModel);
    
    
    
    
}
@end
