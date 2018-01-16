//
//  SocketService.m
//  UserLogin
//
//  Created by AloneMonkey on 2017/10/9.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "SocketService.h"

@implementation SocketService

+(SocketService *) sharedInstance{
    static SocketService *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[self alloc] init];
    });
    
    return sharedInstace;
}

-(void)socketConnectHost{
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    NSError *error = nil;
    
    [self.socket connectToHost:self.socketHost onPort:self.socketPort withTimeout:3 error:&error];
}

#pragma mark  - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
   
}

-(void)cutOffSocket{
    self.socket.userData = @(SocketOfflineByUser);
    
    [self.connectTimer invalidate];
    
    [self.socket disconnect];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    if (sock.userData == SocketOfflineByServer) {
        [self socketConnectHost];
    }else if ((int)sock.userData == SocketOfflineByUser) {
        return;
    }
}

- (void)sendMessage:(NSData *)data {
    [self.socket writeData:data withTimeout:3 tag:10];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [_socket readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"收到数据：%@",result);
    
    [self.socket readDataWithTimeout:30 buffer:nil bufferOffset:0 maxLength:1024 tag:0];
    _socket.userData = @(SocketOfflineByUser);
    [self cutOffSocket];
}

@end
