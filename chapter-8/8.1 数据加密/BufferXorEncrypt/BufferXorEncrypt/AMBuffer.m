//
//  AMBuffer.m
//  BufferXorEncrypt
//
//  Created by monkey on 2017/9/24.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "AMBuffer.h"

@interface AMBuffer ()

@end

@implementation AMBuffer{
    char* _body;
    unsigned long _bufferLen;           //buffer总长度
    unsigned long _len;                 //当前数据长度
    unsigned long _wseek;               //写指针偏移
    unsigned long _rseek;               //读指针偏移
}

+(AMBuffer*)defaultForAPI{
    AMBuffer* buffer = [[[self class] alloc] init];
    if(buffer){
        [buffer setInt32:0];
    }
    return buffer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bufferLen = 2048;
        _body = calloc(2048, 1);
    }
    return self;
}

-(void)addLen:(unsigned long)len{
    _len += len;
    while(_len >= _bufferLen){
        _bufferLen += 2048;
        _body = realloc(_body, _bufferLen);
    }
}

#pragma mark - Setter

-(void)setInt32:(int)int32{
    [self write:(const char *)&int32 len:4];
}

-(void)setNSString:(NSString *)str{
    if(str && str.length){
        [self write:[str UTF8String] len:strlen([str UTF8String])+1];
    }
}

-(void)setLengthWithFirst{
    [self setLengthWithSeek:0];
}

-(void)setLengthWithSeek:(unsigned long)seek{
    char* len = (char*)&_len;
    for (int i = 0; i < 4; i++) {
        _body[seek+i] = len[i];
    }
}

#pragma mark - Getter

-(const char *)getBody{
    return _body;
}

-(unsigned long)getLength{
    return _len;
}

#pragma mark - read & write

//除前面4个字节是长度，其它字节 xor 0x08
-(void)write:(const char *)write len:(unsigned long)len{
    [self addLen:len];
    while (len) {
        _body[_wseek] = *write ^ 0x08;
        _wseek++;
        write++;
        len--;
    }
}

-(void)read:(char *)read len:(unsigned long)len{
    if(_rseek + len > _len){
        NSLog(@"read len over");
    }else{
        while (len) {
            *read = _body[_rseek];
            _rseek++;
            read++;
            len--;
        }
    }
}

@end
