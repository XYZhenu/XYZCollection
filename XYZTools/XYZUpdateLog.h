//
//  XYZUpdateLog.h
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#ifndef XYZCollection_XYZUpdateLog_h
#define XYZCollection_XYZUpdateLog_h

/**
 *  
 cd /Users/xieyan/Desktop/unused/staticLib/XYZToolBuild 
 lipo -extract armv7 -output libstatic_armv7.a libXYZStaticLib.a
 lipo -extract armv7s -output libstatic_armv7s.a libXYZStaticLib.a
 lipo -extract arm64 -output libstatic_arm64.a libXYZStaticLib.a

 
 
 
 lipo libstatic_arm64.a -thin arm64 -output libThined_arm64.a
 lipo libstatic_armv7s.a -thin armv7s -output libThined_armv7s.a
 lipo libstatic_armv7.a -thin armv7 -output libThined_armv7.a

 
ar -x libThined_arm64.a
ar -x libThined_armv7.a
ar -x libThined_armv7s.a
 
 
 
 
 extract
 
 localhost:teststatic xieyan$ lipo -extract armv7 -output libstaticarmv7.a libstaticlib.a
 localhost:teststatic xieyan$ lipo -extract armv7s -output libstaticarmv7s.a libstaticlib.a
 localhost:teststatic xieyan$ lipo -extract arm64 -output libstaticarm64.a libstaticlib.a
 
 
 thin
 
 localhost:teststatic xieyan$ lipo libstaticarm64.a -thin arm64 -output libstati_arm64.a
 localhost:teststatic xieyan$ lipo libstaticarmv7.a -thin armv7 -output libstati_armv7.a
 localhost:teststatic xieyan$ lipo libstaticarmv7s.a -thin armv7s -output libstati_armv7s.a
 
 -o
 localhost:teststatic xieyan$ ar -x libstati_arm64.a
 localhost:teststatic xieyan$ ar -x libstati_armv7.a
 localhost:teststatic xieyan$ ar -x libstati_armv7s.a
 
 
 fat
 
 localhost:teststatic xieyan$ libtool -static -o ../libfinalarmv7.a *.o
 
 final
 
 localhost:thined_fat副本 xieyan$ lipo -create -output libWeChatSDK.a *.a
 */




/**
 *  3、ARC中的内存泄露
 
 使用了ARC也并不意味着我们的工程里面不会出现内存泄露了。在ARC机制下，最常见导致内存泄露的是循环强引用。容易出现的场合有：
 
 ①Outlet类型指针
 
 Outlet类型的指针变量应该用weak属性来声明
 ②委托
 
 一定要将delegate的属性设为weak，原因我就不解释了，实在不明白，请猛击这里
 ③block
 
 下面这段代码，在MRC条件下是没有问题的：
 
 [objc] view plaincopy
 MyViewController * __block myController = [[MyViewController alloc] init…];  
 // ...  
 myController.completionHandler =  ^(NSInteger result) {  
 [myController dismissViewControllerAnimated:YES completion:nil];  
 };  
 但是在ARC条件下，就回内存泄露，导致myController指向的对象无法释放。
 原因是，__block id x声明的变量x用于block中时，MRC条件下是不会增加x的引用计数，但是在ARC条件下，会使x得引用计数加一，请各位务必注意！！！！！！！！！！！！
 
 上述问题代码有以下几种解决方案：
 
 方案一：
 
 [objc] view plaincopy
 MyViewController * __block myController = [[MyViewController alloc] init…];  
 // ...  
 myController.completionHandler =  ^(NSInteger result) {  
 [myController dismissViewControllerAnimated:YES completion:nil];  
 myController = nil;  
 };  
 最简单的解决办法，在block中使用完myController时，是它指向nil，没有strong类型的指针指向myController指向的对象时，该对象就回被释放掉。
 方案二：
 
 [objc] view plaincopy
 MyViewController *myController = [[MyViewController alloc] init…];  
 // ...  
 MyViewController * __weak weakMyViewController = myController;  
 myController.completionHandler =  ^(NSInteger result) {  
 [weakMyViewController dismissViewControllerAnimated:YES completion:nil];  
 };  
 该方案使用了一个临时的__weak类型的指针weakMyViewController，在block中使用该指针不会导致引用计数加一，但却存在隐患，当该对象在外部被释放时，block里面执行的操作就无效了。下面的方案三可以解决这个问题。
 方案三：
 
 [objc] view plaincopy
 MyViewController *myController = [[MyViewController alloc] init…];  
 // ...  
 MyViewController * __weak weakMyController = myController;  
 myController.completionHandler =  ^(NSInteger result) {  
 MyViewController *strongMyController = weakMyController;  
 if (strongMyController) {  
 // ...  
 [strongMyController dismissViewControllerAnimated:YES completion:nil];  
 // ...  
 }  
 else {  
 // Probably nothing...  
 }  
 };  
 即在block中使用myController对象之前再声明一个临时的strong类型的指针，指向weak类型的指针，这时strongMyController指针就变成了有效的强引用，其指向的对象就能保证不被释放掉。
 ④定时器
 
 定时器也是非常容易产生内存泄露的地方。比如下面的代码：
 
 [objc] view plaincopy
 @implementation AnimatedView  
 {  
 ?NSTimer *timer;  
 ?}  
 
 - (id)initWithCoder:(NSCoder *)aDecoder  
 {  
 ?  
 ?  if ((self = [super initWithCoder:aDecoder])){  
 timer = [NSTimer scheduledTimerWithT    imeInterval:0.1  
 target:self  
 selector:@selector(handleTimer:)  
 userInfo:nil  
 repeats:YES];  
 }  
 return self;  
 }  
 - (void)dealloc  
 {   
 [timer invalidate];  
 }  
 - (void)handleTimer:(NSTimer*)timer  
 {  
 //do something  
 }  
 乍一看这段代码没啥问题，但是运行起来才发现dealloc方法是不会被调用的，self有一个timer的强引用，timer又有一个self的强引用，典型的循环引用！
 
 解决方法是将timer的属性设置为__weak。
 4、@autoreleasepool和NSAutoreleasePool
 
 ARC中是不支持使用NSAutoreleasePool的，但是可以使用@autoreleasepool代替。@autoreleasepool既可以用在ARC环境中，也可以用在非ARC环境中，而且效率要比前者高，苹果官网中是这样描述的：
 
 [objc] view plaincopy
 ARC provides @autoreleasepool blocks instead. These have an advantage of being more efficient than NSAutoreleasePool.  
 5、还需要声明@property接口吗
 
 在 ARC 之前,开发者经常会在.m 实现文件中使用 class extension 来定义 private property,如下:
 这样做主要是简化实例对象的手动内存管理,让 property 的 setter 方法自 动管理原来对象的释放,以及新对象的 retain。但是有了 ARC,这样的代码就不 再需要了。一般来说,仅仅为了简化内存管理,是不再需要使用 property 的, 虽然你仍然可以这样做,但直接使用实例变量是更好的选择。只有那些属于 public 接口的实例变量,才应该定义为 property。
 
 6、使用ARC需要遵守的新规则
 
 ①不要在dealloc方法中调用[super dealloc];
 
 ②不能使用 retain/release/retainCount/autorelease
 
 ③不能使用 NSAllocateObject/NSDeallocateObject
 
 ④不能使用 NSZone
 
 ⑤Objective-C 对象不能作为C语言结构体（struct/union）的成员
 */
#endif
