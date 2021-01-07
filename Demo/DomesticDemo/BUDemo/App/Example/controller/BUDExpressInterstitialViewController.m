//
//  BUDExpressInterstitialViewController.m
//  BUDemo
//
//  Created by xxx on 2019/5/15.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressInterstitialViewController.h"
#import <BUAdSDK/BUNativeExpressInterstitialAd.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUSize.h>
#import "NSString+LocalizedString.h"
#import "BUDSelectedView.h"

@interface BUDExpressInterstitialViewController ()<BUNativeExpresInterstitialAdDelegate>
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;
@property (nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, copy) NSDictionary *sizeDict;
@property (strong, nonatomic) BUDSwitchView *slotSwitchView;
@end

@implementation BUDExpressInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.haveRenderSwitchView = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.sizeDict = @{
                      express_interstitial_ID_1_1_both:[NSValue valueWithCGSize:CGSizeMake(300, 300)],
                      express_interstitial_ID_2_3_both:[NSValue valueWithCGSize:CGSizeMake(300, 450)],
                      express_interstitial_ID_3_2_both:[NSValue valueWithCGSize:CGSizeMake(300, 200)],
                      };
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_interstitial_ID_1_1_both,@"title":@"1:1-both"}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_interstitial_ID_2_3_both,@"title":@"2:3-both"}];
    BUDSelcetedItem *item3 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_interstitial_ID_3_2_both,@"title":@"3:2-both"}];
    NSArray *titlesAndIDS = @[@[item1,item2,item3]];
    
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Express Interstital" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself loadInterstitialWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        [strongself showInterstitial];
    }];
    [self.view addSubview:self.selectedView];
    
    self.slotSwitchView = [[BUDSwitchView alloc] initWithTitle:@"是否是模板slot" on:YES height:44];
    CGRect frame = self.slotSwitchView.frame;
    frame.origin.y = CGRectGetMaxY(self.selectedView.frame);
    self.slotSwitchView.frame = frame;
    [self.view addSubview:self.slotSwitchView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

/***important:
广告加载成功的时候，会立即渲染WKWebView。
如果想预加载的话，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
*/
- (void)loadInterstitialWithSlotID:(NSString *)slotID {
    NSValue *sizeValue = [self.sizeDict objectForKey:slotID];
    CGSize size = [sizeValue CGSizeValue];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)-40;
    CGFloat height = width/size.width*size.height;
    NSString *realSlotId = self.slotSwitchView.on ? slotID : native_interstitial_ID;
// important: 升级的用户请注意，初始化方法去掉了imgSize参数
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:realSlotId adSize:CGSizeMake(width, height)];
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
- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUNativeExpressInterstitialAd In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
@end
