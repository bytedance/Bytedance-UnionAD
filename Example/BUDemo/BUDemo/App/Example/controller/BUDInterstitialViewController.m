//
//  BUDInterstitialViewController.m
//  BUDemo
//
//  Created by carl on 2017/7/31.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDInterstitialViewController.h"
#import <UIKit/NSLayoutConstraint.h>
#import <BUAdSDK/BUInterstitialAd.h>
#import <BUAdSDK/BUSize.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"

@interface BUDInterstitialViewController () <BUInterstitialAdDelegate>
@property (nonatomic, strong) BUInterstitialAd *interstitialAd;
@property (nonatomic, strong) BUDNormalButton *button;
@end

@implementation BUDInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.button.showRefreshIncon = YES;
    [self.button setTitle:[NSString localizedStringForKey:ShowInterstitial] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:self.viewModel.slotID size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

- (void)buttonTapped:(UIButton *)sender {
    [self.interstitialAd showAdFromRootViewController:self.navigationController];
}

- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd {
    [self.interstitialAd loadAdData];
     BUD_Log(@"interstitialAd AdDidClose");
}


- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd {
    BUD_Log(@"interstitialAd data load sucess");
}


- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
     BUD_Log(@"interstitialAd data load fail");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
