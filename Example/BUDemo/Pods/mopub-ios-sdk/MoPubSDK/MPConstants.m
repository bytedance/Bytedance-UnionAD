//
//  MPConstants.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPConstants.h"

CGSize const MOPUB_BANNER_SIZE = { .width = 320.0f, .height = 50.0f };
CGSize const MOPUB_MEDIUM_RECT_SIZE = { .width = 300.0f, .height = 250.0f };
CGSize const MOPUB_LEADERBOARD_SIZE = { .width = 728.0f, .height = 90.0f };
CGSize const MOPUB_WIDE_SKYSCRAPER_SIZE = { .width = 160.0f, .height = 600.0f };

@implementation MPConstants

+ (NSTimeInterval)adsExpirationInterval {
    return MOPUB_ADS_EXPIRATION_INTERVAL;
}

@end
