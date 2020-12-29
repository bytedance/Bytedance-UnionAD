//
//  Base64.m
//
//  Version 1.2
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (C) 2012 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/Base64
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an aacknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "BUDBase64.h"


#pragma GCC diagnostic ignored "-Wselector"


#import <Availability.h>
#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif


@implementation NSData (BUBase64)

+ (NSData *)bud_dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    
    NSData *decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [decoded length]? decoded: nil;
}

- (NSString *)bud_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
    switch (wrapWidth) {
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

- (NSString *)bud_base64EncodedString
{
    return [self bud_base64EncodedStringWithWrapWidth:0];
}

@end


@implementation NSString (BUBase64)

+ (NSString *)bud_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData bud_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)bud_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data bud_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)bud_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data bud_base64EncodedString];
}

- (NSString *)bud_base64DecodedString
{
    return [NSString bud_stringWithBase64EncodedString:self];
}

- (NSData *)bud_base64DecodedData
{
    return [NSData bud_dataWithBase64EncodedString:self];
}

@end
