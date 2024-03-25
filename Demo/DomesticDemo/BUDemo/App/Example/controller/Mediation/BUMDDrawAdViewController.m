//
//  BUMDDrawAdViewController.m
//  BUMDemo
//
//  Created by ByteDance on 2022/10/30.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDDrawAdViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUMDDrawAdView.h"
#import "BUDMacros.h"

@interface BUMDDrawAdViewController () <BUMNativeAdsManagerDelegate, BUMNativeAdDelegate>
@property (nonatomic, strong) BUNativeAdsManager *drawAdsManager;

@property (nonatomic, strong) BUMDDrawAdView <BUMDDrawAdViewProtocol> *drawAdBackView;

@property (nonatomic, strong) UIButton *showAndRefreshAd;
@end

@implementation BUMDDrawAdViewController

- (void)dealloc {
    self.drawAdsManager = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat width  = 300;
    CGFloat height = 60;
    CGFloat x = (CGRectGetWidth(self.view.frame) - width) / 2;
    CGFloat y = 30;
    _showAndRefreshAd = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self.view addSubview:_showAndRefreshAd];
    [_showAndRefreshAd addTarget:self action:@selector(refreshAdAndShow) forControlEvents:UIControlEventTouchUpInside];
    [_showAndRefreshAd setTitle:@"Load draw ad" forState:UIControlStateNormal];
    [_showAndRefreshAd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _showAndRefreshAd.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    UILabel *separator = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_showAndRefreshAd.frame) + 10 , CGRectGetWidth(self.view.frame), 1)];
    separator.backgroundColor = [UIColor blackColor];
    [self.view addSubview:separator];
    
    CGFloat versionBottom = 0;
    versionBottom = CGRectGetMaxY(separator.frame) + 10;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self refreshAdAndShow];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(13, 34, 30, 30);
    [btn setImage:[UIImage imageNamed:@"draw_back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:btn];
    [self.view addSubview:btn];
    btn.accessibilityIdentifier = @"draw_back";
}

- (void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshAdAndShow {
    // 加载广告
    [self loadDrawVideoAds];
}

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadDrawVideoAds {
    [self removeLastView];
    
    // 广告加载
    BUAdSlot *adSlot = [[BUAdSlot alloc] init];
    adSlot.ID = self.viewModel.slotID;
    self.drawAdsManager = [[BUNativeAdsManager alloc] initWithSlot:adSlot];
    // 配置：回调代理对象
    self.drawAdsManager.delegate = self;
    BUD_Log(@"%s", __func__);
    
    // 开始加载广告
    [self.drawAdsManager loadAdDataWithCount:3];
}

- (void)removeLastView {
    if (self.drawAdsManager) {
        UIView *drawView = [self.view viewWithTag:1000];
        [drawView removeFromSuperview];
        [self.drawAdsManager.mediation destory];
        self.drawAdsManager = nil;
    }
}

# pragma mark ---<BUMNativeAdsManagerDelegate>---
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *)nativeAdDataArray {
    
    /// 注意,demo仅处理了首个广告
    BUNativeAd *model = nativeAdDataArray.firstObject;
    model.rootViewController = self;
    model.delegate = self;

    BUMRitInfo *info = [model.mediation getShowEcpmInfo];
    BUD_Log(@"ecpm:%@", info.ecpm);
    BUD_Log(@"platform:%@", info.adnName);
    BUD_Log(@"ritID:%@", info.slotID);
    BUD_Log(@"requestID:%@", info.requestID ?: @"None");
    BUD_Log(@"getAdLoadInfoList:%@", [adsManager.mediation getAdLoadInfoList]);
    
    CGFloat screenWidth = CGRectGetWidth(self.view.frame);
    CGFloat screenHeight = CGRectGetHeight(self.view.frame);
    CGFloat height = screenHeight - (CGRectGetMaxY(self.showAndRefreshAd.frame) + 20) - 100;
    CGFloat width = screenWidth * height / CGRectGetHeight(self.view.frame);
    CGFloat x = (screenWidth - width ) / 2;
    
    if (model.mediation.isExpressAd) {
        model.mediation.canvasView.frame = CGRectMake(x, CGRectGetMaxY(self.showAndRefreshAd.frame) + 20, width, height);
        model.mediation.canvasView.tag = 1000;
        [self.view addSubview:model.mediation.canvasView];
        [model.mediation render];
    } else {
        [_drawAdBackView removeFromSuperview];
        _drawAdBackView = [[BUMDDrawVideoAdView alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.showAndRefreshAd.frame) + 20, width, height)];
        _drawAdBackView.backgroundColor = [UIColor grayColor];
        __weak typeof(self) weakself = self;
        self.drawAdBackView.cellClose = ^(NSInteger index) {
            __strong typeof(self) strongself = weakself;
            [strongself.drawAdBackView removeFromSuperview];
        };
        [_drawAdBackView refreshUIWithModel:model];

        _drawAdBackView.tag = 1000;
        [self.view addSubview:_drawAdBackView];
    }
    
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *)error {
    BUD_Log(@"%s:%@", __func__, error);
}

# pragma mark ---<BUMNativeAdViewDelegate>---

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    BUD_Log(@"%s", __func__);
    
    // 展示后可获取信息如下
    BUMRitInfo *info = [nativeAd.mediation getShowEcpmInfo];
    BUD_Log(@"ecpm:%@", info.ecpm);
    BUD_Log(@"platform:%@", info.adnName);
    BUD_Log(@"ritID:%@", info.slotID);
    BUD_Log(@"requestID:%@", info.requestID ?: @"None");
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdWillPresentFullScreenModal:(BUNativeAd *)nativeAd {
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdExpressViewRenderSuccess:(BUNativeAd *)nativeAd   {
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdExpressViewRenderFail:(BUNativeAd *)nativeAd error:(NSError *)error {
    BUD_Log(@"%s:%@", __func__, error);
}

- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterWords; {
    BUD_Log(@"%s", __func__);
}

/**
 This method is called when videoadview playback status changed.
 @param playerState : player state after changed
 */
- (void)nativeAdVideo:(BUNativeAd *)nativeAd stateDidChanged:(BUPlayerPlayState)playerState {
    BUD_Log(@"%s:%ld", __func__, (long)playerState);
}

/**
 This method is called when videoadview's finish view is clicked.
 */
- (void)nativeAdVideoDidClick:(BUNativeAd *_Nullable)nativeAd {
    BUD_Log(@"%s", __func__);
}

/**
 This method is called when videoadview end of play.
 */
- (void)nativeAdVideoDidPlayFinish:(BUNativeAd *_Nullable)nativeAd {
    BUD_Log(@"%s", __func__);
}

@end


