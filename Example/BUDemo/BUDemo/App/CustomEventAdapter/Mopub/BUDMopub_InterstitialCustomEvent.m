//
//  BUDMopub_InterstitialCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/25.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_InterstitialCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDMopub_InterstitialCustomEvent () <BUInterstitialAdDelegate>
@property (nonatomic, strong) BUInterstitialAd *interstitialAd;
@end

@implementation BUDMopub_InterstitialCustomEvent
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:normal_interstitial_ID size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [self.interstitialAd showAdFromRootViewController:rootViewController];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

#pragma mark - BUInterstitialAdDelegate
- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitialAd];
    BUD_Log(@"%s",__func__);
}

- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError * _Nullable)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    BUD_Log(@"%s",__func__);
}

- (void)interstitialAdWillVisible:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate trackImpression];
    [self.delegate interstitialCustomEventDidAppear:self];
    BUD_Log(@"%s",__func__);
}

- (void)interstitialAdDidClick:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
    BUD_Log(@"%s",__func__);
}

- (void)interstitialAdWillClose:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillDisappear:self];
    BUD_Log(@"%s",__func__);
}

- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidDisappear:self];
    BUD_Log(@"%s",__func__);
}

- (void)interstitialAdDidCloseOtherController:(BUInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"%s",__func__);
}


@end
