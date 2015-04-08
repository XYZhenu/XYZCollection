//
//  GCDCollection.h
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDCollection : NSObject
+(void)GCDAsync;
+(void)GCDQueue;
+(void)GCDGroup;
+(void)GCDBarrier;
+(void)GCDApply;
+(void)GCDOnce;
+(void)GCDAfter;
+(void)GCDTarget;
+(void)GCDSuspendResume;
+(void)GCDSemaphore;
@end
