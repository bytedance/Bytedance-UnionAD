//
//  BUARewardedVideoAdViewController.m
//  BUAemo
//
//  Created by gdp on 2018/1/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUARewardedVideoAdViewController.h"
#import <WMAdSDK/WMRewardedVideoAd.h>
#import <WMAdSDK/WMRewardedVideoModel.h>

@interface BUARewardedVideoAdViewController () <WMRewardedVideoAdDelegate>

@property (nonatomic, strong) WMRewardedVideoAd *rewardedVideoAd;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BUARewardedVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildupView];
    WMRewardedVideoModel *model = [[WMRewardedVideoModel alloc] init];
    model.userId = @"123";
    model.isShowDownloadBar = YES;
    self.rewardedVideoAd = [[WMRewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
}

- (void)buildupView {
    [self.view addSubview:self.button];
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
    [self.rewardedVideoAd showAdFromRootViewController:self.navigationController];
}

#pragma mark WMRewardedVideoAdDelegate

- (void)rewardedVideoAdDidLoad:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"reawrded video did load");
    NSString *info = @"激励视频加载成功";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"激励视频" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)rewardedVideoAdWillVisible:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded video will visible");
}

- (void)rewardedVideoAdDidClose:(WMRewardedVideoAd *)rewardedVideoAd {
     NSLog(@"rewarded video did close");
}

- (void)rewardedVideoAd:(WMRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"rewarded video material load fail");
}

- (void)rewardedVideoAdDidPlayFinish:(WMRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"rewarded play error");
    } else {
        NSLog(@"rewarded play finish");
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded verify failed");
}

- (void)rewardedVideoAdServerRewardDidSucceed:(WMRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    NSLog(@"rewarded verify succeed");
    NSLog(@"verify result: %@", verify ? @"success" : @"fail");
}

@end
