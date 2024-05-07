//
//  BUMDCustomDrawAdapter.m
//  BUMDemo
//
//  Created by ByteDance on 2022/5/5.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDCustomDrawAdapter.h"
#import "BUMDCustomExpressDrawView.h"
#import "BUMDCustomDrawAdHelper.h"
#import "BUMDCustomDrawData.h"
#import "BUMDCustomDrawView.h"

@implementation BUMDCustomDrawAdapter

/// 当前加载的广告的状态，native模板广告
- (BUMMediatedAdStatus)mediatedAdStatusWithExpressView:(UIView *)view {
    return BUMMediatedAdStatusUnknown;
}

/// 当前加载的广告的状态，native非模板广告
- (BUMMediatedAdStatus)mediatedAdStatusWithMediatedNativeAd:(BUMMediatedNativeAd *)ad {
    return BUMMediatedAdStatusUnknown;
}

- (void)loadDrawAdWithSlotID:(nonnull NSString *)slotID andSize:(CGSize)size andParameter:(nonnull NSDictionary *)parameter {
    // 获取广告加载数量
    NSInteger count = [parameter[BUMAdLoadingParamNALoadAdCount] integerValue];
    // 获取是否需要加载模板广告，非必要，视network支持而定
    NSInteger renderType = [parameter[BUMAdLoadingParamExpressAdType] integerValue];
    // 模拟广告加载耗时，开发者需在此调用network加载广告方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (renderType == 1) { // 此处仅说明渲染类型可下发，开发者需根据实际定义情况编写
            // 模拟加载模板广告
            NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
            NSMutableArray *exts = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i < count; i++) {
                BUMDCustomExpressDrawView *view = [[BUMDCustomExpressDrawView alloc] initWithSize:size];
                __weak __typeof(self) ws = self;
                // 模拟广告点击事件
                view.didClickAction = ^(BUMDCustomExpressDrawView * _Nonnull view) {
                    __weak __typeof(ws) self = ws;
                    [self.bridge drawAd:self videoDidClick:view];
                    [self.bridge drawAd:self willPresentFullScreenModalWithMediatedAd:view];
                };
                // 模拟广告展示事件
                view.didMoveToSuperViewCallback = ^(BUMDCustomExpressDrawView * _Nonnull view) {
                    __weak __typeof(ws) self = ws;
                    [self.bridge drawAd:self didVisibleWithMediatedAd:view];
                };
                // 模拟广告关闭事件
                view.didClickCloseAction = ^(BUMDCustomExpressDrawView * _Nonnull view) {
                    __weak __typeof(ws) self = ws;
                    [self.bridge drawAd:self didCloseWithExpressView:view closeReasons:@[]];
                };
                view.viewController = self.bridge.viewControllerForPresentingModalView;
                [list addObject:view];
                [exts addObject:@{
                    BUMMediaAdLoadingExtECPM : @"1000",
                }];
            }
            [self.bridge drawAd:self didLoadWithDrawAds:[list copy] exts:[exts copy]];
        } else {
            // 模拟加载非模板广告
            NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
            NSMutableArray *exts = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i < count; i++) {
                BUMDCustomDrawData *data = [BUMDCustomDrawData randomData];
                __weak __typeof(self) ws = self;
                // 模拟广告点击事件
                data.didClickAction = ^(BUMDCustomDrawData * _Nonnull data) {
                    __weak __typeof(ws) self = ws;
                    [self.bridge drawAd:self videoDidClick:data];
                    [self.bridge drawAd:self willPresentFullScreenModalWithMediatedAd:data];
                };
                data.viewController = self.bridge.viewControllerForPresentingModalView;
                id<BUMMediatedNativeAdData, BUMMediatedNativeAdViewCreator> helper = [[BUMDCustomDrawAdHelper alloc] initWithAdData:data];
                // 构造需要返回GroMore的非模板广告数据
                BUMMediatedNativeAd *ad = [[BUMMediatedNativeAd alloc] init];
                ad.originMediatedNativeAd = data;
                ad.view = ({
                    BUMDCustomDrawView *v = [[BUMDCustomDrawView alloc] init];
                    v.didMoveToSuperViewCallback = ^(BUMDCustomDrawView * _Nonnull view) {
                        __weak __typeof(ws) self = ws;
                        [self.bridge drawAd:self didVisibleWithMediatedAd:data]; // 注意：使用原始广告数据
                    }; v;
                });
                ad.viewCreator = helper;
                ad.data = helper;
                [list addObject:ad];
                [exts addObject:@{
                    BUMMediaAdLoadingExtECPM : @"1000",
                }];
            }
            [self.bridge drawAd:self didLoadWithDrawAds:[list copy] exts:[exts copy]];
        }
    });
}

/// 为模板广告设置控制器
/// @param viewController 控制器
/// @param expressAdView 模板广告
- (void)setRootViewController:(UIViewController *)viewController forExpressAdView:(UIView *)expressAdView {
    if ([expressAdView isKindOfClass:[BUMDCustomExpressDrawView class]]) {
        BUMDCustomExpressDrawView *view = (BUMDCustomExpressDrawView *)expressAdView;
        view.viewController = viewController;
    }
}

/// 为非模板广告设置控制器
/// @param viewController 控制器
/// @param drawAd 非模板广告
- (void)setRootViewController:(UIViewController *)viewController forDrawAd:(id)drawAd {
    if ([drawAd isKindOfClass:[BUMDCustomDrawData class]]) {
        BUMDCustomDrawData *ad = (BUMDCustomDrawData *)drawAd;
        ad.viewController = viewController;
    }
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    
}

@end
