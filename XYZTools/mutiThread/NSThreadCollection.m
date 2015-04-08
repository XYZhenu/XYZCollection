//
//  NSThreadCollection.m
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "NSThreadCollection.h"

@implementation NSThreadCollection
+(void)ThreadCreate{
    
    [NSThread detachNewThreadSelector:@selector(doSomething:) toTarget:self withObject:nil];  
    
    
    
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething:) object:nil];  
    [myThread start]; 
    
    [myThread cancel];
    
    [myThread isMainThread];
    
    [NSThread isMainThread];
    
    
    
}
+(void)ThreadObjectPerform{
    NSObject* object;
    
    
    [object performSelector:@selector(doSomething:) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    
    [object performSelectorOnMainThread:@selector(doSomething:) withObject:nil waitUntilDone:YES];
    
    [object performSelectorInBackground:@selector(doSomething:) withObject:nil];
}


@end
