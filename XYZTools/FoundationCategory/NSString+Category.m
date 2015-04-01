//
//  NSString+Category.m
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+(NSString*)intString:(NSInteger)number{
    return [NSString stringWithFormat:@"%d",number];
}
+(NSString*)floatString:(CGFloat)number{
    return [NSString stringWithFormat:@"%02f",number];
}






-(NSString*)addIntNum:(NSInteger)number{
    NSString* num = [NSString intString:[self integerValue]+number];
    return num;
}
-(NSString*)addFloatNum:(CGFloat)number{
    NSString* num = [NSString floatString:[self floatValue]+number];
    return num;
}
-(NSString*)addStringIntNum:(NSString*)number{
    NSString* num = [NSString intString:[self integerValue]+[number integerValue]];
    return num;
}
-(NSString*)addStringFloatNum:(NSString*)number{
    NSString* num = [NSString floatString:[self floatValue]+[number floatValue]];
    return num;
}







- (BOOL) isBlank{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
- (NSString *)valideStr{
    if ([self isBlank]) {
        return @"";
    }else{
        return self;
    }
}



-(CGFloat)wideWithFont:(int)font{
    return [self sizeWithFont:[UIFont systemFontOfSize:font]].width+0.5;
}
-(CGFloat)heightWithWidth:(CGFloat)width Font:(int)font{
    return [self sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width, MAXFLOAT)].height+0.5;
}
-(CGFloat)xyzHeightWithWidth:(CGFloat)width Font:(int)font ParagraphStyle:(NSMutableParagraphStyle*(^)(NSMutableParagraphStyle*))paragraph{
    
    NSMutableParagraphStyle *paragraphStyle = paragraph([[ NSMutableParagraphStyle alloc] init]);

    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:self attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSViewSizeDocumentAttribute:[NSValue valueWithCGSize:CGSizeMake(width, MAXFLOAT)]}];
    
    return [attrStr size].height+0.5;
}
@end
