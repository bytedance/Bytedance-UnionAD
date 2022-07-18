//
//  BUDSlotABViewController.m
//  BUDemo
//
//  Created by shenqichen on 2021/11/2.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDSlotABViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"

@interface BUDSlotABViewController ()
<
BUNativeExpresInterstitialAdDelegate,
BUNativeExpressFullscreenVideoAdDelegate
>

@property (nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;
@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd *fullscreenAd;
@property (nonatomic, copy) NSString *slotId;
@property (nonatomic, assign) BUAdSlotAdType slotType;

@end


@implementation BUDSlotABViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;

    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"20002",@"title":@"旧插屏-新插屏"}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"20001",@"title":@"Banner-信息流"}];
    NSArray *titlesAndIDS = @[@[item1,item2]];
    
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Slot AB Test" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable codeGroup) {
        __strong typeof(self) strongself = weakself;
        [strongself loadSlot:codeGroup.integerValue];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        BUAdSlotAdType slotType = strongself.slotType;
        if (slotType == BUAdSlotAdTypeInterstitial) {
            [strongself showInterstitial];
        } else if (slotType == BUAdSlotAdTypeFullscreenVideo) {
            [strongself showFullscreenVideoAd];
        } else {
            [self pbud_logWithSEL:_cmd msg:@"illegal action"];
        }
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma mark -
#define BUDefaultFullscreenSlotID express_full_ID_both

- (void)loadSlot:(NSInteger)codeGroupId {
    // 详细接入可参照Demo中的BUDSlotABViewController类
    [[BUSlotABManager sharedInstance] fetchSlotWithCodeGroupId:codeGroupId
                                                    completion:^(NSString *slotId, BUAdSlotAdType slotType, NSError *error) {
        if (error != nil ||
            (slotType != BUAdSlotAdTypeInterstitial &&
            slotType != BUAdSlotAdTypeFullscreenVideo)) {
            // 无效返回, 使用客户端默认配置兜底
            self.slotType = BUAdSlotAdTypeFullscreenVideo;
            self.slotId = BUDefaultFullscreenSlotID;
        } else {
            self.slotType = slotType;
            self.slotId = slotId;
        }
        
        if (self.slotType == BUAdSlotAdTypeInterstitial) {
            // 旧插屏广告的加载流程, 可参考对应广告的接入文档
            [self loadInterstitialWithSlotID:self.slotId];
        } else if (self.slotType == BUAdSlotAdTypeFullscreenVideo) {
            // 新插屏广告加载流程, 可参考对应广告的接入文档
            [self loadFullscreenVideoAdWithSlotID:self.slotId];
        }
        
        [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"slotId:%@|slotType:%ld|error:%@", slotId, slotType, error]];
    }];
}

#pragma mark - test
- (void)loadInterstitialWithSlotID:(NSString *)slotID {
    CGSize size = CGSizeMake(300, 300);
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)-40;
    CGFloat height = width/size.width*size.height;
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:slotID adSize:CGSizeMake(width, height)];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showInterstitial {
    if (self.interstitialAd) {
        [self.interstitialAd showAdFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)loadFullscreenVideoAdWithSlotID:(NSString *)slotID {
    self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:slotID];
    self.fullscreenAd.delegate = self;
    [self.fullscreenAd loadAdData];
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showFullscreenVideoAd {
    if (self.fullscreenAd) {
        [self.fullscreenAd showAdFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma ---BUNativeExpresInterstitialAdDelegate
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    self.interstitialAd = nil;
}

- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
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
    BUD_Log(@"SDKDemoDelegate SlotAB In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
@end
