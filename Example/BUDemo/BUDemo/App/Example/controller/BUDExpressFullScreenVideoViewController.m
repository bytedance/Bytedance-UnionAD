//
//  BUDExpressFullScreenVideoViewController.m
//  BUDemo
//
//  Created by cuiyanan on 2019/7/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressFullScreenVideoViewController.h"
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"
#import <BUAdSDK/BUAdSDK.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface BUDExpressFullScreenVideoViewController ()<BUNativeExpressFullscreenVideoAdDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd *fullscreenAd;
@end

@implementation BUDExpressFullScreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view.
    self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:self.viewModel.slotID];
    self.fullscreenAd.delegate = self;
    [self.fullscreenAd loadAdData];
    //为保证播放流畅和展示流畅建议可在收到渲染成功和视频下载完成回调后再展示视频。
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

#pragma mark Lazy loading
- (UIButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:[NSString localizedStringForKey:ShowFullScreenVideo] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _button.isValid = NO;
    }
    return _button;
}

- (void)buttonTapped:(id)sender {
    if (self.fullscreenAd.isAdValid) {
        [self.fullscreenAd showAdFromRootViewController:self.navigationController];
    }
}

#pragma mark - BUFullscreenVideoAdDelegate
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"material load success";
    [hud hideAnimated:YES afterDelay:2];
}

- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    self.button.isValid = NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"material or template plugin load fail";
    [hud hideAnimated:YES afterDelay:2];
}

- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    self.button.isValid = YES;
}

- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    self.button.isValid = NO;
}

- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -200);
    hud.label.text = @"video load success";
    [hud hideAnimated:YES afterDelay:2];
}

- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"%s",__func__);
    [self.fullscreenAd loadAdData];
}

- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
}

@end
