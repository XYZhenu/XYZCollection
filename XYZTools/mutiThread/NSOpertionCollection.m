//
//  NSOpertionCollection.m
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "NSOpertionCollection.h"

@implementation NSOpertionCollection
+(void)Invocation{
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation* invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(Invocation) object:nil];
    
    [queue addOperation:invocation];
}
+(void)Block{
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation* block = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
    [block addExecutionBlock:^{
        
    }];
    
    block.executionBlocks;
    
    [queue addOperation:block];
}
+(void)Queue{
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        
    }];
    
    queue.operationCount;
    
    queue.operations;
    
    queue.maxConcurrentOperationCount=2;
        
    
}



@end
