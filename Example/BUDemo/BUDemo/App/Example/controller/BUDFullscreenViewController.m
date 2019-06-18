//
//  BUDFullscreenViewController.m
//  BUDemo
//
//  Created by lee on 2018/8/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDFullscreenViewController.h"
#import <BUAdSDK/BUFullscreenVideoAd.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDMacros.h"
#import "BUDNormalButton.h"

@interface BUDFullscreenViewController () <BUFullscreenVideoAdDelegate>

@property (nonatomic, strong) BUFullscreenVideoAd *fullscreenVideoAd;
@property (nonatomic, strong) BUDNormalButton *button;

@end

@implementation BUDFullscreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#warning----- Every time the data is requested, a new one BUFullscreenVideoAd needs to be initialized. Duplicate request data by the same full screen video ad is not allowed.
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:self.viewModel.slotID];
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
    [self.view addSubview:self.button];
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
    }
    return _button;
}

- (void)buttonTapped:(id)sender {
    /**Return YES when material is effective,data is not empty and has not been displayed.
    Repeated display is not charged.
     */
    [self.fullscreenVideoAd showAdFromRootViewController:self.navigationController ritSceneDescribe:@"custom"];
}

#pragma mark BURewardedVideoAdDelegate

- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"fullscreenVideoAd data load success");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"fullscreen data load success";
    [hud hideAnimated:YES afterDelay:1];
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    BUD_Log(@"fullscreenVideoAd data load fail");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"fullscreen data load fail";
    [hud hideAnimated:YES afterDelay:1];
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"fullscreenVideoAd video load success");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"fullscreen video load success";
    [hud hideAnimated:YES afterDelay:1];
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    BUD_Log(@"fullscreenVideoAd click skip");
}

@end
