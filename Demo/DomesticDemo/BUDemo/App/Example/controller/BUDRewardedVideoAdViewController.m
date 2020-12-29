//
//  BUDRewardedVideoAdViewController.m
//  BUDemo
//
//  Created by gdp on 2018/1/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDRewardedVideoAdViewController.h"
#import <BUAdSDK/BURewardedVideoAd.h>
#import <BUAdSDK/BURewardedVideoModel.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"

@interface BUDRewardedVideoAdViewController () <BURewardedVideoAdDelegate>
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@property (nonatomic, strong) BUDSelectedView *selectedView;
@end

@implementation BUDRewardedVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_reward_ID,@"title":[NSString localizedStringForKey:Vertical]}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_reward_landscape_ID,@"title":[NSString localizedStringForKey:Horizontal]}];
    NSArray *titlesAndIDS = @[@[item1,item2]];
    
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"RewardVideo" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
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
// important: Every time the data is requested, a new one BURewardedVideoAd needs to be initialized. Duplicate request data by the same full screen video ad is not allowed.
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
//    model.userId = @"123";
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:slotID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    
    [self.rewardedVideoAd loadAdData];
    
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showRewardVideoAd {
    if (self.rewardedVideoAd) {
        [self.rewardedVideoAd showAdFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma mark - BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    BUD_Log(@"%st",__func__);
    BUD_Log(@"mediaExt-%@",rewardedVideoAd.mediaExt);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdVideoLoadedSuccess;
    BUD_Log(@"%s",__func__);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd{
    BUD_Log(@"%s",__func__);
}

- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd{
    BUD_Log(@"%s",__func__);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    BUD_Log(@"%s",__func__);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd error:(nonnull NSError *)error {
    BUD_Log(@"%s error = %@",__func__,error);
}

- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd{
    BUD_Log(@"%s",__func__);

}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    BUD_Log(@"%s",__func__);
    BUD_Log(@"%@",[NSString stringWithFormat:@"verify:%@ rewardName:%@ rewardMount:%ld",verify?@"true":@"false",rewardedVideoAd.rewardedVideoModel.rewardName,(long)rewardedVideoAd.rewardedVideoModel.rewardAmount]);
}
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType{
    BUD_Log(@"%s",__func__);
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
@end
