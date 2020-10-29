//
//  BUDMopub_ExpressRewardedVideoCustomEvent.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDMopub_ExpressRewardedVideoCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import <mopub-ios-sdk/MoPub.h>

@interface BUDMopub_ExpressRewardedVideoCustomEvent ()<BUNativeExpressRewardedVideoAdDelegate>
@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardVideoAd;
@end

@implementation BUDMopub_ExpressRewardedVideoCustomEvent
- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *adPlacementId = [info objectForKey:@"ad_placement_id"];
    if (adPlacementId == nil) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:@{NSLocalizedDescriptionKey: @"Invalid ad_placement_id. Failing ad request."}];
        [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
        return;
    }

    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    
    self.rewardVideoAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:adPlacementId rewardedVideoModel:model];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAdData];
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

#pragma mark BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
    
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
    
}

- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    [self.delegate trackImpression];
    
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
    
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
    
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
    
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
    [self.delegate trackClick];
    
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    if (error) {
        [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
    }
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        MPRewardedVideoReward *reward = [[MPRewardedVideoReward alloc] initWithCurrencyType:self.rewardVideoAd.rewardedVideoModel.rewardName amount:[NSNumber numberWithInteger:self.rewardVideoAd.rewardedVideoModel.rewardAmount]];
        [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:reward];
    }
    
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError * _Nullable)error {
    BUD_Log(@"%s error =  %@",__func__,error);
}


@end
