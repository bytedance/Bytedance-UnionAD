//
// Created by bytedance on 2022/9/30.
// Copyright (c) 2022 bytedance. All rights reserved.
//

#import "BUMDBannerViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDSelectedView.h"
#import "BUDSlotID.h"
#import "UIColor+DarkMode.h"

#ifdef DEBUG

#import <MBProgressHUD/MBProgressHUD.h>

#endif

@interface BUMDBannerViewController () <BUMNativeExpressBannerViewDelegate>
@property(nonatomic, strong) BUDSelectedView *selectedView;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;
@end

@implementation BUMDBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;

    NSString *slotID = gromore_banner_ID;
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID": slotID, @"title": @"300*200"}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID": slotID, @"title": @"300*150"}];
    NSArray *titlesAndIDS = @[@[item1, item2]];

    __weak typeof(self) weakSelf = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:self.adName SelectedTitlesAndIDS:titlesAndIDS loadItemAction:^(BUDSelcetedItem * _Nonnull item) {
        __strong typeof(weakSelf) self = weakSelf;
        NSArray *sizeComponents = [item.title componentsSeparatedByString:@"*"];
        CGSize size = CGSizeMake([sizeComponents.firstObject doubleValue], [sizeComponents.lastObject doubleValue]);
        [self loadBannerWithSlotID:item.slotID andSize:size];
    } showAction:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showBanner];
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadBannerWithSlotID:(NSString *)slotID andSize:(CGSize)size {
    [self.bannerView removeFromSuperview];

    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    CGFloat bottom = 0.0;
    if (@available(iOS 11.0, *)) {
        bottom = window.safeAreaInsets.bottom;
    }

    // 初始化广告加载对象
    // [可选]混用信息流时可选配置：静音
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = slotID;
    slot.mediation.mutedIfCan = YES;
    
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlot:slot rootViewController:self adSize:size];
    self.bannerView.frame = CGRectMake((self.view.width - size.width) / 2.0, self.view.height - size.height - bottom, size.width, size.height);

    // 配置：回调代理对象。 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    self.bannerView.delegate = self;
    // 轮播相关配置需要在平台配置
    
    // 开始加载广告
    [self.bannerView loadAdData];
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showBanner {
    [self.view addSubview:self.bannerView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.bannerView.backgroundColor = [UIColor grayColor];
    CGRect frame = self.bannerView.frame;
    frame.size.width *= 1.01;
    frame.size.height *= 1.01;
    self.bannerView.frame = frame;
}

#pragma BUMNativeExpressBannerViewDelegate

- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressBannerAdViewDidBecomeVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
    // 展示后可获取信息如下
    BUD_Log(@"%@", [bannerAdView.mediation getShowEcpmInfo]);
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidRemoved:(BUNativeExpressBannerView *)nativeExpressAdView {
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"kevin SDKDemoDelegate BUNativeExpressBannerView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

- (void)nativeExpressBannerAdNeedLayoutUI:(BUNativeExpressBannerView *)bannerAd canvasView:(BUMCanvasView *)canvasView {
    // 仅在使用自渲染混出时会回调这个方法
    // 开发者需在该方法中实现UI渲染
}

@end

