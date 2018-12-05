//
//  BUDMopub_InterstitialCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/25.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_InterstitialCustomEvent.h"
#import <BUAdSDK/BUInterstitialAd.h>
#import <BUAdSDK/BUSize.h>

@interface BUDMopub_InterstitialCustomEvent () <BUInterstitialAdDelegate>
@property (nonatomic, strong) BUInterstitialAd *interstitialAd;
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

- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitialAd];
}

- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)interstitialAdDidClick:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
}

- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)interstitialAdWillClose:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)interstitialAdWillVisible:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate trackImpression];
    [self.delegate interstitialCustomEventDidAppear:self];
}


#pragma mark - getter
- (BUInterstitialAd *)interstitialAd {
    if (!_interstitialAd) {
        _interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:@"900546957" size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
        _interstitialAd.delegate = self;
    }
    return _interstitialAd;
}
@end
