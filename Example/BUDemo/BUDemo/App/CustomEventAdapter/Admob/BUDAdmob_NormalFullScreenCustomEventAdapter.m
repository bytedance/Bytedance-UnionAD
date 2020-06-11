//
//  BUDAdmob_NormalFullScreenCustomEventAdapter.m
//  BUDemo
//
//  Created by wangyanlin on 2020/3/10.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_NormalFullScreenCustomEventAdapter.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDAdmob_NormalFullScreenCustomEventAdapter() <BUFullscreenVideoAdDelegate>
@property (nonatomic, strong) BUFullscreenVideoAd *fullscreenVideoAd;
@end

@implementation BUDAdmob_NormalFullScreenCustomEventAdapter
@synthesize delegate;

- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController {
    if ([self.fullscreenVideoAd isAdValid]) {
        [self.fullscreenVideoAd showAdFromRootViewController:rootViewController];
    } else {
        BUD_Log(@"no ads to show");
    }
}

- (void)requestInterstitialAdWithParameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:normal_fullscreen_ID];
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
}

#pragma mark - <BUFullscreenVideoAdDelegate>

- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self.delegate customEventInterstitialDidReceiveAd:self];
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error{
    [self.delegate customEventInterstitial:self didFailAd:error];
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd{
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self.delegate customEventInterstitialWillPresent:self];
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdDidVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self.delegate customEventInterstitialWasClicked:self];
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdWillClose:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self.delegate customEventInterstitialWillDismiss:self];
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self.delegate customEventInterstitialDidDismiss:self];
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error{
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd{
    BUD_Log(@"%s",__func__);
}

- (void)fullscreenVideoAdCallback:(BUFullscreenVideoAd *)fullscreenVideoAd withType:(BUFullScreenVideoAdType)fullscreenVideoAdType{
    BUD_Log(@"%s",__func__);
}

@end
