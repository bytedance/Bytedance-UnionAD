//
//  BUDMopub_BannerCustomEvent.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/24.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_BannerCustomEvent.h"
#import <BUAdSDK/BUNativeExpressBannerView.h>
#import <BUAdSDK/BUSize.h>
#import "BUDMacros.h"

@interface BUDMopub_BannerCustomEvent ()<BUNativeExpressBannerViewDelegate>
@property (strong, nonatomic)BUNativeExpressBannerView *bannerView;
@end

@implementation BUDMopub_BannerCustomEvent
- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    if (self.bannerView == nil) {
        CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat bannerHeight = screenWidth * size.height / size.width;
        BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Banner600_150];
        
        self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:@"900546269" rootViewController:[UIApplication sharedApplication].delegate.window.rootViewController imgSize:imgSize adSize:CGSizeMake(screenWidth, bannerHeight) IsSupportDeepLink:YES];

        self.bannerView.frame = CGRectMake(0, 0, screenWidth, bannerHeight);
        self.bannerView.delegate = self;
    }
    [self.bannerView loadAdData];
}

#pragma mark - BUBannerAdViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate bannerCustomEvent:self didLoadAd:bannerAdView];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate trackImpression];
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate bannerCustomEventDidFinishAction:self];
    [self.delegate trackClick];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    BUD_Log(@"%s", __func__);
}

@end
