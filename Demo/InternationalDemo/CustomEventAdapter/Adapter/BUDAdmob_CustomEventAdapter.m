//
//  BUDAdmob_CustomEventAdapter.m
//  BUDemo
//
//  Created by ByteDance on 2022/6/22.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUDAdmob_CustomEventAdapter.h"
#import "BUDAdmob_FullScreenVideoCustomEventAdapter.h"
#import "BUDAdmob_BannerCustomEventAdapter.h"
#import "BUDAdmob_RewardCustomEventAdapter.h"
#import "BUDAdmob_NativeFeedCustomEventAdapter.h"
#import "BUDAdmobTool.h"
#import <PAGAdSDK/PAGSdk.h>

@interface BUDAdmob_CustomEventAdapter ()

@property (nonatomic, strong)BUDAdmob_FullScreenVideoCustomEventAdapter *interstitialAdapter;
@property (nonatomic, strong)BUDAdmob_BannerCustomEventAdapter *bannerAdapter;
@property (nonatomic, strong)BUDAdmob_RewardCustomEventAdapter *rewardAdapter;
@property (nonatomic, strong)BUDAdmob_NativeFeedCustomEventAdapter *nativeAdapter;


@end

@implementation BUDAdmob_CustomEventAdapter

NSString *const BUDAdmob_PLACEMENT_ID = @"placementID";

#pragma mark - GADMediationAdapter
/// Returns the adapter version.
+ (GADVersionNumber)adapterVersion{
    NSString *versionString = PAGAdmobCustomEventAdapterVersion;
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 3) {
        version.majorVersion = [versionComponents[0] integerValue];
        version.minorVersion = [versionComponents[1] integerValue];
        version.patchVersion = [versionComponents[2] integerValue];
    }
    return version;
}

/// Returns the ad SDK version.
+ (GADVersionNumber)adSDKVersion{
    NSString *versionString = PAGSdk.SDKVersion;
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 4) {
        version.majorVersion = [versionComponents[0] integerValue];
        version.minorVersion = [versionComponents[1] integerValue];
        version.patchVersion = [versionComponents[2] integerValue];
    }
    return version;
}

/// The extras class that is used to specify additional parameters for a request to this ad network.
/// Returns Nil if the network doesn't have publisher provided extras.
+ (nullable Class<GADAdNetworkExtras>)networkExtrasClass {
    return Nil;
}

- (void)loadBannerForAdConfiguration:(GADMediationBannerAdConfiguration *)adConfiguration completionHandler:(GADMediationBannerLoadCompletionHandler)completionHandler {
    _bannerAdapter = [[BUDAdmob_BannerCustomEventAdapter alloc] init];
    [_bannerAdapter loadBannerForAdConfiguration:adConfiguration completionHandler:completionHandler];
}

- (void)loadInterstitialForAdConfiguration:(GADMediationInterstitialAdConfiguration *)adConfiguration completionHandler:(GADMediationInterstitialLoadCompletionHandler)completionHandler {
    _interstitialAdapter = [[BUDAdmob_FullScreenVideoCustomEventAdapter alloc] init];
    [_interstitialAdapter loadInterstitialForAdConfiguration:adConfiguration completionHandler:completionHandler];
}

- (void)loadRewardedAdForAdConfiguration:(GADMediationRewardedAdConfiguration *)adConfiguration completionHandler:(GADMediationRewardedLoadCompletionHandler)completionHandler {
    _rewardAdapter = [[BUDAdmob_RewardCustomEventAdapter alloc] init];
    [_rewardAdapter loadRewardedAdForAdConfiguration:adConfiguration completionHandler:completionHandler];

}

- (void)loadNativeAdForAdConfiguration:(GADMediationNativeAdConfiguration *)adConfiguration completionHandler:(GADMediationNativeLoadCompletionHandler)completionHandler {
    _nativeAdapter = [[BUDAdmob_NativeFeedCustomEventAdapter alloc] init];
    [_nativeAdapter loadNativeAdForAdConfiguration:adConfiguration completionHandler:completionHandler];
}

@end
