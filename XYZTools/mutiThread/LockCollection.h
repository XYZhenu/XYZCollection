//
//  LockCollection.h
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LockCollection : NSObject
+(void)NSLock;
+(void)Synchronized;
+(void)Atomic;
@end
