//
//  MPError.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

extern NSString * const kMOPUBErrorDomain;

typedef enum {
    MOPUBErrorUnknown = -1,
    MOPUBErrorNoInventory = 0,
    MOPUBErrorAdUnitWarmingUp = 1,
    MOPUBErrorNetworkTimedOut = 4,
    MOPUBErrorServerError = 8,
    MOPUBErrorAdapterNotFound = 16,
    MOPUBErrorAdapterInvalid = 17,
    MOPUBErrorAdapterHasNoInventory = 18,
    MOPUBErrorUnableToParseJSONAdResponse,
    MOPUBErrorUnexpectedNetworkResponse,
    MOPUBErrorHTTPResponseNot200,
    MOPUBErrorNoNetworkData,
    MOPUBErrorSDKNotInitialized,
    MOPUBErrorAdRequestTimedOut,
    MOPUBErrorNoRenderer,
} MOPUBErrorCode;

@interface MOPUBError : NSError

+ (MOPUBError *)errorWithCode:(MOPUBErrorCode)code;
+ (MOPUBError *)errorWithCode:(MOPUBErrorCode)code localizedDescription:(NSString *)description;

@end
