//
//  ViewController.m
//  BufferXorEncrypt
//
//  Created by monkey on 2017/9/24.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ViewController.h"
#import "AMBuffer.h"

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

-(void)sendBuffer{
    NSString* username = @"username";
    NSString* password = @"password";
    
    NSString * URLString = @"http://xxx";
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    
    //自定义格式
    AMBuffer* buffer = [AMBuffer defaultForAPI];
    [buffer setNSString:@"username"];
    [buffer setNSString:username];
    [buffer setNSString:@"password"];
    [buffer setNSString:password];
    [buffer setLengthWithFirst];
    
    NSData* data = [NSData dataWithBytes:[buffer getBody] length:[buffer getLength]];
    
    request.HTTPBody = data;
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            
        }else{
            
        }
    }];
    
    [postDataTask resume];
}

@end
