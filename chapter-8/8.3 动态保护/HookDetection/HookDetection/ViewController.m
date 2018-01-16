//
//  ViewController.m
//  HookDetection
//
//  Created by AloneMonkey on 2017/9/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginWithUsername:(NSString*) username password:(NSString*) password{
    NSLog(@"username: %@ password: %@", username, password);
}

- (IBAction)Login:(UIButton *)sender {
    [self loginWithUsername:@"admin" password:@"123456"];
}
@end
