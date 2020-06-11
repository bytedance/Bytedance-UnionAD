//
//  BUDAdmob_RewardExpressCustomEventAdapter.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/26.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardExpressCustomEventAdapter.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDAdmob_RewardExpressCustomEventAdapter()<BUNativeExpressRewardedVideoAdDelegate,GADMediationRewardedAd>

@property(nonatomic, weak, nullable) id<GADMediationRewardedAdEventDelegate> delegate;
@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedVideoAd;
@property (nonatomic, copy) GADMediationRewardedLoadCompletionHandler completionHandler;

@end

@implementation BUDAdmob_RewardExpressCustomEventAdapter
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
completionHandler: (nonnull GADMediationRewardedLoadCompletionHandler)completionHandler {
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    self.rewardedVideoAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:express_reward_ID_both rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
    self.completionHandler = completionHandler;
}

#pragma mark - GADMediationRewardedAd
- (void)presentFromViewController:(nonnull UIViewController *)viewController {
    if ([_rewardedVideoAd isAdValid]) {
        [_rewardedVideoAd showAdFromRootViewController:viewController ritScene:0 ritSceneDescribe:nil];
    } else {
        NSError *error =
          [NSError errorWithDomain:@"GADMediationAdapterSampleAdNetwork"
                              code:0
                          userInfo:@{NSLocalizedDescriptionKey : @"Unable to display ad."}];
        [self.delegate didFailToPresentWithError:error];
    }
}

#pragma mark BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.completionHandler) {
        self.delegate = self.completionHandler(self, nil);
    }
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    if (self.completionHandler) {
        self.completionHandler(nil, error);
    }
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate didStartVideo];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    [self.delegate didFailToPresentWithError:error];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate willDismissFullScreenView];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate didDismissFullScreenView];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate reportClick];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    if (error) {
        
    } else {
        [self.delegate didEndVideo];
        BUD_Log(@"%s", __func__);
    }
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        GADAdReward *aReward = [[GADAdReward alloc] initWithRewardType:@""
                                   rewardAmount:[NSDecimalNumber numberWithInteger:rewardedVideoAd.rewardedVideoModel.rewardAmount]];
        [self.delegate didRewardUserWithReward:aReward];

    }
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

@end
