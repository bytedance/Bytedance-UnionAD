//
//  BUMDCustomInterstitialAdapter.m
//  BUMDemo
//
//  Created by bytedance on 2021/11/3.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomInterstitialAdapter.h"
#import "BUMDCustomInterstitialView.h"
#import "BUMDStoreViewController.h"

@interface BUMDCustomInterstitialAdapter ()

@property (nonatomic, strong) BUMDCustomInterstitialView *view;

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, assign) CGSize size;

@end

@implementation BUMDCustomInterstitialAdapter

- (BUMMediatedAdStatus)mediatedAdStatus {
    return BUMMediatedAdStatusNormal;
}

- (void)loadInterstitialAdWithSlotID:(NSString *)slotID andSize:(CGSize)size parameter:(NSDictionary *)parameter {
    self.size = size;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟广告加载成功回调
        [self.bridge interstitialAd:self didLoadWithExt:@{}];
    });
}

- (BOOL)showAdFromRootViewController:(UIViewController *)viewController parameter:(NSDictionary *)parameter {
    self.viewController = viewController;
    self.view = [BUMDCustomInterstitialView interstitialViewWithSize:self.size];
    [self.view showInViewController:viewController];
    __weak __typeof(self) ws = self;
    // 模拟广告关闭事件
    self.view.closeCallback = ^(BUMDCustomInterstitialView * _Nonnull view) {
        __weak __typeof(ws) self = ws;
        [self.bridge interstitialAdDidClose:self];
    };
    // 模拟广告点击事件
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bridge interstitialAdDidVisible:self];
    });
    return YES;
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}

- (void)didClick {
    [self.bridge interstitialAdDidClick:self];
    [self.bridge interstitialAdWillPresentFullScreenModal:self];
    BUMDStoreViewController *vc = [[BUMDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.viewController complete:^{}];
}
@end
