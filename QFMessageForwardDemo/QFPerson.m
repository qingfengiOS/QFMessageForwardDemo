//
//  Person.m
//  MessageForward
//
//  Created by iosyf-02 on 2018/3/20.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "QFPerson.h"
#import "QFOtherPerson.h"
#import <objc/message.h>

@implementation QFPerson

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"sel = %@",NSStringFromSelector(sel));
    
//    if (sel == @selector(run)) {//第一步自己添加方法
//        class_addMethod(self, sel, (IMP)newRun, "v@:@:");
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"aSelector = %@",NSStringFromSelector(aSelector));
    return [super forwardingTargetForSelector:aSelector];
//    return [[QFOtherPerson alloc]init];//第二步，前端转发
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {//第三步，签名转发
    

    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"run:age:"]) {//是我们需要转发的run方法
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    } else {
        return [super methodSignatureForSelector:aSelector];
    }
    
}

#pragma mark - Private Method
void newRun(id self,SEL sel, NSString *str) {//自定义方法实现
    NSLog(@"---runok---%@",str);
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {//签名转发
    SEL selector = [anInvocation selector];//目标方法
    
    QFOtherPerson *other = [[QFOtherPerson alloc]init];//转发对象
    
    if ([other respondsToSelector:selector]) {//目标对象能相应此方法
        [anInvocation invokeWithTarget:other];
    } else {
        return [super forwardInvocation:anInvocation];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSString *methodName = NSStringFromSelector(aSelector);
    NSLog(@"方法（%@）,自己有没添加，转发都找不到实现，我也很绝望，但是有这个异常处理程序不会崩溃",methodName);
}

@end
