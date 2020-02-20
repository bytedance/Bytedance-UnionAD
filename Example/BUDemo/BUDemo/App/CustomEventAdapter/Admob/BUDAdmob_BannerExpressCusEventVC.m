//
//  BUDAdmob_BannerExpressCusEventVC.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/26.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_BannerExpressCusEventVC.h"
#import <GoogleMobileAds/GADBannerView.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDAdmob_BannerExpressCusEventVC ()<GADBannerViewDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property(nonatomic, strong) GADBannerView *bannerView;
@end

@implementation BUDAdmob_BannerExpressCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.button];
    
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeBanner];
    self.bannerView.adUnitID = admob_expressBanner_UnitID;
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
}

- (void)loadBannerView {
    [self.bannerView loadRequest:[GADRequest request]];
}

#pragma mark 延迟加载
- (UIButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:[NSString localizedStringForKey:ShowBanner] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark 事件处理
- (void)buttonTapped:(id)sender {
    [self loadBannerView];
}

#pragma mark GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    [self.view addSubview:self.bannerView];
    CGFloat X = (CGRectGetWidth(self.view.bounds)- adView.frame.size.width)/2;
    self.bannerView.frame = CGRectMake(X, 100, adView.frame.size.width, adView.frame.size.height);
    BUD_Log(@"%s", __func__);
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)adViewWillPresentScreen:(nonnull GADBannerView *)bannerView {
    BUD_Log(@"%s", __func__);
}

- (void)adViewWillDismissScreen:(nonnull GADBannerView *)bannerView {
    [bannerView removeFromSuperview];
    BUD_Log(@"%s", __func__);
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    [self loadBannerView];
    BUD_Log(@"%s", __func__);
}

@end
