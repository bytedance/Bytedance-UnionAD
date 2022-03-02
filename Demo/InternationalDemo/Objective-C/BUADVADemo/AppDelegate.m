//
//  AppDelegate.m
//  BUDemo
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import "AppDelegate.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMainViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <Bugly/Bugly.h>
#import "BUDAppOpenAdManager.h"

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
}

- (void)setupBUAdSDK {
    
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    configuration.appID = @"5000546";
#if DEBUG
    configuration.logLevel = BUAdSDKLogLevelDebug;
#endif
    [BUAdSDKManager startWithSyncCompletionHandler:^(BOOL success, NSError *error) {
        // TODO: //
        if (success) {
            [[BUDAppOpenAdManager sharedInstance] loadAdWithSlotId:@"890000021"];
        }
    }];
    
//    ///optional
//    ///CN china, NO_CN is not china
//    ///you‘d better set Territory first,  if you need to set them
////    [BUAdSDKManager setTerritory:BUAdSDKTerritory_CN];
//    //optional
//    //GDPR 0 close privacy protection, 1 open privacy protection
//    [BUAdSDKManager setGDPR:0];
//    //optional
//    //Coppa 0 adult, 1 child
//    [BUAdSDKManager setCoppa:0];
//    
//    [BUAdSDKManager setIsPaidApp:NO];
//    
//#if DEBUG
//    // Whether to open log. default is none.
//    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
////    [BUAdSDKManager setDisableSKAdNetwork:YES];
//#endif
//    //BUAdSDK requires iOS 9 and up
//    [BUAdSDKManager setAppID:@"5000546"];
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
    UIViewController *rootViewController = application.keyWindow.rootViewController;
    [BUDAppOpenAdManager.sharedInstance showAdIfAvailable:rootViewController];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
