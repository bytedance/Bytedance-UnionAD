//
//  BUDSplashContainerViewController.m
//  BUDemo
//
//  Created by wangyanlin on 2021/2/24.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDSplashContainerViewController.h"
#import "BUDSplashViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "UIView+Draw.h"
#import "BUDAnimationTool.h"
#import "BUDSlotID.h"

@interface BUDSplashContainerViewController () <BUSplashAdDelegate>

@property (nonatomic, strong) BUSplashAdView *splashView;
@property (nonatomic, assign) BOOL isDidClick;

@end

@implementation BUDSplashContainerViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildupDefaultSplashView];
}

- (void)buildupDefaultSplashView {
    self.isDidClick = NO;
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:normal_splash_ID frame:self.view.bounds];
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    splashView.delegate = self;
    splashView.rootViewController = self;
    splashView.tolerateTimeout = 3;
    [splashView loadAdData];
    [self.view addSubview:splashView];
    self.splashView = splashView;
}

- (void)handleSplashAnimation {
    if (self.splashView.zoomOutView) {
        [BUDAnimationTool sharedInstance].splashContainerVC = self;
        BUDSplashViewController *splashVC = nil;
        if ([self.appRootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)self.appRootVC;
            UIViewController *topVC = nav.topViewController;
            if ([topVC isKindOfClass:[BUDSplashViewController class]]) {
                splashVC = (BUDSplashViewController *)topVC;
            }
        }
        [splashVC setUpSplashZoomOutAd:self.splashView];
    } else{
        if (self.splashView) {
            [self.splashView removeFromSuperview];
            self.splashView = nil;
        }
    }
    if (self.appRootVC) {
        [[UIApplication sharedApplication].keyWindow setRootViewController:self.appRootVC];
    }
}

- (void)removeSplashAdView {
    if (self.splashView) {
        [self.splashView removeFromSuperview];
        self.splashView = nil;
    }
    if (self.appRootVC) {
        [[UIApplication sharedApplication].keyWindow setRootViewController:self.appRootVC];
    }
}
#pragma mark - BUSplashAdDelegate
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    self.isDidClick = YES;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    if (!self.isDidClick) {
        [self handleSplashAnimation];
    }
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
//    [self handleSplashAnimation];
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    [self removeSplashAdView];
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    
    // After closing the other controllers, there will be no further action, so 'splashView' needs to be released to avoid memory leaks
    [self removeSplashAdView];
    [self pbud_logWithSEL:_cmd msg:str];
}

- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUSplashAdView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}


@end
