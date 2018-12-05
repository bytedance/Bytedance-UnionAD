//
//  MPRewardedVideoReward.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPRewardedVideoReward.h"

NSString *const kMPRewardedVideoRewardCurrencyTypeUnspecified = @"MPMoPubRewardedVideoRewardCurrencyTypeUnspecified";
NSInteger const kMPRewardedVideoRewardCurrencyAmountUnspecified = 0;

@implementation MPRewardedVideoReward

- (instancetype)initWithCurrencyType:(NSString *)currencyType amount:(NSNumber *)amount
{
    if (self = [super init]) {
        _currencyType = currencyType;
        _amount = amount;
    }

    return self;
}

- (instancetype)initWithCurrencyAmount:(NSNumber *)amount
{
    return [self initWithCurrencyType:kMPRewardedVideoRewardCurrencyTypeUnspecified amount:amount];
}

@end
