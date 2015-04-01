//
//  NSString+Category.h
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
+(NSString*)intString:(NSInteger)number;
+(NSString*)floatString:(CGFloat)number;

-(NSString*)addIntNum:(NSInteger)number;
-(NSString*)addFloatNum:(CGFloat)number;
-(NSString*)addStringIntNum:(NSString*)number;
-(NSString*)addStringFloatNum:(NSString*)number;



-(BOOL) isBlank;
-(NSString *)valideStr;



-(CGFloat)wideWithFont:(int)font;
-(CGFloat)heightWithWidth:(CGFloat)width Font:(int)font;
-(CGFloat)xyzHeightWithWidth:(CGFloat)width Font:(int)font ParagraphStyle:(NSMutableParagraphStyle*(^)(NSMutableParagraphStyle*))paragraph;
@end
