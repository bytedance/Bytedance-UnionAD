//
//  BUDAdmob_RewardVideoCusEventVC.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/13.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardVideoCusEventVC.h"
#import <BUAdSDK/BURewardedVideoAd.h>
#import <GoogleMobileAds/GADRewardedAd.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDAdmob_RewardVideoCusEventVC ()<GADRewardedAdDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) GADRewardedAd *rewardVideoAd;
@end

@implementation BUDAdmob_RewardVideoCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.button];
    self.button.isValid = NO;
    [self loadRewardVideo];

}

- (void)loadRewardVideo {
    self.rewardVideoAd = [[GADRewardedAd alloc] initWithAdUnitID:admob_reward_UnitID];
    GADRequest *request = [GADRequest request];
    __weak typeof(self) weakself = self;
    [self.rewardVideoAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
        __strong typeof(self) strongself = weakself;
        if (error) {
            // Handle ad failed to load case.
            BUD_Log(@"%s", __func__);
        } else {
            // Ad successfully loaded.
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.offset = CGPointMake(0, -100);
            hud.label.text = @"reawrded data load success";
            [hud hideAnimated:YES afterDelay:2];
            strongself.button.isValid = YES;
        }
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark 延迟加载
- (UIButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:[NSString localizedStringForKey:ShowRewardVideo] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark 事件处理
- (void)buttonTapped:(id)sender {
    [self.rewardVideoAd presentFromRootViewController:self.navigationController delegate:self];
    self.button.isValid = NO;
}

#pragma mark GADRewardedAdDelegate
/// Tells the delegate that the user earned a reward.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd userDidEarnReward:(GADAdReward *)reward {
  // TODO: Reward the user.
  BUD_Log(@"%s", __func__);
}

/// Tells the delegate that the rewarded ad was presented.
- (void)rewardedAdDidPresent:(GADRewardedAd *)rewardedAd {
  BUD_Log(@"%s", __func__);
}

/// Tells the delegate that the rewarded ad failed to present.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd didFailToPresentWithError:(NSError *)error {
  BUD_Log(@"%s", __func__);
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)rewardedAdDidDismiss:(GADRewardedAd *)rewardedAd {
    BUD_Log(@"%s", __func__);
    [self loadRewardVideo];
}
@end
