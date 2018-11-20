//
//  BUDRewardVideoCusEventVC.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/13.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDRewardVideoCusEventVC.h"
#import <BUAdSDK/BURewardedVideoAd.h>
#import <GoogleMobileAds/GADRewardBasedVideoAd.h>
#import "BUDMacros.h"
#import "BUDNormalButton.h"

@interface BUDRewardVideoCusEventVC ()<GADRewardBasedVideoAdDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) GADRewardBasedVideoAd *rewardVideoAd;
@end

@implementation BUDRewardVideoCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpRewardVideo];
}

- (void)setUpRewardVideo {
//    NSString *adUnitId = @"ca-app-pub-3940256099942544/1712485313"; //官测
    NSString *adUnitId = @"ca-app-pub-1436854326312437/7433042479";//头条测试

    self.rewardVideoAd = [[GADRewardBasedVideoAd alloc] init];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadRequest:[GADRequest request] withAdUnitID:adUnitId];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark 延迟加载
- (UIButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:@"展示激励视频" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark 事件处理

- (void)buttonTapped:(id)sender {
    [self.rewardVideoAd presentFromRootViewController:self.navigationController];
}

# pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"取消");
    } else if (buttonIndex == 1){
        [self.view addSubview:self.button];
    }
    NSLog(@"%ld", (long)buttonIndex);
}

- (void)rewardBasedVideoAd:(nonnull GADRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(nonnull GADAdReward *)reward {
    NSLog(@"%s", __func__);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"%s", __func__);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"视频加载成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    NSLog(@"%s", __func__);
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    NSLog(@"%s", __func__);
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    NSLog(@"%s", __func__);
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    NSLog(@"%s", __func__);
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    NSLog(@"%s", __func__);
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"%s", __func__);
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"%s", __func__);
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    NSLog(@"%s", __func__);
    
}

- (void)setNeedsFocusUpdate {
    NSLog(@"%s", __func__);
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    NSLog(@"%s", __func__);
    return YES;
}

- (void)updateFocusIfNeeded {
    NSLog(@"%s", __func__);
}
@end
