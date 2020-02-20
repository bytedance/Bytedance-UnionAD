//
//  BUDAdmob_FullScreenCustomEventAdapter.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/27.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_FullScreenCustomEventAdapter.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDAdmob_FullScreenCustomEventAdapter() <BUNativeExpressFullscreenVideoAdDelegate>
@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd *fullscreenVideoAd;
@end

@implementation BUDAdmob_FullScreenCustomEventAdapter
@synthesize delegate;

- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController {
    if ([self.fullscreenVideoAd isAdValid]) {
        [self.fullscreenVideoAd showAdFromRootViewController:rootViewController];
    } else {
        BUD_Log(@"no ads to show");
    }
}

- (void)requestInterstitialAdWithParameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    self.fullscreenVideoAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:express_fullscreen_ID];
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
}

#pragma mark BUNativeExpressFullscreenVideoAdDelegate
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    [self.delegate customEventInterstitial:self didFailAd:error];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    [self.delegate customEventInterstitialDidReceiveAd:self];
}

- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    [self.delegate customEventInterstitial:self didFailAd:error];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate customEventInterstitialWillPresent:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate customEventInterstitialWasClicked:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate customEventInterstitialWillDismiss:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self.delegate customEventInterstitialDidDismiss:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
}

@end
