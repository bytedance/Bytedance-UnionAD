//
//  MPMoPubConfiguration.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPMoPubConfiguration.h"

@implementation MPMoPubConfiguration

- (instancetype)initWithAdUnitIdForAppInitialization:(NSString * _Nonnull)adUnitId {
    if (self = [super init]) {
        _adUnitIdForAppInitialization = adUnitId;
        _advancedBidders = nil;
        _globalMediationSettings = nil;
        _mediatedNetworks = nil;
    }

    return self;
}

@end
