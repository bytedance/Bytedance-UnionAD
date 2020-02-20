//
//  BUDMopub_ExpressRewardVideoCusEventVC.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDMopub_ExpressRewardVideoCusEventVC.h"
#import <mopub-ios-sdk/MPRewardedVideo.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface BUDMopub_ExpressRewardVideoCusEventVC ()<MPRewardedVideoDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@end

@implementation BUDMopub_ExpressRewardVideoCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.button];
    self.button.isValid = NO;
    [self setUpRewardVideo];
}

- (void)setUpRewardVideo {
    [MPRewardedVideo setDelegate:self forAdUnitId:mopub_expressReward_UnitID];
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:mopub_expressReward_UnitID withMediationSettings:@[@"1",@"a"]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

#pragma mark 延迟加载
- (BUDNormalButton *)button {
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
    BOOL isvalid = [MPRewardedVideo hasAdAvailableForAdUnitID:mopub_expressReward_UnitID];
    if (isvalid) {
        [MPRewardedVideo presentRewardedVideoAdForAdUnitID:mopub_expressReward_UnitID fromViewController:self withReward:nil];
    }
    self.button.isValid = NO;
}

#pragma mark - MPRewardedVideoDelegate
- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"reawrded data load success";
    [hud hideAnimated:YES afterDelay:2];
    self.button.isValid = YES;
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
    [self setUpRewardVideo];
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
