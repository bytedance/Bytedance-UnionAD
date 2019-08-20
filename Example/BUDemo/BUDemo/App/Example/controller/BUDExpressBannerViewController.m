//
//  BUDExpressBannerViewController.m
//  BUDemo
//
//  Created by xxx on 2019/5/15.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressBannerViewController.h"
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import <BUAdSDK/BUNativeExpressBannerView.h>
#import <BUAdSDK/BUAdSDK.h>
#import "NSString+LocalizedString.h"

@interface BUDExpressBannerViewController ()<BUNativeExpressBannerViewDelegate>
@property(nonatomic, strong) BUDNormalButton *refreshbutton;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;

@property(nonatomic, strong) BUDNormalButton *refreshCarouselbutton;
@property(nonatomic, strong) BUNativeExpressBannerView *carouselBannerView;
@end

@implementation BUDExpressBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ScrollView as self.view
    CGRect screenRect = [UIScreen mainScreen].bounds;
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    sv.contentSize = CGSizeMake(screenRect.size.width, screenRect.size.height * 2);
    sv.backgroundColor = [UIColor whiteColor];
    self.view = sv;
    
    //refresh Button
    CGSize size = [UIScreen mainScreen].bounds.size;
    _refreshbutton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height *0.4, 0, 0)];
    _refreshbutton.showRefreshIncon = YES;
    [_refreshbutton setTitle:[NSString localizedStringForKey:ShowBanner] forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
    //refresh Button
    _refreshCarouselbutton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height *0.9, 0, 0)];
    _refreshCarouselbutton.showRefreshIncon = YES;
    [_refreshCarouselbutton setTitle:[NSString localizedStringForKey:ShowScrollBanner] forState:UIControlStateNormal];
    [_refreshCarouselbutton addTarget:self action:@selector(refreshCarouselBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshCarouselbutton];
}

-  (void)refreshBanner {
    if (self.bannerView == nil) {
        CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat bannerHeigh = screenWidth/600*90;
        BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Banner600_150];
        self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:self.viewModel.slotID rootViewController:self imgSize:imgSize adSize:CGSizeMake(screenWidth, bannerHeigh) IsSupportDeepLink:YES];
        self.bannerView.frame = CGRectMake(0, 10, screenWidth, bannerHeigh);
        self.bannerView.delegate = self;
        [self.view addSubview:self.bannerView];
    }
    [self.bannerView loadAdData];
}

-  (void)refreshCarouselBanner {
    if (self.carouselBannerView == nil) {
        CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat bannerHeigh = screenWidth/600*90;
        BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Banner600_150];
        self.carouselBannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:self.viewModel.slotID rootViewController:self imgSize:imgSize adSize:CGSizeMake(screenWidth, bannerHeigh) IsSupportDeepLink:YES interval:30];
        self.carouselBannerView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)*0.5, screenWidth, bannerHeigh);
        self.carouselBannerView.delegate = self;
        [self.view addSubview:self.carouselBannerView];
    }
    [self.carouselBannerView loadAdData];
}

#pragma BUNativeExpressBannerViewDelegate

- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    BUD_Log(@"%s",__func__);
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        if (self.bannerView == bannerAdView) {
            self.bannerView = nil;
        }
        if (self.carouselBannerView == bannerAdView) {
            self.carouselBannerView = nil;
        }
    }];
}

@end
