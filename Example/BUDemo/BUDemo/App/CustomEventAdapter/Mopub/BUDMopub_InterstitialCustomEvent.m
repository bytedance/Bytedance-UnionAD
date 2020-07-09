//
//  BUDMopub_InterstitialCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/25.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_InterstitialCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDMopub_InterstitialCustomEvent () <BUInterstitialAdDelegate>
@property (nonatomic, strong) BUInterstitialAd *interstitialAd;
@end

@implementation BUDMopub_InterstitialCustomEvent
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *adPlacementId = [info objectForKey:@"ad_placement_id"];
    if (adPlacementId == nil) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:@{NSLocalizedDescriptionKey: @"Invalid ad_placement_id. Failing ad request."}];
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }

    self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:adPlacementId size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
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
    
}

- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError * _Nullable)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    
}

- (void)interstitialAdWillVisible:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate trackImpression];
    [self.delegate interstitialCustomEventDidAppear:self];
    
}

- (void)interstitialAdDidClick:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
    
}

- (void)interstitialAdWillClose:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventWillDisappear:self];
    
}

- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd {
    [self.delegate interstitialCustomEventDidDisappear:self];
    
}

- (void)interstitialAdDidCloseOtherController:(BUInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
    
}


@end
