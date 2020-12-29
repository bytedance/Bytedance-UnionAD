//
//  BUDRewardedVideoAdViewController.m
//  BUDemo
//
//  Created by gdp on 2018/1/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDRewardedVideoAdViewController.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDRewardedVideoAdViewController () <BURewardedVideoAdDelegate>
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation BUDRewardedVideoAdViewController

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
    [self loadRewardVideoAdWithSlotID:@"900546826"];
}

- (void)loadLandscapeAd:(UIButton *)sender {
    [self loadRewardVideoAdWithSlotID:@"900546319"];
}

- (void)showAd:(UIButton *)sender {
    if (self.rewardedVideoAd) {
        [self.rewardedVideoAd showAdFromRootViewController:self];
    }
    self.statusLabel.text = @"Tap left button to load Ad";
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)loadRewardVideoAdWithSlotID:(NSString *)slotID {
// important: Every time the data is requested, a new one BURewardedVideoAd needs to be initialized. Duplicate request data by the same full screen video ad is not allowed.
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:slotID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
    self.statusLabel.text = @"Loading......";
}

#pragma mark - BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    self.statusLabel.text = @"Ad loaded";
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    self.statusLabel.text = @"Video caching complete";
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    self.statusLabel.text = @"Ad loaded fail";
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd{
   
}

- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd{
    
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    self.statusLabel.text = @"Tap left button to load Ad";
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
   
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd error:(nonnull NSError *)error {
    
}

- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd{
    

}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    
}
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType{
    
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
@end
