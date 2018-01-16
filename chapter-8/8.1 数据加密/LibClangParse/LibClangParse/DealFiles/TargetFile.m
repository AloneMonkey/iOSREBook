//
//  TargetFile.h
//  LibClangParse
//
//  Created by AloneMonkey on 17/9/23.
//  Copyright (c) 2017年 AloneMonkey. All rights reserved.
//

#import "TargetFile.h"

@implementation TargetFile

-(NSString*)method{
    char* cstr = "local char str";
     
    NSString *nsstr = @"local nsstring \n";

    return @"return c string";
}

@end
