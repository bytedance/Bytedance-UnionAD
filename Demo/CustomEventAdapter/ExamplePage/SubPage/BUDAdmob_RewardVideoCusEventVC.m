//
//  BUDAdmob_RewardVideoCusEventVC.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/13.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardVideoCusEventVC.h"
#import <GoogleMobileAds/GADRewardedAd.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDAdmob_RewardVideoCusEventVC ()<GADRewardedAdDelegate>
@property (nonatomic, strong) GADRewardedAd *rewardVideoAd;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation BUDAdmob_RewardVideoCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"RewardVideo";
    
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
    self.rewardVideoAd = [[GADRewardedAd alloc] initWithAdUnitID:@"ca-app-pub-2547387438729744/1033769165"];
    GADRequest *request = [GADRequest request];
    __weak typeof(self) weakself = self;
    [self.rewardVideoAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
        __strong typeof(self) strongself = weakself;
        if (error) {
            strongself.statusLabel.text = @"Ad loaded fail";
        } else {
            strongself.statusLabel.text = @"Ad loaded";
        }
    }];
}

- (void)showAd:(UIButton *)sender {
    if (self.rewardVideoAd.isReady) {
        [self.rewardVideoAd presentFromRootViewController:self.navigationController delegate:self];
    }
}


#pragma mark GADRewardedAdDelegate
/// Tells the delegate that the user earned a reward.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd userDidEarnReward:(GADAdReward *)reward {
  // TODO: Reward the user.
  
}

/// Tells the delegate that the rewarded ad was presented.
- (void)rewardedAdDidPresent:(GADRewardedAd *)rewardedAd {
  
}

/// Tells the delegate that the rewarded ad failed to present.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd didFailToPresentWithError:(NSError *)error {
  
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)rewardedAdDidDismiss:(GADRewardedAd *)rewardedAd {
    
}
@end
