//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDInterstitialViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"
#import <PAGAdSDK/PAGAdSDK.h>

@interface BUDInterstitialViewController ()<PAGLInterstitialAdDelegate>
@property (nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) PAGLInterstitialAd *interstitialAd;
@end

@implementation BUDInterstitialViewController

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
    PAGInterstitialRequest *request = [[PAGInterstitialRequest alloc] init];
    [PAGLInterstitialAd loadAdWithSlotID:slotID request:request completionHandler:^(PAGLInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        self.interstitialAd = interstitialAd;
        self.interstitialAd.delegate = self;
        if (!error) {
            self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
        } else {
            self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
        }
    }];
    
    //为保证播放流畅建议可在收到视频下载完成回调后再展示视频。
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

// important:show的时候会进行WKWebview的渲染，建议一次最多展示三个广告，如果超过3个会很大概率导致WKWebview渲染失败。当然一般情况下全屏视频一次只会show一个
- (void)showFullscreenVideoAd {
    if (self.interstitialAd) {
        [self.interstitialAd presentFromRootViewController:self];
    }
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)adDidShow:(id<PAGAdProtocol>)ad {
    
}

- (void)adDidClick:(id<PAGAdProtocol>)ad {
    
}

- (void)adDidDismiss:(id<PAGAdProtocol>)ad {
    
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
