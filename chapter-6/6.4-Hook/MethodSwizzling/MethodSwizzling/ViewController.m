//
//  ViewController.m
//  MethodSwizzling
//
//  Created by monkey on 2017/9/10.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ViewController.h"
#import "HookManager.h"

@interface ViewController ()

@end

@implementation ViewController

+(void)load{
//    [HookManager swizzleMethod:@selector(clickMe:) ofClass:[self class] withMethod:@selector(hookClickMe:)];
//    [HookManager swizzleMethod:@selector(clickMe:) ofClass:[self class] withMethod:@selector(newHookClickMe:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickMe:(UIButton *)sender {
    NSLog(@"origin clickme");
}

-(void)hookClickMe:(UIButton*) sender{
    NSLog(@"hook Click Me...");
    [self hookClickMe:sender];
}

-(void)newHookClickMe:(UIButton*) sender{
    NSLog(@"new hook Click Me...");
    [self newHookClickMe:sender];
}

@end
