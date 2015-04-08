//
//  RunTimeCollection.m
//  XYZCollection
//
//  Created by xieyan on 15/4/7.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "RunTimeCollection.h"
#import <objc/runtime.h>

@implementation RunTimeCollection
+(void)ToCFunc{
    
    void (*getcfunc)(id,SEL,NSInteger);
    
    getcfunc = (void(*)(id,SEL,NSInteger))[self methodForSelector:@selector(getcFunc:)];
    RunTimeCollection* object = [[RunTimeCollection alloc] init];
    
    getcfunc(object, @selector(getcFunc:), 10);
    
}
-(void)getcFunc:(NSInteger)num{
    
}
void getcfunc(id obj,SEL selector,NSInteger num){
    
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    //没找到方法先到这里,可以在这里动态添加方法
    
    if(sel == @selector(getcFunc:)){
        class_addMethod([self class],sel,(IMP)getcfunc,"v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
    //如果你没办法在自己的类里面找到替代方法，你就重载这个方法，然后把消息转给其他的Object。
    //不能 return self,不然就死循环了
    if(aSelector == @selector(getcFunc:)){
        
        return [NSNull null];//nil
    }
    return [super forwardingTargetForSelector:aSelector];
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    //NSInvocation 其实就是一条消息的封装。如果你能拿到 NSInvocation，那你就能修改这条消息的 target, selector 和 arguments
    
    //默认情况下 NSObject 对 forwardInvocation 的实现就是简单地执行 -doesNotRecognizeSelector: 这个方法，所以如果你想真正的在最后关头去转发消息你可以重载这个方法
    SEL invSEL = anInvocation.selector;
    
    NSObject* object = [[NSObject alloc] init];
    
    if( [object respondsToSelector:invSEL]) {
        [anInvocation invokeWithTarget:object];
    } else {
        [self doesNotRecognizeSelector:invSEL];
    }
}
-(void)doesNotRecognizeSelector:(SEL)aSelector{
    /**
     *  最后执行这条
     */
    
    
    
}





+(void)method{
    u_int count = 0;
    
    Method* methods = class_copyMethodList([NSObject class], &count);
    
    SEL name = method_getName(methods[0]);
    
    
}


+(void)exchangeMethod{
    Method method1 = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method method2 = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    
    
    method_exchangeImplementations(method1, method2);//交换实现方法
    
}
@end

void showInvocation(){//NSInvocation的使用
    
    RunTimeCollection* object = [[RunTimeCollection alloc] init];
    NSString* str = @"cc";
    NSInteger num = 0;
    
    
    SEL aSelector = @selector(Invocation::);
    NSMethodSignature* sig = [RunTimeCollection instanceMethodSignatureForSelector:aSelector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.target=object;
    invocation.selector=aSelector;
    [invocation setArgument:&str atIndex:2];
    [invocation setArgument:&num atIndex:3];
    [invocation retainArguments];
    
    [invocation invoke];
}

