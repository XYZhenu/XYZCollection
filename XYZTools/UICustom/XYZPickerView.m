//
//  XYZPickerView.m
//  shell
//
//  Created by xieyan on 15/3/26.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZPickerView.h"
@interface XYZPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic)NSInteger componum;
@property(nonatomic,strong)UIPickerView*pickerView;
@property(nonatomic,strong)NSInteger(^rowNum)(NSInteger comIndex);
@property(nonatomic,strong)NSString*(^title)(NSInteger compo,NSInteger row);
@property(nonatomic,strong)void(^callback)(NSInteger compo,NSInteger row,NSArray*data);

@end
@implementation XYZPickerView

-(instancetype)initWithFrame:(CGRect)frame COMnum:(NSInteger)COMnum RowOfComp:(NSInteger(^)(NSInteger comIndex))rowNum title:(NSString*(^)(NSInteger compo,NSInteger row))title selectionCallBack:(void(^)(NSInteger compo,NSInteger row,NSArray*data))callback{
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        self.pickerView.delegate=self;
        self.pickerView.dataSource=self;
        [self addSubview:self.pickerView];
        self.rowNum=rowNum;
        self.title=title;
        self.callback=callback;
        _componum=COMnum;
        self.rowHeight=frame.size.height/5;
    }
    
    
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _componum;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.rowNum(component);
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.widthForCompo) {
        return self.widthForCompo(component);
    }else{
        return self.width/_componum;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.rowHeight;
}

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.title) {
        return self.title(component,row);
    }else{
        return nil;
    }
}
//-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (self.attribuateTitle) {
//        return self.attribuateTitle(component,row);
//    }else{
//        return nil;
//    }
//}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    if (self.customView) {
//        return self.customView(component,row);
//    }else{
//        return nil;
//    }
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.callback) {
        self.callback(component,row,nil);
    }
}
@end
