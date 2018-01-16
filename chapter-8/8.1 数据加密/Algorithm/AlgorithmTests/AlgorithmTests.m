//
//  AlgorithmTests.m
//  AlgorithmTests
//
//  Created by AloneMonkey on 2017/9/21.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AMBase64.h"
#import "AMRSACryptor.h"
#import "NSData+CommonCrypto.h"

@interface AlgorithmTests : XCTestCase

@property (nonatomic, retain) NSData* target;
@property (nonatomic, retain) NSData* target2;

@end

@implementation AlgorithmTests

- (void)setUp {
    [super setUp];
    
    _target = [@"http://www.alonemonkey.com/2016/05/25/aes-and-des/" dataUsingEncoding:NSUTF8StringEncoding];
    _target2 = [@"http://www.alonemonkey.com/2016/04/25/aes-and-des/" dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBase64{
    NSString* string = [_target base64EncodedString];
    NSData* data = [string base64DecodedData];
    XCTAssertTrue([_target isEqual:data]);
}

-(void)testMd5{
    NSData* md5 = [_target MD5Sum];
    NSData* md5_2 = [_target2 MD5Sum];
    NSData* md5_3 = [_target MD5Sum];
    XCTAssertFalse([md5 isEqual:md5_2]);
    XCTAssertTrue([md5 isEqual:md5_3]);
}

-(void)testDES{
    NSString* key = @"alonemonkey";
    NSData* result1 = [_target DESEncryptedDataUsingKey:key error:nil];
    NSData* result2 = [result1 decryptedDESDataUsingKey:key error:nil];
    XCTAssertTrue([_target isEqual:result2]);
}

-(void)testAES{
    NSString* key = @"alonemonkey";
    NSData* result1 = [_target AES256EncryptedDataUsingKey:key error:nil];
    NSData* result2 = [result1 decryptedAES256DataUsingKey:key error:nil];
    XCTAssertTrue([_target isEqual:result2]);
}

/*
 *   .p12是私钥  .der是公钥，终端命令生成步骤如下：
 *   创建私钥: openssl genrsa -out private.pem 1024
 *   生成证书请求: openssl req -new -key private.pem -out rsacert.csr
 *   自签名: openssl x509 -req -days 3650 -in rsacert.csr -signkey private.pem -out rsacert.crt
 *   解成.der公钥: openssl x509 -outform der -in rsacert.crt -out rsacert.der
 *   生成.p12二进制私钥文件: openssl pkcs12 -export -out p.p12 -inkey private.pem -in rsacert.crt
 */
-(void)testRSA{
    NSString *pubKeyPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"rsacert" ofType:@"der"];
    NSString *priKeyPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"p" ofType:@"p12"];
    NSString *password = @"123456";
    NSString *textData = @"Data";
    
    AMRSACryptor *cryptor = [[AMRSACryptor alloc] init];
    
    [cryptor loadPublicKey:pubKeyPath];
    
    NSData *encData = [cryptor RSAEncryptData:[textData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [cryptor loadPrivateKey:priKeyPath password:password];
    NSData *decData = [cryptor RSADecryptData:encData];
    NSString *decText = [[NSString alloc] initWithData:decData encoding:NSUTF8StringEncoding];
    
    XCTAssertTrue([textData isEqual:decText]);
}

@end
