//
//  BUDMopub_RewardedVideoCustomEvent.m
//  mopub_adaptor
//
//  Created by bytedance_yuanhuan on 2018/9/18.
//  Copyright © 2018年 Siwant. All rights reserved.
//

#import "BUDMopub_RewardedVideoCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>
#import <mopub-ios-sdk/MoPub.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDMopub_RewardedVideoCustomEvent ()<BURewardedVideoAdDelegate>
@property (nonatomic, strong) BURewardedVideoAd *rewardVideoAd;
@end

@implementation BUDMopub_RewardedVideoCustomEvent

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    
    BURewardedVideoAd *RewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:normal_reward_ID rewardedVideoModel:model];
    RewardedVideoAd.delegate = self;
    self.rewardVideoAd = RewardedVideoAd;
    [RewardedVideoAd loadAdData];
}

- (BOOL)hasAdAvailable {
    return self.rewardVideoAd.isAdValid;
}
    
- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    [self.rewardVideoAd showAdFromRootViewController:viewController];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

#pragma mark BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    [self.delegate trackImpression];
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
    [self.delegate trackClick];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        MPRewardedVideoReward *reward = [[MPRewardedVideoReward alloc] initWithCurrencyType:self.rewardVideoAd.rewardedVideoModel.rewardName amount:[NSNumber numberWithInteger:self.rewardVideoAd.rewardedVideoModel.rewardAmount]];
        [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:reward];
    }
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s", __func__);
}

@end
