//
//  ViewController.m
//  DemoApp
//
//  Created by monkey on 2017/8/21.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIButton * btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"bgView address: %p", _bgView);
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_btn setBackgroundColor:[UIColor redColor]];
    [_btn addTarget:self action:@selector(onPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    NSLog(@"_btn address: %p", _btn);
}

-(void)onPress{
    NSLog(@"ViewController onPress!!!");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
