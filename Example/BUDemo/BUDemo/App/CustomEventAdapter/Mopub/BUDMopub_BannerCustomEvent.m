//
//  BUDMopub_BannerCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/24.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_BannerCustomEvent.h"
#import <BUAdSDK/BUBannerAdView.h>

@interface BUDMopub_BannerCustomEvent ()<BUBannerAdViewDelegate>
@property (strong, nonatomic)BUBannerAdView *bannerView;
@end

@implementation BUDMopub_BannerCustomEvent
- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    if (self.bannerView == nil) {
        BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
        self.bannerView = [[BUBannerAdView alloc] initWithSlotID:@"900546859" size:size rootViewController:[UIViewController new]];
        const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);

        CGFloat bannerHeight = screenWidth * size.height / size.width;
        self.bannerView.frame = CGRectMake(0, 0, screenWidth, bannerHeight);
        self.bannerView.delegate = self;
    }
    [self.bannerView loadAdData];
}

#pragma mark - BUBannerAdViewDelegate
- (void)bannerAdViewDidLoad:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd {
    [self.delegate bannerCustomEvent:self didLoadAd:self.bannerView];
}

- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd {
    [self.delegate trackImpression];
}

- (void)bannerAdViewDidClick:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd {
    [self.delegate bannerCustomEventDidFinishAction:self];
    [self.delegate trackClick];
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords {
    NSLog(@"%s", __func__);
}

@end
