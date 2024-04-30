//
//  BUMDCustomBannerAdapter.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomBannerAdapter.h"
#import "BUMDStoreViewController.h"
#import "BUMDCustomBannerView.h"

#import "BUMDCustomExpressNativeView.h"
#import "BUMDCustomNativeAdHelper.h"
#import "BUMDCustomNativeData.h"
#import "BUMDCustomNativeAdHelper.h"
#import "BUMDCustomNativeView.h"

@interface BUMDCustomBannerAdapter ()

// common
@property (nonatomic, assign) NSInteger adSubType;// 混用代码位时，代码位类型
@property (nonatomic, assign) NSTimeInterval lastLoadTimeInterval;
// banner -> adSubType == 3
@property (nonatomic, strong) BUMDCustomBannerView *bannerView;
// mix native -> adSubType == 4
@property (nonatomic, strong) BUMDCustomExpressNativeView *expressNativeView;
@property (nonatomic, strong) BUMCanvasView *canvasView;
@property (nonatomic, strong) BUMDCustomNativeData *customNativeData;

@end

@implementation BUMDCustomBannerAdapter

- (BUMMediatedAdStatus)mediatedAdStatus {
    BUMMediatedAdStatus status = BUMMediatedAdStatusNormal;
    if (self.lastLoadTimeInterval + 30.f > CACurrentMediaTime()) { // 模拟30秒，广告过期
        status.unexpired = BUMMediatedAdStatusValueDeny;
    }
    return status;
}

- (void)loadBannerAdWithSlotID:(nonnull NSString *)slotID andSize:(CGSize)adSize parameter:(nullable NSDictionary *)parameter {
    // 混用代码位时，代码位类型
    self.adSubType = [parameter[BUMAdLoadingParamAdSubType] integerValue];
    if (self.adSubType == 4) { // banner广告位下混用信息流代码位
        [self _mixNativeloadNativeAdWithSlotID:slotID andSize:adSize imageSize:[parameter[BUMAdLoadingParamNAExpectImageSize] CGSizeValue] parameter:parameter];
    } else { // banner代码位
        if (CGSizeEqualToSize(adSize, CGSizeZero)) adSize = CGSizeMake(300, 200);
        // 模拟加载耗时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGRect frame = (CGRect){CGPointZero, adSize};
            BUMDCustomBannerView *bannerView = [[BUMDCustomBannerView alloc] initWithFrame:frame];
            self.bannerView = bannerView;
            __weak __typeof(self) ws = self;
            // 模拟展示回调
            bannerView.didMoveToSuperViewCallback = ^(BUMDCustomBannerView *view) {
                __weak __typeof(ws) self = ws;
                [self.bridge bannerAdDidBecomeVisible:self bannerView:view];
            };
            // 模拟关闭回调
            bannerView.closeAction = ^(BUMDCustomBannerView *view) {
                __weak __typeof(ws) self = ws;
                [self.bridge bannerAd:self bannerView:view didClosedWithDislikeWithReason:@[]];
            };
            // 模拟点击回调
            [bannerView addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
            // 模拟加载成功回调
            [self.bridge bannerAd:self didLoad:bannerView ext:@{
                // 模拟回调补充参数
                BUMMediaAdLoadingExtECPM : @"[可选]更多字段参考BUMAdLoadingParams.h"
            }];
            self.lastLoadTimeInterval = CACurrentMediaTime();
        });
    }

}

