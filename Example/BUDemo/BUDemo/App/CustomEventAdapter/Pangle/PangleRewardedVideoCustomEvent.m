#import "PangleRewardedVideoCustomEvent.h"
    #import <BUAdSDK/BUAdSDK.h>
#if __has_include("MoPub.h")
    #import "MPLogging.h"
    #import "MPRewardedVideoError.h"
    #import "MPRewardedVideoReward.h"
#endif
#import "PangleAdapterConfiguration.h"

@interface PangleRewardedVideoCustomEvent ()<BURewardedVideoAdDelegate>
@property (nonatomic, strong) BURewardedVideoAd *rewardVideoAd;
@property (nonatomic, copy) NSString *adPlacementId;
@property (nonatomic, copy) NSString *appId;
@end

@implementation PangleRewardedVideoCustomEvent

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BOOL hasAdMarkup = adMarkup.length > 0;
    self.appId = [info objectForKey:kPangleAppIdKey];
    if (BUCheckValidString(self.appId)) {
        [PangleAdapterConfiguration updateInitializationParameters:info];
    }
    
    self.adPlacementId = [info objectForKey:@"ad_placement_id"];
    if ([self.localExtras objectForKey:@"ad_placement_id"]) {
        self.adPlacementId = [self.localExtras objectForKey:@"ad_placement_id"];
    }
    self.adPlacementId = [info objectForKey:kPanglePlacementIdKey];
    if (!BUCheckValidString(self.adPlacementId)) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                             code:BUErrorCodeAdSlotEmpty
                                         userInfo:@{NSLocalizedDescriptionKey: @"Invalid Pangle placement ID"}];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
        return;
    }
    
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = self.adPlacementId;
    
    BURewardedVideoAd *RewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.adPlacementId rewardedVideoModel:model];
    RewardedVideoAd.delegate = self;
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(self.class) dspCreativeId:nil dspName:nil], [self getAdNetworkId]);
    self.rewardVideoAd = RewardedVideoAd;
    if (hasAdMarkup) {
        MPLogInfo(@"Loading Pangle rewarded video ad markup for Advanced Bidding");
        [RewardedVideoAd setMopubAdMarkUp:adMarkup];
    } else {
        MPLogInfo(@"Loading Pangle rewarded video ad");
        [RewardedVideoAd loadAdData];
    }
}

- (BOOL)hasAdAvailable {
    return self.rewardVideoAd.isAdValid;
}
    
- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    if ([self hasAdAvailable]) {
        [self.rewardVideoAd showAdFromRootViewController:viewController];
    } else {
        NSError *error = [NSError
                          errorWithDomain:MoPubRewardedVideoAdsSDKDomain
                          code:BUErrorCodeNERenderResultError
                          userInfo:@{NSLocalizedDescriptionKey : @"Render error in showing Pangle Rewarded Video Ad."}];
        MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
    }
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

- (void)handleInvalidIdError{
    [BUAdSDKManager setAppID:self.appId];
}

#pragma mark BURewardedVideoAdDelegate

- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    
    [self.delegate trackImpression];
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
    
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
    [self.delegate trackClick];
    [self.delegate rewardedVideoWillLeaveApplicationForCustomEvent:self];
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error != nil) {
        MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
    } else {
        MPLogInfo(@"Rewarded video video finish playing");
    }
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        MPRewardedVideoReward *reward = [[MPRewardedVideoReward alloc] initWithCurrencyType:kMPRewardedVideoRewardCurrencyTypeUnspecified amount: @(kMPRewardedVideoRewardCurrencyAmountUnspecified)];
        MPLogEvent([MPLogEvent adShouldRewardUserWithReward:reward]);
        [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:reward];
    } else {
        MPLogInfo(@"Rewarded video ad fail to verify.");
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogInfo(@"Rewarded video ad server fail to reward.");
}

- (NSString *) getAdNetworkId {
    return (BUCheckValidString(self.adPlacementId)) ? self.adPlacementId : @"";
}

@end
