//
//  HookManager.h
//  MethodSwizzling
//
//  Created by monkey on 2017/9/10.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HookManager : NSObject

+ (void)swizzleMethod:(SEL)originalSelector
              ofClass:(Class)class
           withMethod:(SEL)swizzledSelector;

@end
