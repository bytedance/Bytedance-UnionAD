//
//  MPBLogLevel.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

/**
 SDK logging level.
 @remark Lower values equate to more detailed logs.
 */
typedef NS_ENUM(NSUInteger, MPBLogLevel) {
    MPBLogLevelDebug = 20,
    MPBLogLevelInfo  = 30,
    MPBLogLevelNone  = 70
};
