//
//  MPRewardedVideoCustomEvent+Caching.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPRewardedVideoCustomEvent+Caching.h"
#import "MPLogging.h"
#import "MPMediationManager.h"

@implementation MPRewardedVideoCustomEvent (Caching)

- (void)setCachedInitializationParameters:(NSDictionary * _Nullable)params {
    [MPMediationManager.sharedManager setCachedInitializationParameters:params forNetwork:[self class]];
}

- (NSDictionary * _Nullable)cachedInitializationParameters {
    return [MPMediationManager.sharedManager cachedInitializationParametersForNetwork:[self class]];
}

@end
