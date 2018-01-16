//
//  ViewController.m
//  ArmDemo
//
//  Created by monkey on 2017/9/4.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)A:(NSString*) arg0 B:(NSString*) arg1{
    NSLog(@"%@ %@",arg0,arg1);
}

-(void)A:(double) arg0 C:(double) arg1{
    NSLog(@"%f %f",arg0,arg1);
}

-(void)A:(NSString*) arg0 B:(NSString*) arg1 C:(NSString*) arg2 D:(NSString*) arg3 E:(NSString*) arg4 F:(NSString*) arg5 G:(NSString*) arg6 H:(NSString*) arg7 {
    NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@",arg0,arg1,arg2,arg3,arg4,arg5,arg6,arg7);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self A:@"1" B:@"2"];
    [self A:13.14 C:5.20];
    [self A:@"1" B:@"2" C:@"3" D:@"4" E:@"5" F:@"6" G:@"7" H:@"8"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
