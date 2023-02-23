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

@interface BUDSplashContainerViewController () <BUSplashAdDelegate, BUSplashCardDelegate, BUSplashZoomOutDelegate>

@property (nonatomic, strong) BUSplashAd *splashAd;

@end

@implementation BUDSplashContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)loadSplashAd {
    BUSplashAd *splashAd = [[BUSplashAd alloc] initWithSlotID:express_splash_ID adSize:self.view.bounds.size];
    splashAd.supportCardView = YES;
    splashAd.supportZoomOutView = YES;
    
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    splashAd.delegate = self;
    splashAd.cardDelegate = self;
    splashAd.zoomOutDelegate = self;
    splashAd.tolerateTimeout = 3;

    [splashAd loadAdData];
    self.splashAd = splashAd;
}

- (void)dismiss {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

#pragma mark - BUSplashOldDelegate

- (void)splashAdLoadSuccess:(BUSplashAd *)splashAd {
    [splashAd showSplashViewInRootViewController:self];
}


- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
}

- (void)splashAdRenderSuccess:(BUSplashAd *)splashAd {
    // 渲染成功再展示视图控制器
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow.rootViewController addChildViewController:self];
    [keyWindow.rootViewController.view addSubview:self.view];
}

- (void)splashAdRenderFail:(BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
}


- (void)splashAdWillShow:(BUSplashAd *)splashAd {
    
}

- (void)splashAdDidShow:(BUSplashAd *)splashAd {
    
}

- (void)splashAdDidClick:(BUSplashAd *)splashAd {
    
}

- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {

}

- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
    [self dismiss];
}

- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    
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


- (void)splashVideoAdDidPlayFinish:(BUSplashAd *)splashAd didFailWithError:(nonnull NSError *)error {
    
}

#pragma mark - BUSplashCardDelegate

- (void)splashCardReadyToShow:(BUSplashAd *)splashAd {
    [splashAd showCardViewInRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
}

- (void)splashCardViewDidClick:(BUSplashAd *)splashAd {
    
}

- (void)splashCardViewDidClose:(BUSplashAd *)splashAd {
    
}

#pragma mark - BUSplashZoomOutDelegate

- (void)splashZoomOutReadyToShow:(BUSplashAd *)splashAd {
    
    [splashAd showCardViewInRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
}

- (void)splashZoomOutViewDidClick:(BUSplashAd *)splashAd {
    
}

- (void)splashZoomOutViewDidClose:(BUSplashAd *)splashAd {
    
}




- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUSplashAdView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}


@end
