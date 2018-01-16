//
//  StaticLib.m
//  StaticLib
//
//  Created by AloneMonkey on 2017/9/29.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "StaticLib.h"

@implementation StaticLib

-(void)myMethod:(NSInteger)numberOne number:(NSInteger)numberTwo{
    NSString* result = @"I'm AloneMonkey";
    if(numberOne > numberTwo){
        NSLog(@"%@", result);
    }else{
        NSLog(@"MonkeyDev!!!");
    }
}

@end
