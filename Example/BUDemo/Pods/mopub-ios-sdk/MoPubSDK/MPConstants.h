//
//  MPConstants.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <UIKit/UIKit.h>

#define MP_DEBUG_MODE               1

#define MP_HAS_NATIVE_PACKAGE       1

#define DEFAULT_PUB_ID              @"agltb3B1Yi1pbmNyDAsSBFNpdGUYkaoMDA"
#define MP_SERVER_VERSION           @"8"
#define MP_REWARDED_API_VERSION     @"1"
#define MP_BUNDLE_IDENTIFIER        @"com.mopub.mopub"
#define MP_SDK_VERSION              @"5.4.1"

// Sizing constants.
extern CGSize const MOPUB_BANNER_SIZE;
extern CGSize const MOPUB_MEDIUM_RECT_SIZE;
extern CGSize const MOPUB_LEADERBOARD_SIZE;
extern CGSize const MOPUB_WIDE_SKYSCRAPER_SIZE;

// Miscellaneous constants.
#define MINIMUM_REFRESH_INTERVAL            10.0
#define DEFAULT_BANNER_REFRESH_INTERVAL     60    // seconds
#define BANNER_TIMEOUT_INTERVAL             10    // seconds
#define INTERSTITIAL_TIMEOUT_INTERVAL       30    // seconds
#define REWARDED_VIDEO_TIMEOUT_INTERVAL     30    // seconds
#define NATIVE_TIMEOUT_INTERVAL             10    // seconds
#define MOPUB_ADS_EXPIRATION_INTERVAL       14400 // 4 hours converted to seconds

// Feature Flags
#define SESSION_TRACKING_ENABLED            1

@interface MPConstants : NSObject

+ (NSTimeInterval)adsExpirationInterval;

@end
