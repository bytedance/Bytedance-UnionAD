//
//  NSString+MPAdditions.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "NSString+MPAdditions.h"

@implementation NSString (MPAdditions)

- (NSString *)mp_URLEncodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]<>",
                                                                                             kCFStringEncodingUTF8));
    return result;
}

- (NSNumber *)safeIntegerValue {
    // Reusable number formatter since reallocating this is expensive.
    static NSNumberFormatter * formatter = nil;
    if (formatter == nil) {
        formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterNoStyle;
    }

    return [formatter numberFromString:self];
}

@end
