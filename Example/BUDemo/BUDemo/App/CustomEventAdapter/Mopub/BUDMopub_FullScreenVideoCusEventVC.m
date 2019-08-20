//
//  BUDMopub_FullScreenVideoCusEventVC.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/11/1.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_FullScreenVideoCusEventVC.h"
#import "MPInterstitialAdController.h"
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"

@interface BUDMopub_FullScreenVideoCusEventVC () <MPInterstitialAdControllerDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) MPInterstitialAdController *interstitial;
@end

@implementation BUDMopub_FullScreenVideoCusEventVC

- (void)loadInterstitial {
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:@"d3ecccb5151f4c5aaa93d125004c5d5f"];
    
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:[NSString localizedStringForKey:ShowFullScreenVideo] forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    [self loadInterstitial];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

- (void)buttonTapped:(UIButton *)sender {
    if (self.interstitial.ready) {
        [self.interstitial showFromViewController:self];
    }
}

#pragma mark - MPInterstitialAdControllerDelegate
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
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
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}
@end
