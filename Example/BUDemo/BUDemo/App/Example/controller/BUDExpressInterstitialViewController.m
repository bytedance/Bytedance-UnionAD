//
//  BUDExpressInterstitialViewController.m
//  BUDemo
//
//  Created by xxx on 2019/5/15.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressInterstitialViewController.h"
#import <BUAdSDK/BUNativeExpressInterstitialAd.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import <BUAdSDK/BUSize.h>
#import "NSString+LocalizedString.h"

@interface BUDExpressInterstitialViewController ()<BUNativeExpresInterstitialAdDelegate>
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;
@property (nonatomic, strong) BUDNormalButton *button;
@end

@implementation BUDExpressInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.button.showRefreshIncon = YES;
    [self.button setTitle:[NSString localizedStringForKey:ShowInterstitial] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.viewModel.slotID imgSize:[BUSize sizeBy:BUProposalSize_Interstitial600_600] adSize:CGSizeMake(300, 450)];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

- (void)buttonTapped:(UIButton *)sender {
    if (self.interstitialAd.isAdValid) {
        [self.interstitialAd showAdFromRootViewController:self];
    }
}

#pragma ---BUNativeExpresInterstitialAdDelegate

- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    BUD_Log(@"%s",__func__);
    [self.interstitialAd loadAdData];
}

@end
