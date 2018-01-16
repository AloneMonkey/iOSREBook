//
//  CustomClass.m
//  MachODemo
//
//  Created by monkey on 2017/9/2.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "CustomClass.h"

@implementation CustomClass

+(void)load{
    NSLog(@"CustomClass load!!!");
}

-(void)customMethod{
    char * cStr = "I'm c string";
    NSString* ocStr = @"I'm OC String";
    NSLog(@"%s %@",cStr,ocStr);
}

@end
