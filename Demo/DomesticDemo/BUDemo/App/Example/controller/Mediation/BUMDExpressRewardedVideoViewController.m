//
//  BUMDExpressRewardedVideoViewController.m
//  BUDemo
//
//  Created by ByteDance on 2022/10/19.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDExpressRewardedVideoViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"
#import "BUMDRewardedVideoAgainDelegateObj.h"

@interface BUMDExpressRewardedVideoViewController () <BUMNativeExpressRewardedVideoAdDelegate>

@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedVideoAd;
@property (nonatomic, strong) BUDSelectedView *selectedView;
//optional
@property (nonatomic, strong) BUMDRewardedVideoAgainDelegateObj *rewardedVideoAgainDelegateObj;
@end

@implementation BUMDExpressRewardedVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    NSArray *titlesAndIDS = nil;

    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":gromore_reward_ID,@"title":[NSString localizedStringForKey:Vertical]}];
    titlesAndIDS = @[@[item1]];

    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:self.adName SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
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

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadRewardVideoAdWithSlotID:(NSString *)slotID {
    BUAdSlot *adslot = [[BUAdSlot alloc] init];
    adslot.ID = slotID;
    // [可选]配置：设置是否静音
    adslot.mediation.mutedIfCan = NO;
    // [可选]配置：配置场景ID
    adslot.mediation.scenarioID = @"123321";
    // [可选]配置：设置奖励信息
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    model.rewardName = @"rewardName";
    model.rewardAmount = 100;

    self.rewardedVideoAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlot:adslot rewardedVideoModel:model];
    // 配置：回调代理对象。不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    self.rewardedVideoAd.delegate = self;
    // [可选]配置：激励再得的回调
    self.rewardedVideoAd.rewardPlayAgainInteractionDelegate = self.rewardedVideoAgainDelegateObj;
    
    [self.rewardedVideoAd loadAdData];
    
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showRewardVideoAd {
    if (self.rewardedVideoAd) {
        [self.rewardedVideoAd showAdFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    
    BUD_Log(@"waterfallFillFailMessages-%@",self.rewardedVideoAd.mediation.waterfallFillFailMessages);
    BUD_Log(@"getAdLoadInfoList-%@",self.rewardedVideoAd.mediation.getAdLoadInfoList);
    BUD_Log(@"getShowEcpmInfo-%@",self.rewardedVideoAd.mediation.getShowEcpmInfo);
    BUD_Log(@"getCurrentBestEcpmInfo-%@",self.rewardedVideoAd.mediation.getCurrentBestEcpmInfo);
    BUD_Log(@"multiBiddingEcpmInfos-%@",self.rewardedVideoAd.mediation.multiBiddingEcpmInfos);
    BUD_Log(@"cacheRitList-%@",self.rewardedVideoAd.mediation.cacheRitList);
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BUMDRewardedVideoAgainDelegateObj *)rewardedVideoAgainDelegateObj {
    if (!_rewardedVideoAgainDelegateObj) {
        _rewardedVideoAgainDelegateObj = [[BUMDRewardedVideoAgainDelegateObj alloc] init];
    }
    return _rewardedVideoAgainDelegateObj;;
}

#pragma mark - BUMNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    BUD_Log(@"%st",__func__);
    BUD_Log(@"mediaExt-%@",rewardedVideoAd.mediaExt);
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdVideoLoadedSuccess;
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidShowFailed:(BUNativeExpressRewardedVideoAd *_Nonnull)rewardedVideoAd error:(NSError *_Nonnull)error{
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    // 展示后可获取信息如下
    BUD_Log(@"%@", [rewardedVideoAd.mediation getShowEcpmInfo]);
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd; {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    BUD_Log(@"%s",__func__);
    BUD_Log(@"verify-%@",verify?@"true":@"false");
    BUD_Log(@"rewardInfo.userId-%@",self.rewardedVideoAd.rewardedVideoModel.userId);
    BUD_Log(@"rewardInfo.rewardName-%@",self.rewardedVideoAd.rewardedVideoModel.rewardName);
    BUD_Log(@"rewardInfo.rewardAmount-%ld",(long)self.rewardedVideoAd.rewardedVideoModel.rewardAmount);
    BUD_Log(@"rewardInfo.rewardId-%@",self.rewardedVideoAd.rewardedVideoModel.mediation.rewardId);
    BUD_Log(@"rewardInfo.tradeId-%@",self.rewardedVideoAd.rewardedVideoModel.mediation.tradeId);
    BUD_Log(@"rewardInfo.adnName-%@",self.rewardedVideoAd.rewardedVideoModel.mediation.adnName);
    BUD_Log(@"rewardInfo verifyByGroMoreS2S-%@",self.rewardedVideoAd.rewardedVideoModel.mediation.verifyByGroMoreS2S?@"true":@"false");
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    NSInteger errorCode = error.code;
    NSString *errorMsg = error.userInfo[NSLocalizedDescriptionKey];
    BUD_Log(@"%s error = %@",__func__,error);
}

@end

