//
//  AppDelegate.m
//  BUDemo
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import "AppDelegate.h"
#import "BUDAdManager.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import "BUAdSDK/BUSplashAdView.h"
#import "BUDConfigHelper.h"
#import "BUDSettingViewController.h"
#import "BUDMainViewController.h"
#import "BUDMainViewModel.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "RRFPSBar.h"
#import "Mopub.h"
#import "BUDMacros.h"

#pragma mark - 展示FPS的开关
#ifdef DEBUG
#define BUFPS_OPEN 0
#else
#define BUFPS_OPEN 0
#endif

static NSString * const MopubADUnitID = @"e1cbce0838a142ec9bc2ee48123fd470";


@interface AppDelegate () <BUSplashAdDelegate>
@property (nonatomic, assign) CFTimeInterval startTime;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configCustomEvent];
    
    UIViewController *rootViewController = [self rootViewControllerStyleTwo];
    if (self.window == nil) {
        UIWindow *keyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [keyWindow makeKeyAndVisible];
        self.window = keyWindow;
    }
    self.window.rootViewController = rootViewController;
    
    [BUAdSDKManager setAppID:[BUDAdManager appKey]];
    [BUAdSDKManager setIsPaidApp:NO];
#if DEBUG
    //是否打开log信息，默认没有
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
#endif
    
    CGRect frame = [UIScreen mainScreen].bounds;
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:@"800546808" frame:frame];
    // tolerateTimeout = CGFLOAT_MAX , 转换时间时间毫秒会越界 等效于 0
    splashView.tolerateTimeout = 10;
    splashView.delegate = self;

    UIWindow *keyWindow = self.window;
    self.startTime = CACurrentMediaTime();
    [splashView loadAdData];
    [keyWindow.rootViewController.view addSubview:splashView];
    splashView.rootViewController = keyWindow.rootViewController;

    return YES;
}

- (UIViewController *)rootViewControllerStyleOne {
    UITabBarController *tabbarViewController = [[UITabBarController alloc] init];
    
    BUDMainViewController *mainViewController = [[BUDMainViewController alloc] init];
    BUDMainViewModel *mainViewModel = [[BUDMainViewModel alloc] init];
    mainViewModel.custormNavigation = YES;
    mainViewController.viewModel = mainViewModel;
   
    BUDSettingViewController *settingViewController = [[BUDSettingViewController alloc] init];
    UIViewController *viewController = [[UIViewController alloc] init];
    NSArray<UIViewController *> *viewControllers = @[mainViewController, viewController, settingViewController];
    
    NSMutableArray *items = @[].mutableCopy;
    for (NSInteger index = 0; index < viewControllers.count; index++) {
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:nil tag:0];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewControllers[index]];
        nav.tabBarItem = barItem;
        [items addObject:nav];
    }
    [tabbarViewController setViewControllers:items animated:NO];
    return tabbarViewController;
}

- (UIViewController *)rootViewControllerStyleTwo {
    BUDMainViewController *mainViewController = [[BUDMainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    return nav;
}

- (void)configCustomEvent {
    
    [[BUDConfigHelper sharedInstance] readingPreference];
    
    ///如果使用adMob聚合配置appId
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-9206388280072239~5099042698"];
    
    // 展示FPS监测栏
    if (BUFPS_OPEN == 1) {
        [RRFPSBar sharedInstance].showsAverage = YES;
        [[RRFPSBar sharedInstance] setHidden:NO];
    }
    
    
    MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:MopubADUnitID];
    sdkConfig.globalMediationSettings = @[];
    Class<MPMediationSdkInitializable> BURewardCusEvent = NSClassFromString(@"BUDMopub_RewardedVideoCustomEvent");
    if (BURewardCusEvent != nil) {
        sdkConfig.mediatedNetworks = @[BURewardCusEvent];
    }
    [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
        BUD_Log(@"Mopub");
    }];
    [MoPub sharedInstance].logLevel = MPLogLevelInfo;
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    [splashAd removeFromSuperview];
    CFTimeInterval endTime = CACurrentMediaTime();
    BUD_Log(@"Total Runtime: %g s", endTime - self.startTime);
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    [splashAd removeFromSuperview];
    CFTimeInterval endTime = CACurrentMediaTime();
    BUD_Log(@"Total Runtime: %g s error=%@", endTime - self.startTime, error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[BUDConfigHelper sharedInstance] readingPreference];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
