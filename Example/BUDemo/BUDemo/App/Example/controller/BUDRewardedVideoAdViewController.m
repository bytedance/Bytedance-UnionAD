//
//  BUDRewardedVideoAdViewController.m
//  BUDemo
//
//  Created by gdp on 2018/1/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDRewardedVideoAdViewController.h"
#import <BUAdSDK/BURewardedVideoAd.h>
#import <BUAdSDK/BURewardedVideoModel.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"

@interface BUDRewardedVideoAdViewController () <BURewardedVideoAdDelegate>

@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@property (nonatomic, strong) BUDNormalButton *button;

@end

@implementation BUDRewardedVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#warning Every time the data is requested, a new one BURewardedVideoAd needs to be initialized. Duplicate request data by the same full screen video ad is not allowed.
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
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
        [_button setTitle:[NSString localizedStringForKey:ShowRewardVideo] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)buttonTapped:(id)sender {
    // Return YES when material is effective,data is not empty and has not been displayed.
    //Repeated display is not charged.
    [self.rewardedVideoAd showAdFromRootViewController:self.navigationController ritScene:BURitSceneType_home_get_bonus ritSceneDescribe:nil];
//    [self.rewardedVideoAd showAdFromRootViewController:self.navigationController ritScene:BURitSceneType_custom ritSceneDescribe:@"scene_custom"];
}

#pragma mark BURewardedVideoAdDelegate

- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewardedVideoAd data load success");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"reawrded data load success";
    [hud hideAnimated:YES afterDelay:0.1];
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewardedVideoAd video load success");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"reawrded video load success";
    [hud hideAnimated:YES afterDelay:1];
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewardedVideoAd video will visible");
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
     BUD_Log(@"rewardedVideoAd video did close");
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewardedVideoAd video did click");
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    BUD_Log(@"rewardedVideoAd data load fail");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"rewarded video material load fail";
    [hud hideAnimated:YES afterDelay:1];
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error) {
        BUD_Log(@"rewardedVideoAd play error");
    } else {
        BUD_Log(@"rewardedVideoAd play finish");
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewardedVideoAd verify failed");
    
    BUD_Log(@"Demo RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    BUD_Log(@"Demo RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    BUD_Log(@"rewardedVideoAd verify succeed");
    BUD_Log(@"verify result: %@", verify ? @"success" : @"fail");
    
    BUD_Log(@"Demo RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    BUD_Log(@"Demo RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
@end
