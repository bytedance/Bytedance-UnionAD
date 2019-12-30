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
#import "BUDSettingViewController.h"
#import "BUDMainViewController.h"
#import "BUDMainViewModel.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "RRFPSBar.h"
#import "MoPub.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <Bugly/Bugly.h>
#import "BUAdSDKAdapterConfiguration.h"

#pragma mark - show FPS
#ifdef DEBUG
#define BUFPS_OPEN 0
#else
#define BUFPS_OPEN 0
#endif

@interface AppDelegate () <BUSplashAdDelegate>
@property (nonatomic, assign) CFTimeInterval startTime;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // private config for demo
    [self configDemo];
    
    // adaptor for Customer Event
    [self configCustomEvent];

    if (self.window == nil) {
        UIWindow *keyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [keyWindow makeKeyAndVisible];
        self.window = keyWindow;
        self.window.rootViewController = [self rootViewController];
    }
    
    // initialize AD SDK
    [self setupBUAdSDK];
    
    return YES;
}

- (UIViewController *)rootViewController {
    BUDMainViewController *mainViewController = [[BUDMainViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    return navigationVC;
}

- (void)configDemo {
    [self configFPS];
    [self configAPM];
}

- (void)configFPS {
    // show FPS
    if (BUFPS_OPEN == 1) {
        [RRFPSBar sharedInstance].showsAverage = YES;
        [[RRFPSBar sharedInstance] setHidden:NO];
    }
}

- (void)configAPM {
    // bugly
    BuglyConfig *buglyconfig = [[BuglyConfig alloc] init];
    buglyconfig.debugMode = YES;
    [Bugly startWithAppId:@"b39a3d744a" config:buglyconfig];
}

- (void)configCustomEvent {
    /**
     admob和mopub各个代码位所对应的adapter请去admob和mopub的对应官网申请(demo的对应关系参见BUDSlotID类)。
     demo只是给出一个接入参考，具体的使用请结合业务场景。
     The adapter corresponding to each code bit of admob and mopub can be applied to the corresponding official website of admob and mopub (see BUDSlotID class for the corresponding relation of demo).
     The demo only provides an access reference, please combine the specific use of the business scenario.
     */
    // admob adaptor config
    // add appKey in info.plist (key:GADApplicationIdentifier)
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    
    // mopub adaptor config
    MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:mopub_AD_APPID];
    
    NSMutableDictionary *networkConfig = [NSMutableDictionary dictionaryWithCapacity:2];
    NSDictionary *InitConfig = @{@"appKey": [BUDAdManager appKey]};
    NSDictionary *config = @{@"BUAdSDKAdapterConfiguration":InitConfig};
    [networkConfig addEntriesFromDictionary:config];
    Class<MPAdapterConfiguration> BUAdSDKAdapterConfiguration = NSClassFromString(@"BUAdSDKAdapterConfiguration");
    sdkConfig.additionalNetworks = @[BUAdSDKAdapterConfiguration];
    sdkConfig.mediatedNetworkConfigurations = networkConfig;
#if DEBUG
    sdkConfig.loggingLevel = MPBLogLevelInfo;
#endif
    sdkConfig.globalMediationSettings = @[];
    
    [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
        BUD_Log(@"Mopub initializeSdk");
    }];
}

- (void)setupBUAdSDK {
    //BUAdSDK requires iOS 9 and up
    [BUAdSDKManager setAppID:[BUDAdManager appKey]];
#if DEBUG
    // Whether to open log. default is none.
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
#endif
    [BUAdSDKManager setIsPaidApp:NO];
    
    // splash AD demo
    [self addSplashAD];
}

- (void)addSplashAD {
    CGRect frame = [UIScreen mainScreen].bounds;
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:normal_splash_ID frame:frame];
    // tolerateTimeout = CGFLOAT_MAX , The conversion time to milliseconds will be equal to 0
    splashView.tolerateTimeout = 10;
    splashView.delegate = self;
    
    UIWindow *keyWindow = self.window;
    self.startTime = CACurrentMediaTime();
    [splashView loadAdData];
    [keyWindow.rootViewController.view addSubview:splashView];
    splashView.rootViewController = keyWindow.rootViewController;
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

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    CFTimeInterval endTime = CACurrentMediaTime();
    BUD_Log(@"Total Showtime: %g s", endTime - self.startTime);
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
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
