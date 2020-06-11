//
//  BUDAdmob_RewardCustomEventAdapter.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardCustomEventAdapter.h"
#import <BUAdSDK/BURewardedVideoModel.h>
#import <BUAdSDK/BURewardedVideoAd.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDAdmob_RewardCustomEventAdapter ()<BURewardedVideoAdDelegate,GADMediationRewardedAd>
{
}

@property(nonatomic, weak, nullable) id<GADMediationRewardedAdEventDelegate> delegate;
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@property (nonatomic, copy) GADMediationRewardedLoadCompletionHandler completionHandler;

@end

@implementation BUDAdmob_RewardCustomEventAdapter

#pragma mark - GADMediationAdapter
/// Returns the adapter version.
+ (GADVersionNumber)version{
     NSString *versionString = @"1.0.0";
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
         NSString *versionString = @"1.0.0";
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 3) {
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

- (void)loadRewardedAdForAdConfiguration: (nonnull GADMediationRewardedAdConfiguration *)adConfiguration
           completionHandler:
               (nonnull GADMediationRewardedLoadCompletionHandler)completionHandler {
  // Look for the "parameter" key to fetch the parameter you defined in the AdMob UI.
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:normal_reward_ID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
    self.completionHandler = completionHandler;
}


#pragma mark - GADMediationRewardedAd
- (void)presentFromViewController:(nonnull UIViewController *)viewController{
    if ([_rewardedVideoAd isAdValid]) {
        [_rewardedVideoAd showAdFromRootViewController:viewController ritScene:0 ritSceneDescribe:nil];
    } else {
        BUD_Log(@"No ads to show.");
        NSError *error =
          [NSError errorWithDomain:@"GADMediationAdapterSampleAdNetwork"
                              code:0
                          userInfo:@{NSLocalizedDescriptionKey : @"Unable to display ad."}];
        [self.delegate didFailToPresentWithError:error];
    }
}

#pragma mark BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    if (self.completionHandler) {
        self.delegate = self.completionHandler(self, nil);
    }
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (self.completionHandler) {
        self.completionHandler(nil, error);
    }
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd{
    [self.delegate didStartVideo];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd{
    [self.delegate willDismissFullScreenView];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate didDismissFullScreenView];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate reportClick];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [self.delegate didEndVideo];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    GADAdReward *aReward =
    [[GADAdReward alloc] initWithRewardType:@""
                               rewardAmount:[NSDecimalNumber numberWithInteger:rewardedVideoAd.rewardedVideoModel.rewardAmount]];
    [self.delegate didRewardUserWithReward:aReward];
    BUD_Log(@"%s", __func__);
}

@end
