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
    [self.button setTitle:@"展示插屏" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
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

/**
 BUInterstitialAd 广告加载成功
 
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd {
    NSLog(@"[插屏广告] 物料加载成功");
}

/**
 BUInterstitialAd 加载失败
 
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 - Parameter error: 包含详细是失败信息.
 */
- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"[插屏广告] 物料加载失败");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
