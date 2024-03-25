//
//  BUMDCustomFullscreenVideoAdapter.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomFullscreenVideoAdapter.h"
#import "BUMDCustomFullscreenView.h"
#import "BUMDStoreViewController.h"

@interface BUMDCustomFullscreenVideoAdapter ()

@property (nonatomic, strong) BUMDCustomFullscreenView *view;

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation BUMDCustomFullscreenVideoAdapter

- (BUMMediatedAdStatus)mediatedAdStatus {
    return BUMMediatedAdStatusNormal;
}

- (void)loadFullscreenVideoAdWithSlotID:(nonnull NSString *)slotID andParameter:(nonnull NSDictionary *)parameter {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟广告加载成功回调
        [self.bridge fullscreenVideoAd:self didLoadWithExt:@{}];
        // 模拟广告视频加载完成回调
        [self.bridge fullscreenVideoAdVideoDidLoad:self];
    });
}

- (BOOL)showAdFromRootViewController:(UIViewController * _Nonnull)viewController parameter:(nonnull NSDictionary *)parameter {
    self.viewController = viewController;
    self.view = [BUMDCustomFullscreenView fullscreenView];
    [self.view showInViewController:viewController];
    __weak __typeof(self) ws = self;
    // 模拟广告关闭事件
    self.view.dismissCallback = ^(BUMDCustomFullscreenView * _Nonnull view) {
        __weak __typeof(ws) self = ws;
        [self.bridge fullscreenVideoAdDidClose:self];
    };
    // 模拟广告点击跳过事件
    self.view.skipCallback = ^(BUMDCustomFullscreenView * _Nonnull view) {
        __weak __typeof(ws) self = ws;
        [self.bridge fullscreenVideoAdDidClickSkip:self];
    };
    // 模拟广告点击事件
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bridge fullscreenVideoAdDidVisible:self];
    });
    // 模拟广告视频播放完成事件
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bridge fullscreenVideoAd:self didPlayFinishWithError:nil];
    });
    return YES;
}

- (void)didReceiveBidResult:(BUMMediaBidResult *)result {
    // 在此处理Client Bidding的结果回调
}

- (void)didClick {
    [self.bridge fullscreenVideoAdDidClick:self];
    [self.bridge fullscreenVideoAdWillPresentFullscreenModal:self];
    BUMDStoreViewController *vc = [[BUMDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.viewController complete:^{}];
}

@end
