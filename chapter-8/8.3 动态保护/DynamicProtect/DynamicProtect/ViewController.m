//
//  ViewController.m
//  DynamicProtect
//
//  Created by monkey on 2017/9/24.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ViewController.h"
#import "AntiJailbreak.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(isJailbreak()){
        NSLog(@"越狱设备");
    }else{
        NSLog(@"非越狱设备");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
