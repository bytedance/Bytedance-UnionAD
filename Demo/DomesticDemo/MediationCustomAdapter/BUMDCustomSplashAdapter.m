//
//  BUMDCustomSplashAdapter.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomSplashAdapter.h"
#import "BUMDCustomSplashView.h"

@interface BUMDCustomSplashAdapter ()

@property (nonatomic, strong) BUMDCustomSplashView *splashView;

@property (nonatomic, strong) UIView *customBottomView;

@end

@implementation BUMDCustomSplashAdapter

- (BUMMediatedAdStatus)mediatedAdStatus {
    return BUMMediatedAdStatusNormal;
}

- (void)dismissSplashAd {
    [self.splashView removeFromSuperview];
    [self.customBottomView removeFromSuperview];
}

- (void)loadSplashAdWithSlotID:(nonnull NSString *)slotID andParameter:(nonnull NSDictionary *)parameter {
    CGSize size = [parameter[BUMAdLoadingParamSPExpectSize] CGSizeValue];
    self.customBottomView = parameter[BUMAdLoadingParamSPCustomBottomView];
    
    self.splashView = [BUMDCustomSplashView splashViewWithSize:size rootViewController:self.bridge.viewControllerForPresentingModalView];
    __weak __typeof(self) ws = self;
    // 模拟点击事件
    self.splashView.didClickAction = ^(BUMDCustomSplashView * _Nonnull view) {
        __weak __typeof(ws) self = ws;
        [self.bridge splashAdDidClick:self];
    };
    // 模拟关闭事件
    self.splashView.dismissCallback = ^(BUMDCustomSplashView * _Nonnull view, BOOL skip) {
        __weak __typeof(ws) self = ws;
        if (skip) {
            [self.bridge splashAdDidClickSkip:self];
        } else {
            [self.bridge splashAdDidCountDownToZero:self];
        }
        [self.bridge splashAdDidClose:self];
    };
    // 模拟加载完成
    [self.bridge splashAd:self didLoadWithExt:@{}];
}

- (void)showSplashAdInWindow:(nonnull UIWindow *)window parameter:(nonnull NSDictionary *)parameter {
    [self.splashView showInWindow:window];
    if (self.customBottomView) {
        [window addSubview:self.customBottomView];
    }
    // 模拟广告展示回调
    [self.bridge splashAdWillVisible:self];
}


- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}
@end
