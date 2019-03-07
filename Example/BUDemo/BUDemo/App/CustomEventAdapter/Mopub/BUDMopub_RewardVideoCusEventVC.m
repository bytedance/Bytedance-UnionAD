//
//  BUDMopub_RewardVideoCusEventVC.m
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/10/22.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDMopub_RewardVideoCusEventVC.h"
#import <BUAdSDK/BURewardedVideoAd.h>
#import "MPRewardedVideo.h"
#import "BUDMopub_RewardedVideoCustomEvent.h"
#import "BUDNormalButton.h"
#import "BUDMacros.h"

static NSString * const MopubADUnitID = @"e1cbce0838a142ec9bc2ee48123fd470";

@interface BUDMopub_RewardVideoCusEventVC ()<MPRewardedVideoDelegate>
@property (nonatomic, strong) UIButton *button;
@end

@implementation BUDMopub_RewardVideoCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpRewardVideo];
}

- (void)setUpRewardVideo {    
    [MPRewardedVideo setDelegate:self forAdUnitId:MopubADUnitID];
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:MopubADUnitID withMediationSettings:@[@"1",@"a"]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

#pragma mark 延迟加载
- (UIButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:@"展示激励视频" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

# pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        BUD_Log(@"取消");
    } else if (buttonIndex == 1){
        [self.view addSubview:self.button];
    }
    BUD_Log(@"%ld", (long)buttonIndex);
}

#pragma mark 事件处理
- (void)buttonTapped:(id)sender {
    BOOL isvalid = [MPRewardedVideo hasAdAvailableForAdUnitID:MopubADUnitID];
    if (isvalid) {
        [MPRewardedVideo presentRewardedVideoAdForAdUnitID:MopubADUnitID fromViewController:self withReward:nil];
    }
}


#pragma mark - MPRewardedVideoDelegate

- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID {
    if ([adUnitID isEqualToString:MopubADUnitID]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"视频加载成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    BUD_Log(@"%s", __func__);
}


- (void)rewardedVideoAdDidFailToLoadForAdUnitID:(NSString *)adUnitID error:(NSError *)error {
    BUD_Log(@"%s", __func__);
}


- (void)rewardedVideoAdDidExpireForAdUnitID:(NSString *)adUnitID {
    BUD_Log(@"%s", __func__);
}


- (void)rewardedVideoAdDidFailToPlayForAdUnitID:(NSString *)adUnitID error:(NSError *)error {
    BUD_Log(@"%s", __func__);
}


- (void)rewardedVideoAdWillAppearForAdUnitID:(NSString *)adUnitID {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidAppearForAdUnitID:(NSString *)adUnitID {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdWillDisappearForAdUnitID:(NSString *)adUnitID {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidDisappearForAdUnitID:(NSString *)adUnitID {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidReceiveTapEventForAdUnitID:(NSString *)adUnitID {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdWillLeaveApplicationForAdUnitID:(NSString *)adUnitID {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdShouldRewardForAdUnitID:(NSString *)adUnitID reward:(MPRewardedVideoReward *)reward {
    BUD_Log(@"%s", __func__);
}
@end
