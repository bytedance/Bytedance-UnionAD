//
//  BUDAdmob_InterstitialCustomEventAdapter.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/27.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_InterstitialCustomEventAdapter.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDAdmob_InterstitialCustomEventAdapter() <BUNativeExpresInterstitialAdDelegate>
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;
@end

@implementation BUDAdmob_InterstitialCustomEventAdapter
@synthesize delegate;

- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController {
    if (self.interstitialAd.isAdValid) {
        [self.interstitialAd showAdFromRootViewController:rootViewController];
    } else {
        BUD_Log(@"no ads to show");
    }
}

- (void)requestInterstitialAdWithParameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    NSDictionary *sizeDict = [request.additionalParameters objectForKey:@"bytedanceAdsize"];
    CGFloat width = [[sizeDict objectForKey:@"width"] floatValue];
    CGFloat height = [[sizeDict objectForKey:@"height"] floatValue];
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:express_interstitial_ID adSize:CGSizeMake(width, height)];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

#pragma mark BUNativeExpresInterstitialAdDelegate
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    [self.delegate customEventInterstitial:self didFailAd:error];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate customEventInterstitialDidReceiveAd:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    [self.delegate customEventInterstitial:self didFailAd:error];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate customEventInterstitialWillPresent:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate customEventInterstitialWasClicked:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate customEventInterstitialWillDismiss:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self.delegate customEventInterstitialDidDismiss:self];
    BUD_Log(@"%s",__func__);
}


@end
