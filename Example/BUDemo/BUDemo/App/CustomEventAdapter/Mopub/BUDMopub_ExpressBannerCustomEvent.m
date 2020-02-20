//
//  BUDMopub_ExpressBannerCustomEvent.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDMopub_ExpressBannerCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDMopub_ExpressBannerCustomEvent()<BUNativeExpressBannerViewDelegate>
@property (nonatomic, strong) BUNativeExpressBannerView *bannerView;
@end

@implementation BUDMopub_ExpressBannerCustomEvent

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BUSize *adSize = [[BUSize alloc] init];
    adSize.width = size.width;
    adSize.height = size.height;
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:express_banner_ID rootViewController:self.delegate.viewControllerForPresentingModalView adSize:size IsSupportDeepLink:YES];
    self.bannerView.frame = CGRectMake(0, 0, size.width, size.height);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
}

#pragma mark BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate bannerCustomEvent:self didLoadAd:bannerAdView];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate trackImpression];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
//    [self.delegate bannerCustomEventWillBeginAction:self];
//    [self.delegate bannerCustomEventDidFinishAction:self];// not support finish
    [self.delegate trackClick];
    BUD_Log(@"%s", __func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords {
    [bannerAdView removeFromSuperview];
    BUD_Log(@"%s", __func__);
}

@end
