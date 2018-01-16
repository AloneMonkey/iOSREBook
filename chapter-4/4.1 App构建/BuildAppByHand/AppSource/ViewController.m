//
//  ViewController.m
//  DemoApp
//
//  Created by monkey on 2017/8/21.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray * images = [NSMutableArray new];
    int index = 1;

    do {

        NSString * name = [NSString stringWithFormat:@"image%d.png",index];
        
        UIImage * image = [UIImage imageNamed:name];

        if (image == nil) break;

        [images addObject:image];

        index++;

    } while (YES);
    
    [_imageview setImage:images[0]];

    [_imageview setAnimationImages:images];
    
    [_imageview setAnimationDuration:0.5];

    [_imageview setAnimationRepeatCount:100];
    
    [_imageview startAnimating];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
