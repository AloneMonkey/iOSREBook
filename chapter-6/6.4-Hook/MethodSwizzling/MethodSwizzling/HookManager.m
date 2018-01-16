//
//  HookManager.m
//  MethodSwizzling
//
//  Created by monkey on 2017/9/10.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "HookManager.h"
#import <objc/runtime.h>

@implementation HookManager

+ (void)swizzleMethod:(SEL)originalSelector
              ofClass:(Class)class
           withMethod:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
