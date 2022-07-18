//
//  BUDExpressFullScreenVideoViewController.m
//  BUDemo
//
//  Created by Bytedance on 2019/7/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressFullScreenVideoViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"

@interface BUDExpressFullScreenVideoViewController ()<BUNativeExpressFullscreenVideoAdDelegate>
@property (nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd *fullscreenAd;
@end

@implementation BUDExpressFullScreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    NSString *verticalTitle = [NSString localizedStringForKey:Vertical];
    NSString *horizontalTitle = [NSString localizedStringForKey:Horizontal];
    NSArray *titlesAndIDS;
    if (self.isInterstitialAd) {
        BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_new_interstitial_full,@"title":[NSString localizedStringForKey:kNewInterstitialfull]}];
        BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_new_interstitial_half,@"title":[NSString localizedStringForKey:kNewInterstitialhalf]}];
        titlesAndIDS = @[@[item1,item2]];
    } else {
        BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_full_ID_both,@"title":[NSString stringWithFormat:@"%@-both",verticalTitle]}];
        BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_full_landscape_ID_both,@"title":[NSString stringWithFormat:@"%@-both",horizontalTitle]}];
        titlesAndIDS = @[@[item1,item2]];
    }
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

- (void)loadFullscreenVideoAdWithSlotID:(NSString *)slotID {
    self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:slotID];
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    self.fullscreenAd.delegate = self;
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

#pragma mark - BUNativeExpressFullscreenVideoAdDelegate
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
    BUD_Log(@"SDKDemoDelegate BUNativeExpressFullscreenVideoAd In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
@end
