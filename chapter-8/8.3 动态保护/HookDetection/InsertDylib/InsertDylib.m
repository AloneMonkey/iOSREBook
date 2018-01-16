//
//  InsertDylib.m
//  InsertDylib
//
//  Created by monkey on 2017/9/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaptainHook.h"


CHDeclareClass(ViewController)

CHOptimizedMethod2(self, void, ViewController, loginWithUsername, NSString*, username, password, NSString*, password){
    username = @"myaccount";
    password = @"mypassword";
    CHSuper2(ViewController, loginWithUsername, username, password, password);
}

CHConstructor{
//    CHLoadLateClass(ViewController);
//    CHClassHook2(ViewController, loginWithUsername, password);
}
