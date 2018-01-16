//
//  main.m
//  MachODemo
//
//  Created by monkey on 2017/9/2.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

static __attribute__((constructor))
void my_constructor(){
    printf("hello one!!!\n");
    printf("hello two!!!\n");
    NSLog(@"exec my_constructor before main function");
}

static __attribute__((destructor))
void my_destructor(){
    NSLog(@"exec my_destructor");
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
