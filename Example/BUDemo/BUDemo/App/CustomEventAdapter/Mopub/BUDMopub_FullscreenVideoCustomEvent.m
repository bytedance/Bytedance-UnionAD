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

@interface BUDMopub_FullscreenVideoCustomEvent ()<BUFullscreenVideoAdDelegate>
@property (strong, nonatomic) BUFullscreenVideoAd *fullScreenVideo;
@end


@implementation BUDMopub_FullscreenVideoCustomEvent
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    [self.fullScreenVideo loadAdData];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [self.fullScreenVideo showAdFromRootViewController:rootViewController];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

- (BUFullscreenVideoAd *)fullScreenVideo {
    if (!_fullScreenVideo) {
        BUFullscreenVideoAd *fullScreenVideo = [[BUFullscreenVideoAd alloc] initWithSlotID:@"900546299"];
        fullScreenVideo.delegate = self;
        _fullScreenVideo = fullScreenVideo;
        [fullScreenVideo loadAdData];
    }
    return _fullScreenVideo;
}

#pragma mark - BUFullscreenVideoAdDelegate
- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEvent:self didLoadAd:fullscreenVideoAd];
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate trackImpression];
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)fullscreenVideoAdDidClickDownload:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
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
