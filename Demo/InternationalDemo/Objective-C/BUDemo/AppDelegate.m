//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "AppDelegate.h"
#import "BUDAdManager.h"
#import "BUDSettingViewController.h"
#import "BUDMainViewController.h"
#import "BUDMainViewModel.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "RRFPSBar.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <AVFoundation/AVFoundation.h>
#import <PAGAdSDK/PAGAdSDK.h>

#import <AdSupport/AdSupport.h>
#if defined(__IPHONE_14_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_14_0
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#endif

#pragma mark - show FPS
#ifdef DEBUG
#define BUFPS_OPEN 1
#else
#define BUFPS_OPEN 0
#endif

@interface AppDelegate () 
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, strong) AVAudioPlayer *audioPlay;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // adaptor for Customer Event

    if (self.window == nil) {
        UIWindow *keyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [keyWindow makeKeyAndVisible];
        self.window = keyWindow;
        self.window.rootViewController = [self rootViewController];
    }
    
    [self setupPangleSDK];

   
    return YES;
}



- (UIViewController *)rootViewController {
    BUDMainViewController *mainViewController = [[BUDMainViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    return navigationVC;
}

- (void)setupPangleSDK {
    PAGConfig *config = [PAGConfig shareConfig];
    config.appID = [BUDAdManager appKey];
    config.appLogoImage = [UIImage imageNamed:@"AppIcon"];
#if DEBUG
    config.debugLog = YES;
#endif
    [PAGSdk startWithConfig:config completionHandler:^(BOOL success, NSError * _Nonnull error) {
        if (success) {
            //load ad data
        }
    }];
}

- (void)getIDFA {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *IDFA = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
                NSLog(@"IDFA: %@", IDFA);
            } else {
                NSLog(@"ATTrackingManagerAuthorizationStatus not authorized");
            }
        }];
    } else {
        if (ASIdentifierManager.sharedManager.isAdvertisingTrackingEnabled) {
            NSString *IDFA = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
            NSLog(@"IDFA: %@", IDFA);
        } else {
            NSLog(@"advertising tracking not enabled");
        }
    }
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
