//
//  BUDMopub_FullscreenVideoCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/11/1.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_FullscreenVideoCustomEvent.h"
#import <BUAdSDK/BUFullscreenVideoAd.h>

@interface BUDMopub_FullscreenVideoCustomEvent ()<BUFullscreenVideoAdDelegate>
@property (strong, nonatomic) BUFullscreenVideoAd *fullScreenVideo;
@end

@implementation BUDMopub_FullscreenVideoCustomEvent
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *adPlacementId = [info objectForKey:@"ad_placement_id"];
    if (adPlacementId == nil) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:@{NSLocalizedDescriptionKey: @"Invalid ad_placement_id. Failing ad request."}];
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    self.fullScreenVideo = [[BUFullscreenVideoAd alloc] initWithSlotID:adPlacementId];
    self.fullScreenVideo.delegate = self;
    [self.fullScreenVideo loadAdData];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [self.fullScreenVideo showAdFromRootViewController:rootViewController ritSceneDescribe:nil];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

#pragma mark - BUFullscreenVideoAdDelegate
- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEvent:self didLoadAd:fullscreenVideoAd];
    ;
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    ;
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate trackImpression];
    ;
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventDidDisappear:self];
    ;
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
    ;
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    ;
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    ;
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    ;
}

@synthesize description;

@synthesize hash;

@synthesize superclass;

@end
