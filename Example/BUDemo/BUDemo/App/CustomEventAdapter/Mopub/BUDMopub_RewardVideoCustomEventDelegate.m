//
//  BURewardVideoCustomEventDelegate.m
//  mopub_adaptor
//
//  Created by bytedance_yuanhuan on 2018/9/18.
//  Copyright © 2018年 Siwant. All rights reserved.
//

#import "BUDMopub_RewardVideoCustomEventDelegate.h"
#import <BUAdSDK/BUAdSDK.h>

@implementation BUDMopub_RewardVideoCustomEventDelegate

- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    [self.adapter.delegate rewardedVideoDidLoadAdForCustomEvent:self.adapter];
}
    
- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s", __func__);
}
    
- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [self.adapter.delegate rewardedVideoDidFailToPlayForCustomEvent:self.adapter error:error];
}
    
- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    [self.adapter.delegate rewardedVideoWillAppearForCustomEvent:self.adapter];
    [self.adapter.delegate trackImpression];
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    [self.adapter.delegate rewardedVideoDidDisappearForCustomEvent:self.adapter];
}
    
- (void)rewardedVideoAdDidClickDownload:(BURewardedVideoAd *)rewardedVideoAd {
    [self.adapter.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self.adapter];
    [self.adapter.delegate trackClick];
}
    
- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"%s", __func__);
}
    
- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    NSLog(@"%s", __func__);
}
    
- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s", __func__);
}

@end
