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

@interface AppDelegate () <BUSplashAdDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [BUAdSDKManager setAppID:[BUDAdManager appKey]];
    [BUAdSDKManager setIsPaidApp:NO];
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
    NSLog(@"SDKVersion = %@", [BUAdSDKManager SDKVersion]);
    
    /*
     * 选启动图作为 开屏视图的背景图, 有效避免开屏加载慢 或者开屏失败
     */
    CGRect frame = [UIScreen mainScreen].bounds;
    UIImage *backgroundImage = [UIImage imageNamed:@"Group"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    // frame 强烈建议为屏幕大小
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:@"800546808" frame:frame];
    // tolerateTimeout = CGFLOAT_MAX 转化为毫秒会溢出，等效于0 ， 默认tolerateTimeout = 0.5s
    splashView.tolerateTimeout = 10;
    splashView.delegate = self;
    splashView.backgroundColor = backgroundColor;
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [splashView loadAdData];
    splashView.rootViewController = keyWindow.rootViewController;
    
    [keyWindow.rootViewController.view addSubview:splashView];
    
    return YES;
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    NSLog(@"splash close in the rihgt style");
    [splashAd removeFromSuperview];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"splash close with error %@", error);
    [splashAd removeFromSuperview];
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
