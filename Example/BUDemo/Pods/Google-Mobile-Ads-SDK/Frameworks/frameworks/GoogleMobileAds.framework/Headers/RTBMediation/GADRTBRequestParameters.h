//
//  GADRTBRequestParameters.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google Inc. All rights reserved.
//

#import <GoogleMobileAds/GADAdNetworkExtras.h>
#import <GoogleMobileAds/GADAdSize.h>
#import <GoogleMobileAds/Mediation/GADMediationAdConfiguration.h>
#import <GoogleMobileAds/Mediation/GADMediationServerConfiguration.h>

/// Request parameters provided by the publisher and Google Mobile Ads SDK.
@interface GADRTBRequestParameters : NSObject

/// Mediation configuration set by the publisher on the AdMob UI.
@property(nonatomic, readonly, nonnull) GADMediationCredentials *credentials;

/// Extras the publisher registered with -[GADRequest registerAdNetworkExtras:].
@property(nonatomic, readonly, nullable) id<GADAdNetworkExtras> extras;

#pragma mark - Banner parameters

/// Requested banner ad size. The ad size is kGADAdSizeInvalid for non-banner requests. Use
/// credentials.format to determine the request format.
@property(nonatomic, readonly) GADAdSize adSize;

@end
