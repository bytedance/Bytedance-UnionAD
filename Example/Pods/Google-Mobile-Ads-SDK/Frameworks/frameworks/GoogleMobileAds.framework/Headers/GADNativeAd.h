//
//  GADNativeAd.h
//  Google Mobile Ads SDK
//
//  Copyright 2015 Google Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <GoogleMobileAds/GoogleMobileAdsDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GADNativeAdDelegate;

/// Native ad base class. All native ad types are subclasses of this class.
@interface GADNativeAd : NSObject

/// Optional delegate to receive state change notifications.
@property(nonatomic, weak, nullable) id<GADNativeAdDelegate> delegate;

/// Root view controller for handling ad actions.
@property(nonatomic, weak, nullable) UIViewController *rootViewController;

/// Dictionary of assets which aren't processed by the receiver.
@property(nonatomic, readonly, copy, nullable) NSDictionary *extraAssets;

/// The ad network class name that fetched the current ad. For both standard and mediated Google
/// AdMob ads, this method returns @"GADMAdapterGoogleAdMobAds". For ads fetched via mediation
/// custom events, this method returns @"GADMAdapterCustomEvents".
@property(nonatomic, readonly, copy, nullable) NSString *adNetworkClassName;

@end

NS_ASSUME_NONNULL_END
