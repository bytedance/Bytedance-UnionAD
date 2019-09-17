//
//  BUDMopub_InterstitialCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/25.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_InterstitialCustomEvent.h"
#import <BUAdSDK/BUNativeExpressInterstitialAd.h>
#import <BUAdSDK/BUSize.h>
#import "BUDMacros.h"

@interface BUDMopub_InterstitialCustomEvent () <BUNativeExpresInterstitialAdDelegate>
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;
@end

@implementation BUDMopub_InterstitialCustomEvent
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    [self.interstitialAd loadAdData];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [self.interstitialAd showAdFromRootViewController:rootViewController];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

#pragma mark - BUInterstitialAdDelegate

- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitialAd];
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate trackImpression];
    [self.delegate interstitialCustomEventDidAppear:self];
}

#pragma mark - getter
- (BUNativeExpressInterstitialAd *)interstitialAd {
    if (!_interstitialAd) {
        _interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:@"900546270" imgSize:[BUSize sizeBy:BUProposalSize_Interstitial600_600] adSize:CGSizeMake(300, 450)];
        _interstitialAd.delegate = self;
    }
    return _interstitialAd;
}
@end
