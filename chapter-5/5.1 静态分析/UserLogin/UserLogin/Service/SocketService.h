//
//  SocketService.h
//  UserLogin
//
//  Created by AloneMonkey on 2017/10/9.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

enum{
    SocketOfflineByServer,
    SocketOfflineByUser,
};

@interface SocketService : NSObject<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket    *socket;
@property (nonatomic, copy  ) NSString       *socketHost;
@property (nonatomic, assign) long         socketPort;
@property (nonatomic, retain) NSTimer        *connectTimer;

+ (SocketService *)sharedInstance;

- (void)cutOffSocket;

- (void)socketConnectHost;

- (void)sendMessage:(NSData *)data;

@end
