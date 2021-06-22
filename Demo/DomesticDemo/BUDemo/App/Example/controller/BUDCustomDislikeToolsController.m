//
//  BUDCustomDislikeToolsController.m
//  BUDemo
//
//  Created by bytedance on 2020/12/14.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDCustomDislikeToolsController.h"
#import "BUDFeedViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDSlotID.h"
#import "BUDNativeInterstitialViewController.h"
#import "BUDNativeBannerViewController.h"
#import "UIView+Draw.h"
#import "UIColor+DarkMode.h"

@interface BUDCustomDislikeToolsController ()
@property (nonatomic, strong) UIButton *nativeFeedBtn;
@property (nonatomic, strong) UIButton *nativeBannerBtn;
@property (nonatomic, strong) UIButton *nativeInterstitialBtn;
@end

#define kCustomDislike (@"kCustomDislikeIsOn")
#define kCustomDislikeTitle(isCustom) (isCustom ? @"自定义Dislik面板" : @"不自定义Dislik面板")
@implementation BUDCustomDislikeToolsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"不自定义Dislik面板";
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    UISwitch *customDislike = [[UISwitch alloc] init];
    [customDislike addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:customDislike];
    self.navigationItem.rightBarButtonItems = @[barItem];

    self.nativeFeedBtn.frame = CGRectMake(50.0, 100.0, self.nativeFeedBtn.width, 40.0);
    [self.view addSubview:self.nativeFeedBtn];
    
    self.nativeBannerBtn.frame = CGRectMake(50.0, self.nativeFeedBtn.bottom + 20.0, self.nativeBannerBtn.width, 40.0);
    [self.view addSubview:self.nativeBannerBtn];
    
    self.nativeInterstitialBtn.frame = CGRectMake(50.0, self.nativeBannerBtn.bottom + 20.0, self.nativeInterstitialBtn.width, 40.0);
    [self.view addSubview:self.nativeInterstitialBtn];
    
}




- (void)switchAction:(UISwitch *)sender {
    self.title = kCustomDislikeTitle(sender.isOn);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:sender.isOn forKey:kCustomDislike];
    [userDefaults synchronize];
    self.nativeFeedBtn.enabled = sender.isOn;
    self.nativeBannerBtn.enabled = sender.isOn;
    self.nativeInterstitialBtn.enabled = sender.isOn;
}

- (void)goNativeFeedAction:(UIButton *)sender {
    BUDFeedViewController *vc = [[BUDFeedViewController alloc] init];
    BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
    viewModel.slotID = native_feed_ID;
    vc.viewModel = viewModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goNativeBannerAction:(UIButton *)sender {
    BUDNativeBannerViewController *vc = [[BUDNativeBannerViewController alloc] init];
    BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
    viewModel.slotID = native_banner_ID;
    vc.viewModel = viewModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goNativeInterstitialAction:(UIButton *)sender {
    BUDNativeInterstitialViewController *vc = [[BUDNativeInterstitialViewController alloc] init];
    BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
    viewModel.slotID = native_interstitial_ID;
    vc.viewModel = viewModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (UIButton *)nativeFeedBtn {
    if (_nativeFeedBtn == nil) {
        _nativeFeedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nativeFeedBtn setTitle:@"Native Feed" forState:UIControlStateNormal];
        _nativeFeedBtn.enabled = NO;
        [_nativeFeedBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_nativeFeedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_nativeFeedBtn addTarget:self action:@selector(goNativeFeedAction:) forControlEvents:UIControlEventTouchUpInside];
        [_nativeFeedBtn sizeToFit];
    }
    return _nativeFeedBtn;
}

- (UIButton *)nativeBannerBtn {
    if (_nativeBannerBtn == nil) {
        _nativeBannerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nativeBannerBtn setTitle:@"Native Banner" forState:UIControlStateNormal];
        _nativeBannerBtn.enabled = NO;
        [_nativeBannerBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_nativeBannerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_nativeBannerBtn addTarget:self action:@selector(goNativeBannerAction:) forControlEvents:UIControlEventTouchUpInside];
        [_nativeBannerBtn sizeToFit];
    }
    return _nativeBannerBtn;
}

- (UIButton *)nativeInterstitialBtn {
    if (_nativeInterstitialBtn == nil) {
        _nativeInterstitialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nativeInterstitialBtn setTitle:@"Native Interstitial" forState:UIControlStateNormal];
        _nativeInterstitialBtn.enabled = NO;
        [_nativeInterstitialBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_nativeInterstitialBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_nativeInterstitialBtn addTarget:self action:@selector(goNativeInterstitialAction:) forControlEvents:UIControlEventTouchUpInside];
        [_nativeInterstitialBtn sizeToFit];
    }
    return _nativeInterstitialBtn;
}

- (void)dealloc
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:kCustomDislike];
    [userDefaults synchronize];
}
@end
