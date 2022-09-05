//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDRewardedViewController.h"
#import <PAGAdSDK/PAGRewardedAdDelegate.h>
#import <PAGAdSDK/PAGRewardedAd.h>
#import "BUDSlotID.h"
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "UIColor+DarkMode.h"
#import <PAGAdSDK/PAGRewardModel.h>

@interface BUDRewardedViewController () <PAGRewardedAdDelegate>

@property (nonatomic, strong) PAGRewardedAd *rewardedAd;
@property (nonatomic, strong) BUDSelectedView *selectedView;

@end

@implementation BUDRewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;

    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_reward_ID_both,@"title":[NSString localizedStringForKey:Vertical]}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_reward_landscape_ID_both,@"title":[NSString localizedStringForKey:Horizontal]}];
    NSArray *titlesAndIDS = @[@[item1,item2]];
    
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Rewarded" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself loadRewardVideoAdWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        [strongself showRewardVideoAd];
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)loadRewardVideoAdWithSlotID:(NSString *)slotID {
    self.selectedView.promptStatus = BUDPromptStatusLoading;
    __weak typeof(self) weakself = self;
    [PAGRewardedAd loadAdWithSlotID:slotID request:[PAGRewardedRequest request] completionHandler:^(PAGRewardedAd * _Nullable rewardedAd, NSError * _Nullable error) {
        if (!weakself) {
            return;
        }
        __strong typeof(weakself) self = weakself;
        self.rewardedAd = rewardedAd;
        self.rewardedAd.delegate = self;
        if (error) {
            [self _logWithSEL:_cmd msg:[NSString stringWithFormat:@"load rewardedAd failed: %@",error.localizedDescription]];
            self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
            return;
        }
        
        [self _logWithSEL:_cmd msg:@"load rewardedAd successed"];
        self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    }];
    self.selectedView.promptStatus = BUDPromptStatusLoading;
    
}

- (void)showRewardVideoAd {
    if (self.rewardedAd) {
        [self.rewardedAd presentFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"BUDRewardedViewController | %@ | %@", NSStringFromSelector(sel), msg);
}

#pragma mark - PAGRewardedAdDelegate

- (void)adDidShow:(PAGRewardedAd *)ad {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)adDidClick:(PAGRewardedAd *)ad {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)adDidDismiss:(PAGRewardedAd *)ad {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)rewardedAd:(PAGRewardedAd *)rewardedAd userDidEarnReward:(PAGRewardModel *)rewardModel {
    [self _logWithSEL:_cmd msg:[NSString stringWithFormat:@"rewardName:%@ rewardMount:%ld",rewardModel.rewardName,(long)rewardModel.rewardAmount]];
}

- (void)rewardedAd:(PAGRewardedAd *)rewardedAd userEarnRewardFailWithError:(NSError *)error {
    [self _logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@",error]];
}

@end
