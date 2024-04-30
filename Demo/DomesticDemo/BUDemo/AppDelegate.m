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
#import "RRFPSBar.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDTestToolsViewController.h"
#import "BUDAnimationTool.h"
#import "BUDPrivacyProvider.h"
#import <AVFoundation/AVFoundation.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
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

@interface AppDelegate () <BUSplashAdDelegate, BUSplashCardDelegate, BUSplashZoomOutDelegate>
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, strong) BUSplashAd *splashAd;
@property (nonatomic, strong) AVAudioPlayer *audioPlay;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

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

- (void)setupBUAdSDK {

#if __has_include(<BUAdTestMeasurement/BUAdTestMeasurement.h>)
    #if DEBUG
        // 测试工具
        [BUAdTestMeasurementConfiguration configuration].debugMode = YES;
    #endif
#endif

    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    configuration.appID = [BUDAdManager appKey];
    configuration.privacyProvider = [[BUDPrivacyProvider alloc] init];
    configuration.appLogoImage = [UIImage imageNamed:@"AppIcon"];
    configuration.debugLog = @(1);
    
    // 如果使用聚合维度功能，则务必将以下字段设置为YES
    // 并检查工程有引用CSJMediation.framework，这样SDK初始化时将启动聚合相关必要组件
    configuration.useMediation = NO;
    [self useMediationSettings];
    
    [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 聚合维度首次预缓存
                [self useMediationPreload];
//                 splash AD demo
                [self addSplashAD];
//                 private config for demo
                [self configDemo];
//                 Setup live stream ad
#if __has_include(<BUAdLive/BUAdLive.h>)
                [BUAdSDKManager setUpLiveAdSDK];
#endif
                
            });
        }
    }];
    
//    [self playerCoustomAudio];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestIDFATracking];
    });
}

- (void)requestIDFATracking {
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                    NSLog(@"%@",idfa);
            } else {
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            NSLog(@"%@",idfa);
        } else {
            NSLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
}

// 关于使用聚合功能的相关设置
- (void)useMediationSettings {
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    // 聚合流量分组
    BUMUserInfoForSegment *segment = [[BUMUserInfoForSegment alloc] init];
    segment.user_id = @"Please enter your user's Id";
    segment.user_value_group = @"group1";
    segment.age = 19;
    segment.gender = BUUserInfoGenderMale;
    segment.channel = @"Apple";
    segment.sub_channel = @"Apple store";
    segment.customized_id = @{@(1):@"345",// key非string,不合规
                              @"key2":@"good",// 合规,上报
                              @"key3":@(1),// value非string,不合规
                              @"key4":@"123aA-_",// 合规,上报
                              @"key5":@"123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_1",// 长度超100,不合规
                              @"key6":@"123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_123456aA-_",// 合规,上报
                              @"key7":@"123aA-_*",// value包含特殊字符,不合规
    };
    configuration.mediation.userInfoForSegment = segment;
    // 隐私合规
    configuration.mediation.limitPersonalAds = @(0);
    configuration.mediation.limitProgrammaticAds = @(0);
    configuration.mediation.forbiddenCAID = @(0);
    // 提前导入配置
    configuration.mediation.advanceSDKConfigPath = [[NSBundle mainBundle]pathForResource:@"GroMore-config-ios-5000546" ofType:@"json"];
    // 其他设置
    configuration.mediation.extraDeviceMap = @{ @"device_id": @"1234567" };
}

// 聚合维度首次预缓存
- (void)useMediationPreload {
    /**

    Call this method after SDK inited.

    */
    BUNativeExpressFullscreenVideoAd *fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:gromore_newInterstitial_ID];

    // 预缓存广告对象，是否能够成功预缓存依赖于后台配置中是否开启广告位的预缓存功能！！！
    [BUAdSDKManager.mediation preloadAdsWithInfos:@[fullscreenAd] andInterval:2 andConcurrent:1];
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
    
    // 穿山甲开屏广告
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


- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nullable NSError *)error {
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
