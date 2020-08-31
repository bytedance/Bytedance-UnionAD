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
#import "BUDTestToolsViewController.h"
#import "BUDAnimationTool.h"
#import <BUFoundation/BUFoundation.h>

#pragma mark - show FPS
#ifdef DEBUG
#define BUFPS_OPEN 0
#else
#define BUFPS_OPEN 0
#endif

@interface AppDelegate () <BUSplashAdDelegate>
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, strong) BUSplashAdView *splashAdView;
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
    [self configTestData];
    [self configFPS];
    [self configAPM];
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
    [[GADMobileAds sharedInstance] startWithCompletionHandler:^(GADInitializationStatus * _Nonnull status) {
        // This is a example to set GDPR. You can change GDPR at right scence
//        [BUAdSDKManager setGDPR:0];
    }];
    
    // mopub adaptor config
    MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:mopub_AD_APPID];
    
    NSMutableDictionary *networkConfig = [NSMutableDictionary dictionaryWithCapacity:2];
    NSMutableDictionary *InitConfig = [[NSMutableDictionary alloc] init];
    //=== required =============================================================================
    [InitConfig setValue:[BUDAdManager appKey] forKey:@"appKey"];

    //=== optional =============================================================================
    /* Set the COPPA of the user, COPPA is the short of Children's Online Privacy Protection Rule, the interface only works in the United States.
    * @params Coppa 0 adult, 1 child
    */
    [InitConfig setValue:@(0) forKey:@"Coppa"];
    /// Set whether the app is a paid app, the default is a non-paid app.
    /// Must obtain the consent of the user before incoming
    [InitConfig setValue:@(NO) forKey:@"isPaidApp"];
    /// Custom set the GDPR of the user,GDPR is the short of General Data Protection Regulation,the interface only works in The European.
    /// @params GDPR 0 close privacy protection, 1 open privacy protection
    [InitConfig setValue:@(0) forKey:@"GDPR"];
    
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
    //optional
    //GDPR 0 close privacy protection, 1 open privacy protection
    [BUAdSDKManager setGDPR:0];
    //optional
    //Coppa 0 adult, 1 child
    [BUAdSDKManager setCoppa:0];
    
#if DEBUG
    // Whether to open log. default is none.
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
//    [BUAdSDKManager setDisableSKAdNetwork:YES];
#endif
    //BUAdSDK requires iOS 9 and up
    [BUAdSDKManager setAppID:[BUDAdManager appKey]];

    [BUAdSDKManager setIsPaidApp:NO];
    // splash AD demo
    [self addSplashAD];
}

#pragma mark - Splash
- (void)addSplashAD {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:normal_splash_ID frame:frame];
    // tolerateTimeout = CGFLOAT_MAX , The conversion time to milliseconds will be equal to 0
    self.splashAdView.tolerateTimeout = 10;
    self.splashAdView.delegate = self;
    //optional
    self.splashAdView.needSplashZoomOutAd = YES;


    UIWindow *keyWindow = self.window;
    self.startTime = CACurrentMediaTime();
    [self.splashAdView loadAdData];
    [keyWindow.rootViewController.view addSubview:self.splashAdView];
    self.splashAdView.rootViewController = keyWindow.rootViewController;
}


- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        UIViewController *parentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [parentVC.view addSubview:splashAd.zoomOutView];
        [parentVC.view bringSubviewToFront:splashAd];
        //Add this view to your container
        [parentVC.view insertSubview:splashAd.zoomOutView belowSubview:splashAd];
        splashAd.zoomOutView.rootViewController = parentVC;
    }
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        [splashAd removeFromSuperview];
    }
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [splashAd.zoomOutView removeFromSuperview];
    }
    [splashAd removeFromSuperview];
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        [splashAd removeFromSuperview];
    }
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    [splashAd removeFromSuperview];
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}





- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    [self pbu_logWithSEL:_cmd msg:@""];
}



- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)pbu_logWithSEL:(SEL)sel msg:(NSString *)msg {
    CFTimeInterval endTime = CACurrentMediaTime();
    BUD_Log(@"SplashAdView In AppDelegate (%@) total run time: %gs, extraMsg:%@", NSStringFromSelector(sel), endTime - self.startTime, msg);
}

#pragma mark - UIApplicationDelegate
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
