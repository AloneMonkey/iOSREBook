//
//  CustomClass.h
//  ClassDumpApp
//
//  Created by monkey on 2017/7/6.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProtocol.h"

@interface CustomClass : NSObject<CustomProtocol>

@property (nonatomic, strong) NSString* customIvar;

-(void)classDoSomething;

@end
