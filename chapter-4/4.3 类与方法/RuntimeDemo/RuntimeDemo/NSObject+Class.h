//
//  NSObject+Class.h
//  ClassDemo
//
//  Created by AloneMonkey on 2017/8/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Class)

+ (void)PrintInternalClass;

+ (NSArray*)PrintVariables;

+ (NSArray*)PrintMethods;

+ (void)PrintClassChain:(Class) aClass;

@end
