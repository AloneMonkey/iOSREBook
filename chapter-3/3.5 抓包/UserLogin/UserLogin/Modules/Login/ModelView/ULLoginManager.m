//
//  ULLoginManager.m
//  UserLogin
//
//  Created by monkey on 2017/7/22.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "ULLoginManager.h"
#import "SocketService.h"

@implementation ULLoginManager

+ (instancetype)sharedManager {
    static ULLoginManager *loginManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginManager = [[ULLoginManager alloc] init];
    });
    return loginManager;
}

-(void)loginWithUserName:(NSString *)username passWord:(NSString *)password successBlock:(void (^)(void))successBlock failedBlock:(void (^)(void))failedBlock{
    SocketService* service = [SocketService sharedInstance];
    service.socketHost = SOCKET_IP;
    service.socketPort = SOCKET_PORT;
    
    service.socket.userData = @(SocketOfflineByUser);
    [service cutOffSocket];
    
    service.socket.userData = @(SocketOfflineByServer);
    [service socketConnectHost];
    
    [service sendMessage:[[NSString stringWithFormat:@"%@:%@", username, password] dataUsingEncoding:NSUTF8StringEncoding]];
    
    successBlock();
}

-(void)getLoginWithUserName:(NSString *)username passWord:(NSString *)password successBlock:(void (^)(void))successBlock failedBlock:(void (^)(void))failedBlock{
    NSString * URLString = [NSString stringWithFormat:@"%@/?username=%@&password=%@",URL_BASE,username,password];
    
    NSURL * URL = [NSURL URLWithString:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@",[error localizedDescription]);
            failedBlock();
        }else{
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if(responseJSON && [[responseJSON allKeys] containsObject:@"status"] && [responseJSON[@"status"] isEqualToString:@"success"]){
                successBlock();
            }else{
                failedBlock();
            }
        }
    }];
    
    [getDataTask resume];
}

-(void)postLoginWithUserName:(NSString *)username passWord:(NSString *)password successBlock:(void (^)(void))successBlock failedBlock:(void (^)(void))failedBlock{
    NSString * URLString = [NSString stringWithFormat:@"%@",URL_BASE];
    NSString * httpBody = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@",[error localizedDescription]);
            failedBlock();
        }else{
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if(responseJSON && [[responseJSON allKeys] containsObject:@"status"] && [responseJSON[@"status"] isEqualToString:@"success"]){
                successBlock();
            }else{
                failedBlock();
            }
        }
    }];
    
    [postDataTask resume];
}

@end
