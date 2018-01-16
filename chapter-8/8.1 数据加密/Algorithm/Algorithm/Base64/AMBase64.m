//
//  AMBase64.m
//  Algorithm
//
//  Created by AloneMonkey on 2017/9/21.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "AMBase64.h"

@implementation NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string{
    if (![string length]) return nil;
    
    NSData *decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [decoded length] ? decoded: nil;
}

-(NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
    switch (wrapWidth)
    {
        case 64:
        {
            return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        }
        case 76:
        {
            return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
        }
        default:
        {
            encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)base64EncodedString{
    return [self base64EncodedStringWithWrapWidth:0];
}

@end

@implementation NSString (Base64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data){
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString{
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData{
    return [NSData dataWithBase64EncodedString:self];
}

@end
