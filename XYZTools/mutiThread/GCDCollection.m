//
//  GCDCollection.m
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "GCDCollection.h"

@implementation GCDCollection
+(void)GCDAsync{
    /**
     *   - DISPATCH_QUEUE_PRIORITY_HIGH:       
     - DISPATCH_QUEUE_PRIORITY_DEFAULT:    
     - DISPATCH_QUEUE_PRIORITY_LOW:        
     - DISPATCH_QUEUE_PRIORITY_BACKGROUND: 
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}
+(void)GCDQueue{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);//并发队列
    
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();//串行队列
    
    
    /**
     *   DISPATCH_QUEUE_SERIAL, DISPATCH_QUEUE_CONCURRENT, or the result of a call to
     * the function dispatch_queue_attr_make_with_qos_class().
     */
    dispatch_queue_t aQueue = dispatch_queue_create("aQueue", DISPATCH_QUEUE_CONCURRENT);
    
}
+(void)GCDGroup{
    dispatch_queue_t queue = dispatch_queue_create("myGroupQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
    });
    
    dispatch_group_notify(group, queue, ^{
        
        /**
         *  全部完成后调用
         */
    });
}

+(void)GCDBarrier{
    dispatch_queue_t queue = dispatch_queue_create("myGroupQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
    });
    
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
    });
    
    
    dispatch_barrier_async(queue, ^{
        /**
         *  等上面所有内容都运行完才会运行
         */
    });
    
    //等barrier运行完才运行
    dispatch_async(queue, ^{  
        [NSThread sleepForTimeInterval:1];  
        NSLog(@"dispatch_async3");  
    });  
}
+(void)GCDApply{
    dispatch_queue_t queue = dispatch_queue_create("myGroupQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(5, queue, ^(size_t index) {
        /**
         *  运行5次
         */
    });
}
+(void)GCDOnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //整个程序中只执行一次
    });
}
+(void)GCDAfter{
    double delay = 2.0;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay*NSEC_PER_SEC);
    dispatch_queue_t queue = dispatch_queue_create("myGroupQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_after(time, queue, ^{
        
        /**
         *  10sec后添加进队列
         */
    });
}
+(void)GCDTarget{
    dispatch_queue_t queue = dispatch_queue_create("myGroupQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    
    dispatch_set_target_queue(queue, mainQueue);
    
}
+(void)GCDSuspendResume{
    dispatch_queue_t queue = dispatch_queue_create("myGroupQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_suspend(queue);//已经在运行的任务继续执行，没运行的暂停。
    
    
    dispatch_resume(queue);
}
+(void)GCDSemaphore{
    dispatch_queue_t queue = dispatch_queue_create("myGroupQueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    for (int i=0; i<9; i++) {//开10条线程，同时最多只有2条在运行
        dispatch_async(queue, ^{
                        
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
            
            dispatch_after(time, queue, ^{
                
                
                
                dispatch_semaphore_signal(semaphore);//运行完发信号
            });
        });
    }
    
}
@end
