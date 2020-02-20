//
//  BUDMopub_ExpressBannerCusEventVC.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDMopub_ExpressBannerCusEventVC.h"
#import <mopub-ios-sdk/MPAdView.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDMopub_ExpressBannerCusEventVC ()<MPAdViewDelegate>
@property(nonatomic, strong) BUDNormalButton *button;
@property (nonatomic) MPAdView *adView;
@end

@implementation BUDMopub_ExpressBannerCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
}

- (void)loadBannerView {
    [self.adView removeFromSuperview];
    
    self.adView = [[MPAdView alloc] initWithAdUnitId:mopub_expressBanner_UnitID];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake(0,100,self.view.bounds.size.width, 50);
    [self.view addSubview:self.adView];
    [self.adView loadAd];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

#pragma mark 延迟加载
- (BUDNormalButton *)button {
    if (!_button) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, screenSize.height *0.2, 0, 0)];
        _button.showRefreshIncon = YES;
        [_button setTitle:[NSString localizedStringForKey:ShowBanner] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)refreshBanner {
    [self loadBannerView];
}

#pragma mark MPAdViewDelegate
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view adSize:(CGSize)adSize {
    BUD_Log(@"%s", __func__);
}

- (void)adView:(MPAdView *)view didFailToLoadAdWithError:(NSError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)willPresentModalViewForAd:(MPAdView *)view {
    BUD_Log(@"%s", __func__);
}

-(void)didDismissModalViewForAd:(MPAdView *)view {
    [view removeFromSuperview];
    [self loadBannerView];
    BUD_Log(@"%s", __func__);
}

@end
