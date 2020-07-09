//
//  MPPangleRewardVC.m
//  BUDemo
//
//  Created by wangyanlin on 2020/5/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MPPangleRewardVC.h"
#import <mopub-ios-sdk/MPRewardedVideo.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDSelectedView.h"


/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface MPPangleRewardVC ()<MPRewardedVideoDelegate>
@property (nonatomic, strong) BUDSelectedView *selectedView;

@end

@implementation MPPangleRewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_reward_ID,@"title":[NSString localizedStringForKey:Vertical]}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_reward_landscape_ID,@"title":[NSString localizedStringForKey:Horizontal]}];
    NSArray *titlesAndIDS = @[@[item1,item2]];

    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Reward Ad" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
          __strong typeof(self) strongself = weakself;
          [strongself setUpRewardVideoWithSlotId:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        strongself.selectedView.promptStatus = BUDPromptStatusDefault;
        BOOL isvalid = [MPRewardedVideo hasAdAvailableForAdUnitID:mopub_official_reward_UnitID];
        if (isvalid) {
            [MPRewardedVideo presentRewardedVideoAdForAdUnitID:mopub_official_reward_UnitID fromViewController:self withReward:nil];
        }
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;

}

- (void)setUpRewardVideoWithSlotId:(NSString *)slotId {
    [MPRewardedVideo setDelegate:self forAdUnitId:mopub_official_reward_UnitID];
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:mopub_official_reward_UnitID keywords:nil userDataKeywords:nil location:nil customerId:nil mediationSettings:@[@"1",@"a"] localExtras:@{@"ad_placement_id":slotId}];
}


#pragma mark - MPRewardedVideoDelegate
- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
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
