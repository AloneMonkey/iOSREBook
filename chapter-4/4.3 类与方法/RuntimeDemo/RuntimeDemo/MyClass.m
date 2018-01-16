//
//  MyClass.m
//  ClassDemo
//
//  Created by AloneMonkey on 2017/8/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "MyClass.h"
@interface MyClass ()
{
    NSString * _property;
}
@end

@implementation MyClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _property = @"AloneMonkey";
    }
    return self;
}

- (void)myMethod{
    NSLog(@"my method");
}

+ (void)classMethod{
    NSLog(@"class method");
}

@end
