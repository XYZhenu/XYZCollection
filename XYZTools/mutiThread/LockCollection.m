//
//  LockCollection.m
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "LockCollection.h"

@implementation LockCollection
+(void)NSLock{
    NSLock*lock = [[NSLock alloc] init];
    
    [lock lock];
    
    [lock lockBeforeDate:[NSDate date]];
    
    [lock unlock];
}

+(void)Synchronized{
    
    @synchronized(self){
        
        
        
    }
}
+(void)Atomic{
//    @property(atomic,strong)NSString* name;
//    原子操作即可
}

@end
