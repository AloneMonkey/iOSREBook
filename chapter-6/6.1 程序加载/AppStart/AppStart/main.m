//
//  main.m
//  AppStart
//
//  Created by monkey on 2017/8/29.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

__attribute__((constructor(102))) static void entry(){
    NSLog(@"entry");
}

__attribute__((constructor(101))) static void entry2(){
    NSLog(@"entry2");
}
