//
//  BUDMopub_FullscreenVideoCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/11/1.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_FullscreenVideoCustomEvent.h"
#import <BUAdSDK/BUFullscreenVideoAd.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDMopub_FullscreenVideoCustomEvent ()<BUFullscreenVideoAdDelegate>
@property (strong, nonatomic) BUFullscreenVideoAd *fullScreenVideo;
@end

@implementation BUDMopub_FullscreenVideoCustomEvent
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    self.fullScreenVideo = [[BUFullscreenVideoAd alloc] initWithSlotID:normal_fullscreen_ID];
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
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate trackImpression];
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventDidDisappear:self];
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s", __func__);
}

@synthesize description;

@synthesize hash;

@synthesize superclass;

@end
