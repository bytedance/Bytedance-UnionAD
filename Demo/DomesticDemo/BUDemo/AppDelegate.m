//
//  AppDelegate.m
//  BUDemo
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import "AppDelegate.h"
#import "BUDAdManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSettingViewController.h"
#import "BUDMainViewController.h"
#import "BUDMainViewModel.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "RRFPSBar.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDTestToolsViewController.h"
#import "BUDAnimationTool.h"
#import "BUDPrivacyProvider.h"
#import <AVFoundation/AVFoundation.h>

#if __has_include(<BUAdTestMeasurement/BUAdTestMeasurement.h>)
#import <BUAdTestMeasurement/BUAdTestMeasurement.h>
#endif

#pragma mark - show FPS
#ifdef DEBUG
#define BUFPS_OPEN 0
#else
#define BUFPS_OPEN 0
#endif

@interface AppDelegate () <BUSplashAdDelegate, BUSplashCardDelegate, BUSplashZoomOutDelegate>
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, strong) BUSplashAd *splashAd;
@property (nonatomic, strong) AVAudioPlayer *audioPlay;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
        // [BUAdSDKManager setGDPR:0];
    }];
}

- (void)setupBUAdSDK {

#if __has_include(<BUAdTestMeasurement/BUAdTestMeasurement.h>)
    #if DEBUG
        // 测试工具
        [BUAdTestMeasurementConfiguration configuration].debugMode = YES;
    #endif
#endif
    
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    configuration.territory = BUAdSDKTerritory_CN;
#if DEBUG
    configuration.logLevel = BUAdSDKLogLevelVerbose;
#endif
    configuration.appID = [BUDAdManager appKey];
    configuration.privacyProvider = [[BUDPrivacyProvider alloc] init];
    configuration.appLogoImage = [UIImage imageNamed:@"AppIcon"];
    [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // splash AD demo
                [self addSplashAD];
                // private config for demo
                [self configDemo];
            });
        }
    }];
   
//    [self playerCoustomAudio];
  
}

- (void)playerCoustomAudio {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    //初始化播放器对象
    self.audioPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
    //设置声音的大小
    self.audioPlay.volume = 0.5;//范围为（0到1）；
    //设置循环次数，如果为负数，就是无限循环
    self.audioPlay.numberOfLoops =-1;
    //设置播放进度
    self.audioPlay.currentTime = 0;
    //准备播放
    [self.audioPlay prepareToPlay];
    [self.audioPlay play];
}

#pragma mark - Splash
- (void)addSplashAD {
    CGRect frame = [UIScreen mainScreen].bounds;

    self.startTime = CACurrentMediaTime();
    
    BUSplashAd *splashAd = [[BUSplashAd alloc] initWithSlotID:express_splash_ID adSize:frame.size];
    splashAd.supportCardView = YES;
    splashAd.supportZoomOutView = YES;
    
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    splashAd.delegate = self;
    splashAd.cardDelegate = self;
    splashAd.zoomOutDelegate = self;
    splashAd.tolerateTimeout = 3;
    /***
    广告加载成功的时候，会立即渲染WKWebView。
    如果想预加载的话，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
    */
    self.splashAd = splashAd;
    [self.splashAd loadAdData];
}

- (void)splashAdLoadSuccess:(nonnull BUSplashAd *)splashAd {
    UIWindow *keyWindow = self.window;
    [splashAd showSplashViewInRootViewController:keyWindow.rootViewController];
}

- (void)splashAdLoadFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdRenderFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashAdRenderSuccess:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillShow:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidShow:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(nonnull BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardReadyToShow:(nonnull BUSplashAd *)splashAd {
    UIWindow *keyWindow = self.window;
    [splashAd showCardViewInRootViewController:keyWindow.rootViewController];
    
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nonnull NSError *)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutReadyToShow:(nonnull BUSplashAd *)splashAd {
    
    UIWindow *keyWindow = self.window;
    
    // 接入方法一：使用SDK提供动画接入
    if (splashAd.zoomOutView) {
        [splashAd showZoomOutViewInRootViewController:keyWindow.rootViewController];
    }
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
