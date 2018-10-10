//
//  BUDSplashViewController.m
//  BUDemo
//
//  Created by carl on 2017/8/7.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDSplashViewController.h"

#import "BUAdSDK/BUSplashAdView.h"

@interface BUDSplashViewController () <BUSplashAdDelegate>

@property (nonatomic, strong) BUSplashAdView *splashView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BUDSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    
    const CGFloat buttonHeight = 36;
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.button.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [self.button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [self.button.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [self.button.heightAnchor constraintEqualToConstant:buttonHeight];
    } else {
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        self.button.frame = CGRectMake(0, height - buttonHeight,width , buttonHeight);
    }
    
    [self.button setBackgroundColor:[UIColor orangeColor]];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:NSLocalizedString(@"开屏", @"开屏")  forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
}

- (void)buttonTapped:(UIButton *)sender {
    CGRect frame = self.navigationController.view.bounds;
    self.splashView = [[BUSplashAdView alloc] initWithSlotID:self.viewModel.slotID frame:frame];
    self.splashView.rootViewController = self;
    [self.splashView loadAdData];
    self.splashView.delegate = self;
    [self.navigationController.view addSubview:self.splashView];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    [splashAd removeFromSuperview];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
    [splashAd removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
