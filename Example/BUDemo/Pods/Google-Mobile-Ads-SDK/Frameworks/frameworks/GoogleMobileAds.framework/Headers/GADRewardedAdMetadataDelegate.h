//
//  GADRewardedAdMetadataDelegate.h
//  Google Mobile Ads SDK
//
//  Copyright © 2018 Google Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GoogleMobileAds/GoogleMobileAdsDefines.h>

@class GADRewardedAd;

NS_ASSUME_NONNULL_BEGIN

/// Delegate for receiving metadata change messages from a GADRewardedAd.
@protocol GADRewardedAdMetadataDelegate<NSObject>

@optional

/// Tells the delegate that the rewarded ad's metadata changed. Called when an ad loads, and when a
/// loaded ad's metadata changes.
- (void)rewardedAdMetadataDidChange:(GADRewardedAd *)rewardedAd;

@end

NS_ASSUME_NONNULL_END
