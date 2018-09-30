//
//  BUAInterstitialViewController.m
//  BUAemo
//
//  Created by carl on 2017/7/31.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUAInterstitialViewController.h"
#import <WMAdSDK/WMInterstitialAd.h>
#import <UIKit/NSLayoutConstraint.h>
#import <WMAdSDK/WMSize.h>

@interface BUAInterstitialViewController () <WMInterstitialAdDelegate>
@property (nonatomic, strong) WMInterstitialAd *interstitialAd;
@property (nonatomic, strong) UIButton *button;
@end

@implementation BUAInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    
    const CGFloat buttonHeight = 36;
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.button.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [self.button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [self.button.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [self.button.heightAnchor constraintEqualToConstant:buttonHeight];
    } else {
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        self.button.frame = CGRectMake(0, height - buttonHeight,width , buttonHeight);
    }
    
    [self.button setBackgroundColor:[UIColor orangeColor]];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:@"展示插屏" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    self.interstitialAd = [[WMInterstitialAd alloc] initWithSlotID:self.viewModel.slotID size:[WMSize sizeBy:WMProposalSize_Interstitial600_600]];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)buttonTapped:(UIButton *)sender {
    [self.interstitialAd showAdFromRootViewController:self.navigationController];
}

- (void)interstitialAdDidClose:(WMInterstitialAd *)interstitialAd {
    [self.interstitialAd loadAdData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
