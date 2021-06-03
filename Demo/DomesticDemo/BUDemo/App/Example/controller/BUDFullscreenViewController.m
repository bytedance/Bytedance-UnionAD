//
//  BUDFullscreenViewController.m
//  BUDemo
//
//  Created by lee on 2018/8/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDFullscreenViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"

@interface BUDFullscreenViewController () <BUFullscreenVideoAdDelegate>
@property (nonatomic, strong) BUFullscreenVideoAd *fullscreenVideoAd;
@property (nonatomic, strong) BUDSelectedView *selectedView;
@end

@implementation BUDFullscreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;

    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_fullscreen_ID,@"title":[NSString localizedStringForKey:Vertical]}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_fullscreen_landscape_ID,@"title":[NSString localizedStringForKey:Horizontal]}];
    NSArray *titlesAndIDS = @[@[item1,item2]];
    
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"FullScreenVideo Ad" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
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
// important:----- Every time the data is requested, a new one BUFullscreenVideoAd needs to be initialized. Duplicate request data by the same full screen video ad is not allowed.
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:slotID];
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
    
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showFullscreenVideoAd {
    if (self.fullscreenVideoAd) {
        [self.fullscreenVideoAd showAdFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma mark BURewardedVideoAdDelegate
- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    self.selectedView.promptStatus = BUDPromptStatusAdVideoLoadedSuccess;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error{
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAdDidVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAdWillClose:(BUFullscreenVideoAd *)fullscreenVideoAd{
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)fullscreenVideoAdCallback:(BUFullscreenVideoAd *)fullscreenVideoAd withType:(BUFullScreenVideoAdType)fullscreenVideoAdType{
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUFullscreenVideoAd In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}


@end
