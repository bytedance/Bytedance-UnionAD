//
//  BUDFullscreenViewController.m
//  BUDemo
//
//  Created by lee on 2018/8/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDFullscreenViewController.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDFullscreenViewController () <BUFullscreenVideoAdDelegate>
@property (nonatomic, strong) BUFullscreenVideoAd *fullscreenVideoAd;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation BUDFullscreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _statusLabel = [[UILabel alloc]init];
    [_statusLabel setFont:[UIFont systemFontOfSize:16]];
    [_statusLabel setTextColor:[UIColor redColor]];
    [_statusLabel setTextAlignment:NSTextAlignmentCenter];
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _statusLabel.text = @"Tap left button to load Ad";
    [self.view addSubview:_statusLabel];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_statusLabel]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[_statusLabel(25)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    
    UIButton *loadPortraitAd = [UIButton buttonWithType:UIButtonTypeSystem];
    loadPortraitAd.layer.borderWidth = 0.5;
    loadPortraitAd.layer.cornerRadius = 8;
    loadPortraitAd.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loadPortraitAd.translatesAutoresizingMaskIntoConstraints = NO;
    [loadPortraitAd addTarget:self action:@selector(loadPortraitAd:) forControlEvents:UIControlEventTouchUpInside];
    [loadPortraitAd setTitle:@"LoadPortraitAd" forState:UIControlStateNormal];
    [loadPortraitAd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:loadPortraitAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[loadPortraitAd]-170-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loadPortraitAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_statusLabel]-20-[loadPortraitAd(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel,loadPortraitAd)]];
    
    UIButton *loadLandscapeAd = [UIButton buttonWithType:UIButtonTypeSystem];
    loadLandscapeAd.layer.borderWidth = 0.5;
    loadLandscapeAd.layer.cornerRadius = 8;
    loadLandscapeAd.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loadLandscapeAd.translatesAutoresizingMaskIntoConstraints = NO;
    [loadLandscapeAd addTarget:self action:@selector(loadLandscapeAd:) forControlEvents:UIControlEventTouchUpInside];
    [loadLandscapeAd setTitle:@"LoadLandscapeAd" forState:UIControlStateNormal];
    [loadLandscapeAd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:loadLandscapeAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[loadLandscapeAd]-170-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loadLandscapeAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loadPortraitAd]-20-[loadLandscapeAd(45)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loadPortraitAd,loadLandscapeAd)]];
    
    UIButton *showAd = [UIButton buttonWithType:UIButtonTypeSystem];
    showAd.layer.cornerRadius = 8;
    showAd.translatesAutoresizingMaskIntoConstraints = NO;
    [showAd addTarget:self action:@selector(showAd:) forControlEvents:UIControlEventTouchUpInside];
    [showAd setTitle:@"showAd" forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [showAd setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:showAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[showAd(80)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(showAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[showAd(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(showAd)]];
}

- (void)loadPortraitAd:(UIButton *)sender {
    [self loadFullscreenVideoAdWithSlotID:@"900546299"];
}

- (void)loadLandscapeAd:(UIButton *)sender {
    [self loadFullscreenVideoAdWithSlotID:@"900546154"];
}

- (void)showAd:(UIButton *)sender {
    if (self.fullscreenVideoAd) {
        [self.fullscreenVideoAd showAdFromRootViewController:self];
    }
    self.statusLabel.text = @"Tap left button to load Ad";
}

- (void)loadFullscreenVideoAdWithSlotID:(NSString *)slotID {
// important:----- Every time the data is requested, a new one BUFullscreenVideoAd needs to be initialized. Duplicate request data by the same full screen video ad is not allowed.
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:slotID];
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
    self.statusLabel.text = @"Loading......";
}

#pragma mark BURewardedVideoAdDelegate
- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    self.statusLabel.text = @"Ad loaded";
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    self.statusLabel.text = @"Video caching complete";
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    self.statusLabel.text = @"Ad loaded fail";
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error{
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
    
}

- (void)fullscreenVideoAdDidVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
   
}

- (void)fullscreenVideoAdWillClose:(BUFullscreenVideoAd *)fullscreenVideoAd{
   
}

- (void)fullscreenVideoAdCallback:(BUFullscreenVideoAd *)fullscreenVideoAd withType:(BUFullScreenVideoAdType)fullscreenVideoAdType{
   
}


@end
