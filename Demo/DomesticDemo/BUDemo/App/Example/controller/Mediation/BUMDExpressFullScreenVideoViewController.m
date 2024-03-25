//
//  BUMDExpressFullScreenVideoViewController.m
//  BUDemo
//
//  Created by ByteDance on 2022/10/17.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDExpressFullScreenVideoViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"

@interface BUMDExpressFullScreenVideoViewController ()<BUMNativeExpressFullscreenVideoAdDelegate>
@property (nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd *fullscreenAd;
@end

@implementation BUMDExpressFullScreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    NSArray *titlesAndIDS;
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":gromore_newInterstitial_ID,@"title":[NSString localizedStringForKey:@"newInterstitial"]}];
    titlesAndIDS = @[@[item1]];
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:self.adName SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself loadFullscreenVideoAdWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        [strongself showFullscreenVideoAd];
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadFullscreenVideoAdWithSlotID:(NSString *)slotID {
    // 初始化广告加载对象
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = slotID;
    // [可选]配置：静音
    slot.mediation.mutedIfCan = YES;
    self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlot:slot];
    // 配置：回调代理对象。不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    self.fullscreenAd.delegate = self;
    // [可选]配置：设置奖励信息，仅支持GDT
    self.fullscreenAd.mediation.rewardModel = ({
        BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
        model.userId = @"xxxx";
        model.rewardName = @"金币";
        model.rewardAmount = 1000;
        model.extra = @"{}";
        model;
    });
    
    // 开始加载广告
    [self.fullscreenAd loadAdData];
    
    //为保证播放流畅建议可在收到视频下载完成回调后再展示视频。
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

// important:show的时候会进行WKWebview的渲染，建议一次最多展示三个广告，如果超过3个会很大概率导致WKWebview渲染失败。当然一般情况下全屏视频一次只会show一个
- (void)showFullscreenVideoAd {
    if (self.fullscreenAd) {
        [self.fullscreenAd showAdFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma mark - BUMNativeExpressFullscreenVideoAdDelegate
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"%@", error]];
}

- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"%@", error]];
}

- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdVideoLoadedSuccess;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    // 展示后可获取信息如下
    BUD_Log(@"%@", [fullscreenVideoAd.mediation getShowEcpmInfo]);
}

- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType) nativeExpressVideoAdType{
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdDidCloseOtherController:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressFullscreenVideoAdServerRewardDidSucceed:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd verify:(BOOL)verify {
    // 验证信息
    BUD_Log(@"verify: %@", verify ? @"YES" : @"NO");
}

- (void)nativeExpressFullscreenVideoAdServerRewardDidFail:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd error:(NSError *)error {
    [self pbud_logWithSEL:_cmd msg:@""];
}

#pragma mark - Log
- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUNativeExpressFullscreenVideoAd In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
@end

