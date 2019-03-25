//
//  GADRewardedAd.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADAdMetadataKeys.h>
#import <GoogleMobileAds/GADAdReward.h>
#import <GoogleMobileAds/GADRequest.h>
#import <GoogleMobileAds/GADRequestError.h>
#import <GoogleMobileAds/GADServerSideVerificationOptions.h>
#import <GoogleMobileAds/GoogleMobileAdsDefines.h>
#import <GoogleMobileAds/GADRewardedAdDelegate.h>
#import <GoogleMobileAds/GADRewardedAdMetadataDelegate.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// A block to be executed when the ad request operation completes. If the load failed, the error
/// object is non-null and provides failure information. On success, |error| is nil.
typedef void (^GADRewardedAdLoadCompletionHandler)(GADRequestError *_Nullable error);

/// The GADRewardedAd class is used for requesting and presenting a rewarded ad.
@interface GADRewardedAd : NSObject

/// Initializes a rewarded ad with the provided ad unit ID. Create ad unit IDs using the AdMob
/// website for each unique ad placement in your app. Unique ad units improve targeting and
/// statistics.
///
/// Example AdMob ad unit ID: @"ca-app-pub-3940256099942544/1712485313"
- (instancetype)initWithAdUnitID:(NSString *)adUnitID;

/// Requests an rewarded ad and calls the provided completion handler when the request finishes.
- (void)loadRequest:(GADRequest *)request
    completionHandler:(GADRewardedAdLoadCompletionHandler)completionHandler;

/// The ad unit ID.
@property(readonly, copy, nonatomic) NSString *adUnitID;

/// Indicates whether the rewarded ad is ready to be presented.
@property(nonatomic, readonly, getter=isReady) BOOL ready;

/// The ad network class name that fetched the current ad. Is nil while the ready property is NO.
/// For both standard and mediated Google AdMob ads, this property is @"GADMAdapterGoogleAdMobAds".
/// For ads fetched via mediation custom events, this property is the mediated custom event
/// adapter's class name.
@property(nonatomic, readonly, copy, nullable) NSString *adNetworkClassName;

/// The reward earned by the user for interacting with a rewarded ad. Is nil until the ad has
/// successfully loaded.
@property(nonatomic, readonly, nullable) GADAdReward *reward;

/// Options specified for server-to-server user reward verification.
@property(nonatomic, copy, nullable)
    GADServerSideVerificationOptions *serverSideVerificationOptions;

/// The loaded ad's metadata. Is nil if no ad is loaded or the loaded ad doesn't have metadata. Ad
/// metadata may update after loading. Set the adMetadataDelegate property to listen for changes.
@property(nonatomic, readonly, nullable) NSDictionary<GADAdMetadataKey, id> *adMetadata;

/// Delegate for receiving ad metadata change notifications.
@property(nonatomic, weak, nullable) id<GADRewardedAdMetadataDelegate> adMetadataDelegate;

/// Presents the rewarded ad with the provided view controller and rewarded delegate to call back on
/// various intermission events. The delegate is strongly retained by the receiver until a terminal
/// delegate method is called. Terminal methods are -rewardedAd:didFailToPresentWithError: and
/// -rewardedAdDidClose: of GADRewardedAdDelegate.
- (void)presentFromRootViewController:(UIViewController *)viewController
                             delegate:(id<GADRewardedAdDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
