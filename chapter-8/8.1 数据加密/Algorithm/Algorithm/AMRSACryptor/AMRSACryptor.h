//
//  AMRSACryptor.h
//  Algorithm
//
//  Created by monkey on 2017/9/23.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMRSACryptor : NSObject

- (void)loadPublicKey:(NSString *)filePath;
- (void)loadPrivateKey:(NSString *)filePath password:(NSString *)password;

- (NSData *)RSAEncryptData:(NSData *)data;
- (NSData *)RSADecryptData:(NSData *)data;

@end
