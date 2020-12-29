//
//  BUDExpressRewardedVideoViewController.m
//  BUDemo
//
//  Created by Bytedance on 2019/7/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressRewardedVideoViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"

@interface BUDExpressRewardedVideoViewController ()<BUNativeExpressRewardedVideoAdDelegate>
@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedAd;
@property (nonatomic, strong) BUDSelectedView *selectedView;
@end

@implementation BUDExpressRewardedVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *verticalTitle = [NSString localizedStringForKey:Vertical];
    NSString *horizontalTitle = [NSString localizedStringForKey:Horizontal];
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_reward_ID_both,@"title":[NSString stringWithFormat:@"%@-both",verticalTitle]}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_reward_landscape_ID_both,@"title":[NSString stringWithFormat:@"%@-both",horizontalTitle]}];
    NSArray *titlesAndIDS = @[@[item1,item2]];
    
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Express RewardVideo" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
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
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    self.rewardedAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:slotID rewardedVideoModel:model];
    self.rewardedAd.delegate = self;
    [self.rewardedAd loadAdData];
    
    //为保证播放流畅建议可在收到视频下载完成回调后再展示视频。
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

// important: show的时候会进行WKWebview的渲染，建议一次最多展示三个广告，如果超过3个会很大概率导致WKWebview渲染失败。当然一般情况下激励视频一次只会show一个
- (void)showRewardVideoAd {
    if (self.rewardedAd) {
        [self.rewardedAd showAdFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}


#pragma mark - BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"%@", error]];
}

- (void)nativeExpressRewardedVideoAdCallback:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd withType:(BUNativeExpressRewardedVideoAdType)nativeExpressVideoType{
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdVideoLoadedSuccess;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"%@", error]];
}

- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"%@", error]];
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"verify:%@ rewardName:%@ rewardMount:%ld",verify?@"true":@"false",rewardedVideoAd.rewardedVideoModel.rewardName,(long)rewardedVideoAd.rewardedVideoModel.rewardAmount]];
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError * _Nullable)error {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"rewardName:%@ rewardMount:%ld error:%@",rewardedVideoAd.rewardedVideoModel.rewardName,(long)rewardedVideoAd.rewardedVideoModel.rewardAmount,error]];
}

- (void)nativeExpressRewardedVideoAdDidCloseOtherController:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    [self pbud_logWithSEL:_cmd msg:str];
}
#pragma mark - Log
- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUNativeExpressRewardedVideoAd In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
@end
