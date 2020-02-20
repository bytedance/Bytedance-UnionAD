//
//  BUDAdmob_FullScreenExpressCusEventVC.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/26.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_FullScreenExpressCusEventVC.h"
#import <GoogleMobileAds/GADInterstitial.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDAdmob_FullScreenExpressCusEventVC ()<GADInterstitialDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property(nonatomic, strong) GADInterstitial *fullscreenVideoAd;
@end

@implementation BUDAdmob_FullScreenExpressCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.button];
    self.button.isValid = NO;
    [self loadFullScreenVideo];
}

- (void)loadFullScreenVideo {
    self.fullscreenVideoAd = [[GADInterstitial alloc]
                         initWithAdUnitID:admob_expressFullscreen_UnitID];
    self.fullscreenVideoAd.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.fullscreenVideoAd loadRequest:request];
}

#pragma mark 延迟加载
- (UIButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:[NSString localizedStringForKey:ShowFullScreenVideo] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark 事件处理
- (void)buttonTapped:(id)sender {
    if (self.fullscreenVideoAd.isReady) {
        [self.fullscreenVideoAd presentFromRootViewController:self];
    } else {
        NSLog(@"Ad wasn't ready");
    }
    self.button.isValid = NO;
}

#pragma mark GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"fullscreenVideo data load success";
    [hud hideAnimated:YES afterDelay:2];
    self.button.isValid = YES;
    BUD_Log(@"%s", __func__);
}

- (void)interstitial:(nonnull GADInterstitial *)ad didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialWillPresentScreen:(nonnull GADInterstitial *)ad {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidDismissScreen:(nonnull GADInterstitial *)ad {
    [self loadFullScreenVideo];
    BUD_Log(@"%s", __func__);
}

@end
