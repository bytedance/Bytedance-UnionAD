//
//  BUDAdmob_BannerCustomEventAdapter.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/27.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_BannerCustomEventAdapter.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDAdmob_BannerCustomEventAdapter ()<BUNativeExpressBannerViewDelegate>
@property (nonatomic, strong) BUNativeExpressBannerView *bannerView;
@end

@implementation BUDAdmob_BannerCustomEventAdapter

@synthesize delegate;

- (void)requestBannerAd:(GADAdSize)adSize parameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    UIViewController *rootViewController = self.delegate.viewControllerForPresentingModalView;
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:express_banner_ID rootViewController:rootViewController adSize:CGSizeMake(adSize.size.width, adSize.size.height) IsSupportDeepLink:YES];
    self.bannerView.frame = CGRectMake(0, 0, adSize.size.width, adSize.size.height);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
}

#pragma mark BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    [self.delegate customEventBanner:self didFailAd:error];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate customEventBanner:self didReceiveAd:bannerAdView];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    [self.delegate customEventBanner:self didFailAd:error];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate customEventBannerWillPresentModal:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate customEventBannerWasClicked:self];
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [self.delegate customEventBannerWillDismissModal:self];
    [self.delegate customEventBannerDidDismissModal:self];
    BUD_Log(@"%s",__func__);
}


@end