- (void)_mixNativeloadNativeAdWithSlotID:(nonnull NSString *)slotID andSize:(CGSize)size imageSize:(CGSize)imageSize parameter:(nonnull NSDictionary *)parameter {
    // 获取是否需要加载模板广告，非必要，视network支持而定
    NSInteger renderType = [parameter[BUMAdLoadingParamExpressAdType] integerValue];
    // 模拟广告加载耗时，开发者需在此调用network加载广告方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (renderType == 1) { // 此处仅说明渲染类型可下发，开发者需根据实际定义情况编写
            // 模拟加载模板广告
            BUMDCustomExpressNativeView *view = [[BUMDCustomExpressNativeView alloc] initWithSize:size andImageSize:imageSize];
            self.expressNativeView = view;
            __weak __typeof(self) ws = self;
            // 模拟广告点击事件
            view.didClickAction = ^(BUMDCustomExpressNativeView * _Nonnull view) {
                __weak __typeof(ws) self = ws;
                [self.bridge bannerAdDidClick:self bannerView:view];
                [self.bridge bannerAdWillPresentFullScreenModal:self bannerView:view];
            };
            // 模拟广告展示事件
            view.didMoveToSuperViewCallback = ^(BUMDCustomExpressNativeView * _Nonnull view) {
                __weak __typeof(ws) self = ws;
                [self.bridge bannerAdDidBecomeVisible:self bannerView:view];
            };
            // 模拟广告关闭事件
            view.didClickCloseAction = ^(BUMDCustomExpressNativeView * _Nonnull view) {
                __weak __typeof(ws) self = ws;
                [self.bridge bannerAd:self bannerView:view didClosedWithDislikeWithReason:@[]];
            };
            view.viewController = self.bridge.viewControllerForPresentingModalView;
            NSDictionary *ext = @{
                BUMMediaAdLoadingExtECPM : @"1000",
            };
            view.viewController = self.bridge.viewControllerForPresentingModalView;
            
            [self.bridge bannerAd:self didLoad:view ext:ext];
        } else {
            // 模拟加载非模板广告
            BUMDCustomNativeData *data = [BUMDCustomNativeData randomDataWithImageSize:imageSize];
            self.customNativeData = data;
            __weak __typeof(self) ws = self;
            // 模拟广告点击事件
            data.didClickAction = ^(BUMDCustomNativeData * _Nonnull data) {
                __weak __typeof(ws) self = ws;
                [self.bridge bannerAdDidClick:self bannerView:self.canvasView];
                [self.bridge bannerAdWillPresentFullScreenModal:self bannerView:self.canvasView];
            };
            data.viewController = self.bridge.viewControllerForPresentingModalView;
            id<BUMMediatedNativeAdData, BUMMediatedNativeAdViewCreator> helper = [[BUMDCustomNativeAdHelper alloc] initWithAdData:data];
            // 构造需要返回GroMore的非模板广告数据
            BUMMediatedNativeAd *ad = [[BUMMediatedNativeAd alloc] init];
            ad.originMediatedNativeAd = data;
            ad.view = ({
                BUMDCustomNativeView *v = [[BUMDCustomNativeView alloc] init];
                v.didMoveToSuperViewCallback = ^(BUMDCustomNativeView * _Nonnull view) {
                    __weak __typeof(ws) self = ws;
                    [self.bridge bannerAdDidBecomeVisible:self bannerView:self.canvasView];
                }; v;
            });
            ad.viewCreator = helper;
            ad.data = helper;
            NSDictionary *ext = @{
                BUMMediaAdLoadingExtECPM : @"1000",
            };
            
            BUMCanvasView *view = [[BUMCanvasView alloc]initWithNativeAd:ad adapter:self];
            self.canvasView = view;
            
            [self.bridge bannerAd:self didLoad:self.canvasView ext:ext];
        }
    });
}

- (void)registerContainerView:(nonnull __kindof UIView *)containerView andClickableViews:(nonnull NSArray<__kindof UIView *> *)views forNativeAd:(nonnull id)nativeAd {
    if ([nativeAd isKindOfClass:[BUMDCustomNativeData class]]) {
        BUMDCustomNativeData *ad = (BUMDCustomNativeData *)nativeAd;
        [ad registerClickableViews:views];
    }
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}

- (void)didClick:(BUMDCustomBannerView *)sender {
    [self.bridge bannerAdDidClick:self bannerView:sender];
    [self.bridge bannerAdWillPresentFullScreenModal:self bannerView:sender];
    BUMDStoreViewController *vc = [[BUMDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.bridge.viewControllerForPresentingModalView complete:^{
        [self.bridge bannerAdWillDismissFullScreenModal:self bannerView:sender];
    }];
}

@end
