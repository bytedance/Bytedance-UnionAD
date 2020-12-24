//
//  BUDMopub_ExpressBannerCustomEvent.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDMopub_ExpressBannerCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDMopub_ExpressBannerCustomEvent()<BUNativeExpressBannerViewDelegate>
@property (nonatomic, strong) BUNativeExpressBannerView *bannerView;
@end

@implementation BUDMopub_ExpressBannerCustomEvent

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BUSize *adSize = [[BUSize alloc] init];
    adSize.width = size.width;
    adSize.height = size.height;
    NSString *adPlacementId = [info objectForKey:@"ad_placement_id"];
    if (adPlacementId == nil) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:@{NSLocalizedDescriptionKey: @"Invalid ad_placement_id. Failing ad request."}];
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:adPlacementId rootViewController:self.delegate.viewControllerForPresentingModalView adSize:size];
    self.bannerView.frame = CGRectMake(0, 0, size.width, size.height);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
}

#pragma mark BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate bannerCustomEvent:self didLoadAd:bannerAdView];
    
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate trackImpression];
    
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
//    [self.delegate bannerCustomEventWillBeginAction:self];
//    [self.delegate bannerCustomEventDidFinishAction:self];// not support finish
    [self.delegate trackClick];
    
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords {
    [bannerAdView removeFromSuperview];
    
}

@end
