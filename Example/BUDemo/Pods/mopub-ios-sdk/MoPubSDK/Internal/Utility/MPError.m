//
//  MPError.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPError.h"

NSString * const kMOPUBErrorDomain = @"com.mopub.iossdk";

@implementation MOPUBError

+ (MOPUBError *)errorWithCode:(MOPUBErrorCode)code {
    return [MOPUBError errorWithCode:code localizedDescription:nil];
}

+ (MOPUBError *)errorWithCode:(MOPUBErrorCode)code localizedDescription:(NSString *)description {
    NSDictionary * userInfo = nil;
    if (description != nil) {
        userInfo = @{ NSLocalizedDescriptionKey: description };
    }

    return [self errorWithDomain:kMOPUBErrorDomain code:code userInfo:userInfo];
}

@end
