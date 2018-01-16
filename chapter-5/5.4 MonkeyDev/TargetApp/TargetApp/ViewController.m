//
//  ViewController.m
//  TargetApp
//
//  Created by AloneMonkey on 2017/8/29.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSString* _password;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _password = @"password";
    // Do any additional setup after loading the view, typically from a nib.
    [ViewController classMethodUsername:@"alonemonkey" password:@"123456"];
    [self instanceMethodUsername:@"alonemonkey" password:@"123456"];
}

+(void)classMethodUsername:(NSString *)uername password:(NSString *)password{
    NSLog(@"orig class method");
}

-(void)instanceMethodUsername:(NSString *)uername password:(NSString *)password{
    NSLog(@"orig instance method");
}

@end
