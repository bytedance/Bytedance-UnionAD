//
//  MPLogLevel.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

/**
 * SDK logging level.
 * @remark Lower values equate to more detailed logs.
 */
typedef enum {
    MPLogLevelAll   = 0,
    MPLogLevelTrace = 10,
    MPLogLevelDebug = 20,
    MPLogLevelInfo  = 30,
    MPLogLevelWarn  = 40,
    MPLogLevelError = 50,
    MPLogLevelFatal = 60,
    MPLogLevelOff   = 70
} MPLogLevel;
