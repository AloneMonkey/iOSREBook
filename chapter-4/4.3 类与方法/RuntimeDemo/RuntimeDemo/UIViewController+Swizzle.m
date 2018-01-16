//
//  UIViewController+Swizzle.m
//  RuntimeDemo
//
//  Created by AloneMonkey on 2017/8/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+Swizzle.h"

@implementation UIViewController(Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(ms_viewWillAppear:);
        
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
    });
}

#pragma mark - Method Swizzling

- (void)ms_viewWillAppear:(BOOL)animated {
    [self ms_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}

@end
