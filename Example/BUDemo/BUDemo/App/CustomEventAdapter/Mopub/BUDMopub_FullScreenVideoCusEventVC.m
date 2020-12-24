//
//  BUDMopub_FullScreenVideoCusEventVC.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/11/1.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_FullScreenVideoCusEventVC.h"
#import <mopub-ios-sdk/MPInterstitialAdController.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDMopub_FullScreenVideoCusEventVC () <MPInterstitialAdControllerDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) MPInterstitialAdController *interstitial;
@end

@implementation BUDMopub_FullScreenVideoCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    self.button.isValid = NO;
    
    [self loadFullscreenVideo];
}

- (void)loadFullscreenVideo {
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:mopub_fullscreen_UnitID];
    
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

#pragma mark 延迟加载
- (BUDNormalButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:[NSString localizedStringForKey:ShowFullScreenVideo] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)buttonTapped:(UIButton *)sender {
    if (self.interstitial.ready) {
        [self.interstitial showFromViewController:self];
    }
    self.button.isValid = NO;
}

#pragma mark - MPInterstitialAdControllerDelegate
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"fullscreen data load success";
    [hud hideAnimated:YES afterDelay:2];
    self.button.isValid = YES;
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial
                          withError:(NSError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialWillDisappear:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    [self loadFullscreenVideo];
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

@end
