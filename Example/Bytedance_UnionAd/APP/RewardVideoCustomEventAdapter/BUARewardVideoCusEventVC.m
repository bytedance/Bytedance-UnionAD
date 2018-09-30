//
//  BUARewardVideoCusEventVC.m
//  BUAemo
//
//  Created by bytedance_yuanhuan on 2018/4/13.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUARewardVideoCusEventVC.h"
#import <WMAdSDK/WMRewardedVideoAd.h>
#import <GoogleMobileAds/GADRewardBasedVideoAd.h>

@interface BUARewardVideoCusEventVC ()<GADRewardBasedVideoAdDelegate>
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) GADRewardBasedVideoAd *rewardVideoAd;
@end

@implementation BUARewardVideoCusEventVC

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
    self.button.center = self.view.center;
}

#pragma mark 延迟加载
- (UIButton *)button {
    if (!_button) {
        NSDictionary *attributes = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize:20.0],
                                     NSForegroundColorAttributeName: [UIColor blackColor]
                                     };
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:@"点击观看激励视频" attributes:attributes];
        CGSize stringSize = [attributeString boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesFontLeading context:nil].size;
        _button = [[UIButton alloc] init];
        [_button setAttributedTitle:attributeString forState:UIControlStateNormal];
        _button.frame = CGRectMake(0, 0, stringSize.width + 16, stringSize.height + 10);
        _button.center = self.view.center;
        [_button.layer setBorderWidth:1.0];
        [_button.layer setBorderColor: [UIColor blackColor].CGColor];
        [_button.layer setCornerRadius:3];
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
    NSLog(@"%ld", buttonIndex);
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
