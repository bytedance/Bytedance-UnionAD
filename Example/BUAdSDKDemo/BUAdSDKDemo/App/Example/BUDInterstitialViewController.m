//
//  BUDInterstitialViewController.m
//  BUDemo
//
//  Created by carl on 2017/7/31.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDInterstitialViewController.h"
#import <BUAdSDK/BUInterstitialAd.h>
#import <UIKit/NSLayoutConstraint.h>
#import <BUAdSDK/BUSize.h>

@interface BUDInterstitialViewController () <BUInterstitialAdDelegate>
@property (nonatomic, strong) BUInterstitialAd *interstitialAd;
@property (nonatomic, strong) UIButton *button;
@end

@implementation BUDInterstitialViewController

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
    
    self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:self.viewModel.slotID size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)buttonTapped:(UIButton *)sender {
    [self.interstitialAd showAdFromRootViewController:self.navigationController];
}

- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd {
    [self.interstitialAd loadAdData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
