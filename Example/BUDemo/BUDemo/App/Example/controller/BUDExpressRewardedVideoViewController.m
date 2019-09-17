//
//  BUDExpressRewardedVideoViewController.m
//  BUDemo
//
//  Created by cuiyanan on 2019/7/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressRewardedVideoViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BUDExpressRewardedVideoViewController ()<BUNativeExpressRewardedVideoAdDelegate>
@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedAd;
@property (nonatomic, strong) BUDNormalButton *button;
@end

@implementation BUDExpressRewardedVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    self.rewardedAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
    self.rewardedAd.delegate = self;
    [self.rewardedAd loadAdData];
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
        [_button setTitle:[NSString localizedStringForKey:ShowRewardVideo] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _button.isValid = NO;
    }
    return _button;
}

- (void)buttonTapped:(id)sender {
    if (self.rewardedAd.isAdValid) {
        [self.rewardedAd showAdFromRootViewController:self.navigationController];
        self.button.isValid = NO;
    }
}

#pragma mark - BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"material load success";
    [hud hideAnimated:YES afterDelay:2];
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    self.button.isValid = NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"material or template plugin load fail";
    [hud hideAnimated:YES afterDelay:2];
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -200);
    hud.label.text = @"video load success";
    [hud hideAnimated:YES afterDelay:2];
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    self.button.isValid = YES;
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    self.button.isValid = NO;
}

- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    [self.rewardedAd loadAdData];
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

@end
