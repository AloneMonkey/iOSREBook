//
//  Captain.mm
//  Captain
//
//  Created by monkey on 2017/8/28.
//  Copyright (c) 2017年 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"

@interface ViewController : NSObject

@property (nonatomic, retain) NSString* newProperty;

- (void)addMethod:(NSString*) output;

@end

CHDeclareClass(ViewController)

CHPropertyRetainNonatomic(ViewController, NSString*, newProperty, setNewProperty);

CHDeclareMethod1(void, ViewController, addMethod, NSString*, output){
    NSLog(@"add method %@", output);
}

CHOptimizedMethod2(self, void, ViewController, instanceMethodUsername, NSString*, username, password, NSString*, password){
    
    NSString* ppassword = CHIvar(self,_password,__strong NSString*);
    
    CHDebugLog(@"private password: %@", ppassword);
    
    ppassword = [self valueForKey:@"_password"];
    
    CHDebugLog(@"kvc password: %@", ppassword);
    
    self.newProperty = @"set new property";
    
    CHDebugLog(@"new property is:%@", self.newProperty);
    
    [self addMethod:@"output"];
    
    CHDebugLog(@"hook instance method username: %@, password: %@", username, password);
    
    CHSuper2(ViewController, instanceMethodUsername, username, password, password);
}

CHOptimizedClassMethod2(self, void, ViewController, classMethodUsername, NSString*, username, password, NSString*, password){
    CHDebugLog(@"hook class method username: %@, password: %@", username, password);
    CHSuper2(ViewController, classMethodUsername, username, password, password);
}

CHConstructor{
    CHLoadLateClass(ViewController);
    CHHook2(ViewController, instanceMethodUsername, password);
    CHHook2(ViewController, classMethodUsername, password);
    
    CHHook0(ViewController, newProperty);
    CHHook1(ViewController, setNewProperty);
}
