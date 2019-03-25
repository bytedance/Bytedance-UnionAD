//
//  GADMediationInterstitialAd.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google Inc. All rights reserved.
//

#import <GoogleMobileAds/Mediation/GADMediationAd.h>
#import <GoogleMobileAds/Mediation/GADMediationAdConfiguration.h>
#import <GoogleMobileAds/Mediation/GADMediationAdEventDelegate.h>
#import <UIKit/UIKit.h>

/// Rendered interstitial ad.
@protocol GADMediationInterstitialAd<GADMediationAd>
- (void)presentFromViewController:(nonnull UIViewController *)viewController;
@end

@interface GADMediationInterstitialAdConfiguration : GADMediationAdConfiguration
@end
