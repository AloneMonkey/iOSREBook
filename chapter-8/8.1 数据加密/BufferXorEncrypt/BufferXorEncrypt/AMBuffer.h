//
//  AMBuffer.h
//  BufferXorEncrypt
//
//  Created by monkey on 2017/9/24.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMBuffer : NSObject

+(AMBuffer*)defaultForAPI;

-(void)setInt32:(int)int32;

-(void)setNSString:(NSString *)str;

-(void)setLengthWithFirst;

-(const char*)getBody;

-(unsigned long)getLength;

@end
