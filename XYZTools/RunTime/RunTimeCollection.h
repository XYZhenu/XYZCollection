//
//  RunTimeCollection.h
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunTimeCollection : NSObject
-(void)getcFunc:(NSInteger)num;
+(void)ToCFunc;



-(void)Invocation:(NSString*)str :(NSInteger)num;




+(void)method;



+(void)exchangeMethod;
@end
