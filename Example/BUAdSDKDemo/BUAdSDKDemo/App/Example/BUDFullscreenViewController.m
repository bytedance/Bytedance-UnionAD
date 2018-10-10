//
//  BUDFullscreenViewController.m
//  BUAdSDKDemo
//
//  Created by 李盛 on 2018/8/29.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDFullscreenViewController.h"
#import <BUAdSDK/BUFullscreenVideoAd.h>

@interface BUDFullscreenViewController () <BUFullscreenVideoAdDelegate>

@property (nonatomic, strong) BUFullscreenVideoAd *fullscreenVideoAd;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BUDFullscreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#warning 每次请求数据 需要重新创建一个对应的 BUFullscreenVideoAd管理,不可使用同一条重复请求数据.
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:self.viewModel.slotID];
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
    [self.view addSubview:self.button];
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
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:@"点击观看全屏视频" attributes:attributes];
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
    [self.fullscreenVideoAd showAdFromRootViewController:self.navigationController];
}

#pragma mark BURewardedVideoAdDelegate

- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"material load success");
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"video data load success");
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"fullscreenVideoAd click skip");
}

@end
