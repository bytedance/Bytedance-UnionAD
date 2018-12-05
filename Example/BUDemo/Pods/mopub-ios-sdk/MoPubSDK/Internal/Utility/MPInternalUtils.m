//
//  MPInternalUtils.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPInternalUtils.h"

@implementation MPInternalUtils

@end

@implementation NSMutableDictionary (MPInternalUtils)

- (void)mp_safeSetObject:(id)obj forKey:(id<NSCopying>)key
{
    if (obj != nil) {
        [self setObject:obj forKey:key];
    }
}

- (void)mp_safeSetObject:(id)obj forKey:(id<NSCopying>)key withDefault:(id)defaultObj
{
    if (obj != nil) {
        [self setObject:obj forKey:key];
    } else {
        [self setObject:defaultObj forKey:key];
    }
}

@end
