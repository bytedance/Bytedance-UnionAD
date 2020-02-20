//
//  BUDAdmob_RewardExpressCusEventVC.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/26.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardExpressCusEventVC.h"
#import <GoogleMobileAds/GADRewardBasedVideoAd.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDAdmob_RewardExpressCusEventVC ()<GADRewardBasedVideoAdDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) GADRewardBasedVideoAd *rewardVideoAd;
@end

@implementation BUDAdmob_RewardExpressCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.button];
    self.button.isValid = NO;
    [self loadRewardVideo];
}

- (void)loadRewardVideo {
    self.rewardVideoAd = [[GADRewardBasedVideoAd alloc] init];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadRequest:[GADRequest request] withAdUnitID:admob_expressReward_UnitID];
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
    [self.rewardVideoAd presentFromRootViewController:self.navigationController];
    self.button.isValid = NO;
}

#pragma mark GADRewardBasedVideoAdDelegate
- (void)rewardBasedVideoAd:(nonnull GADRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(nonnull GADAdReward *)reward {
    BUD_Log(@"%s", __func__);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"reawrded data load success";
    [hud hideAnimated:YES afterDelay:2];
    self.button.isValid = YES;
    BUD_Log(@"%s", __func__);
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    [self loadRewardVideo];
    BUD_Log(@"%s", __func__);
}

@end
