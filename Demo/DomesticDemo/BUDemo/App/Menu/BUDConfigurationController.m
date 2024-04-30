//
//  BUDConfigurationController.m
//  BUDemo
//
//  Created by bytedance on 2023/4/14.
//  Copyright © 2023 bytedance. All rights reserved.
//

#import "BUDConfigurationController.h"
#import <BUAdSDK/BUAdSDK.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDAdManager.h"
#import "BUDPrivacyProvider.h"
#import "BUDMacros.h"
#import "BUDMainViewController.h"
#import "UIView+BUDAdditions.h"
#import "BUDAdManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSettingViewController.h"
#import "BUDMainViewController.h"
#import "BUDMainViewModel.h"
#import "RRFPSBar.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDTestToolsViewController.h"
#import "BUDAnimationTool.h"
#import "BUDPrivacyProvider.h"
#import <AVFoundation/AVFoundation.h>
#if __has_include(<BUAdLive/BUAdLive.h>)
#import <BUAdLive/BUAdLive.h>
#endif
#if __has_include(<BUAdTestMeasurement/BUAdTestMeasurement.h>)
#import <BUAdTestMeasurement/BUAdTestMeasurement.h>
#endif

#pragma mark - show FPS
#ifdef DEBUG
#define BUFPS_OPEN 0
#else
#define BUFPS_OPEN 0
#endif

@interface BUDConfigurationController ()
@property (nonatomic, strong) UIButton *configurationButton;
@property (nonatomic, strong) UIButton *startButton;
@end

@implementation BUDConfigurationController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *barAppearance = [[UINavigationBarAppearance alloc] init];
        barAppearance.backgroundColor = titleBGColor;
        barAppearance.shadowImage = [[UIImage alloc] init];
        barAppearance.shadowColor = nil;
        [barAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        self.navigationController.navigationBar.standardAppearance = barAppearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = barAppearance;
    } else {
        //设置导航栏背景图片为一个空的image，这样就透明了
        self.navigationController.navigationBar.barTintColor = titleBGColor;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        //去掉透明后导航栏下边的黑边
        
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.title = @"穿山甲SDK";
    
    [self setup];
}

- (void)setup {
    UIButton *configurationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.configurationButton = configurationButton;
    [configurationButton setTitle:@"SDK初始化" forState:UIControlStateNormal];
    [configurationButton addTarget:self action:@selector(configurationAction) forControlEvents:UIControlEventTouchUpInside];
    configurationButton.bud_size = CGSizeMake(300, 40);
    configurationButton.bu_centerX = self.view.bu_centerX;
    configurationButton.bu_centerY = self.view.bu_centerY - 150;
    configurationButton.backgroundColor = [UIColor colorWithRed:237.0 / 255.0 green:109.0 / 255.0 blue:98.0 / 255.0 alpha:1.0];
    [configurationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:configurationButton];
    
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startButton = startButton;
    [startButton setTitle:@"Start并进入广告" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    startButton.bud_size = CGSizeMake(300, 40);
    startButton.bu_centerX = self.view.bu_centerX;
    startButton.bu_centerY = configurationButton.bud_bottom + 100;
    startButton.backgroundColor = [UIColor colorWithRed:237.0 / 255.0 green:109.0 / 255.0 blue:98.0 / 255.0 alpha:1.0];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:startButton];
}

- (void)configurationAction {
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    configuration.appID = [BUDAdManager appKey];
    configuration.privacyProvider = [[BUDPrivacyProvider alloc] init];
    configuration.appLogoImage = [UIImage imageNamed:@"AppIcon"];

    [self showMessage:@"SDK配置信息设置完成,可以启动SDK了" delay:1.0];
}




- (void)startAction {
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    
    if (configuration.appID.length == 0) {
        [self showMessage:@"appID为空，请先初始化" delay:1.0];
        return;
    }
    [self showMessage:@"Start..." delay:0.5];
    [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self showMessage:@"Start success!" delay:0.5];
                
                BUDMainViewController *mainVC = [[BUDMainViewController alloc] init];
                [self.navigationController pushViewController:mainVC animated:YES];
                //  private config for demo
                [self configDemo];
                //  Setup live stream ad
#if __has_include(<BUAdLive/BUAdLive.h>)
                [BUAdSDKManager setUpLiveAdSDK];
#endif
            } else {
                [self showMessage:@"Start failed!" delay:0.5];
            }
        });
    }];
}


- (void)showMessage:(NSString *)message delay:(CGFloat)delay{
    MBProgressHUD *messageHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    messageHUD.mode = MBProgressHUDModeText;
    messageHUD.label.text = message;
    messageHUD.bud_size = CGSizeMake(self.view.bud_size.width, self.view.bud_bottom - self.startButton.bud_bottom);
    messageHUD.bud_bottom = self.view.bud_bottom;
    [messageHUD hideAnimated:YES afterDelay:delay];
}

#pragma mark - configuration
- (void)configDemo {
    [self configTestData];
    [self configFPS];
}

- (void)configTestData {
    // initialize test data
    [BUDTestToolsViewController initializeTestSetting];
}

- (void)configFPS {
    // show FPS
    if (BUFPS_OPEN == 1) {
        [RRFPSBar sharedInstance].showsAverage = YES;
        [[RRFPSBar sharedInstance] setHidden:NO];
    }
}

@end
