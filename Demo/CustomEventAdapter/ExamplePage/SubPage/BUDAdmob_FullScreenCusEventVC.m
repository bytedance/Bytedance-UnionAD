//
//  BUDAdmob_FullScreenCusEventVC.m
//  BUDemo
//
//  Created by wangyanlin on 2020/3/10.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_FullScreenCusEventVC.h"
#import <GoogleMobileAds/GADInterstitial.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDAdmob_FullScreenCusEventVC ()<GADInterstitialDelegate>
@property(nonatomic, strong) GADInterstitial *fullscreenVideoAd;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation BUDAdmob_FullScreenCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"FullScreenVideo";
    
    _statusLabel = [[UILabel alloc]init];
    [_statusLabel setFont:[UIFont systemFontOfSize:16]];
    [_statusLabel setTextColor:[UIColor redColor]];
    [_statusLabel setTextAlignment:NSTextAlignmentCenter];
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _statusLabel.text = @"Tap left button to load Ad";
    [self.view addSubview:_statusLabel];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_statusLabel]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[_statusLabel(25)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    
    UIButton *loadAd = [UIButton buttonWithType:UIButtonTypeSystem];
    loadAd.layer.borderWidth = 0.5;
    loadAd.layer.cornerRadius = 8;
    loadAd.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loadAd.translatesAutoresizingMaskIntoConstraints = NO;
    [loadAd addTarget:self action:@selector(loadAd:) forControlEvents:UIControlEventTouchUpInside];
    [loadAd setTitle:@"Load AD" forState:UIControlStateNormal];
    [loadAd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:loadAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[loadAd]-170-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loadAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_statusLabel]-20-[loadAd(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel,loadAd)]];
    
    UIButton *showAd = [UIButton buttonWithType:UIButtonTypeSystem];
    showAd.layer.cornerRadius = 8;
    showAd.translatesAutoresizingMaskIntoConstraints = NO;
    [showAd addTarget:self action:@selector(showAd:) forControlEvents:UIControlEventTouchUpInside];
    [showAd setTitle:@"showAd" forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [showAd setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:showAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[showAd(80)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(showAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_statusLabel]-20-[showAd(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel,showAd)]];
}

- (void)loadAd:(UIButton *)sender {
    self.fullscreenVideoAd = [[GADInterstitial alloc]
                         initWithAdUnitID:@"ca-app-pub-2547387438729744/4725602169"];
    self.fullscreenVideoAd.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.fullscreenVideoAd loadRequest:request];
}

- (void)showAd:(UIButton *)sender {
    if (self.fullscreenVideoAd.isReady) {
        [self.fullscreenVideoAd presentFromRootViewController:self];
    }
}

#pragma mark GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
    _statusLabel.text = @"Ad loaded";
}

- (void)interstitial:(nonnull GADInterstitial *)ad didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    
}

- (void)interstitialWillPresentScreen:(nonnull GADInterstitial *)ad {
    
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    
}

- (void)interstitialDidDismissScreen:(nonnull GADInterstitial *)ad {
    
}

@end
