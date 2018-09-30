//
//  BUAAppDelegate.m
//  Bytedance_UnionAd
//
//  Created by yh980237697 on 08/07/2018.
//  Copyright (c) 2018 yh980237697. All rights reserved.
//

#import "BUAAppDelegate.h"
#import "BUAAdManager.h"
#import <WMAdSDK/WMAdSDKManager.h>
#import "WMAdSDK/WMSplashAdView.h"

@interface BUAAppDelegate () <WMSplashAdDelegate>

@end
@implementation BUAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WMAdSDKManager setAppID:[BUAAdManager appKey]];
    [WMAdSDKManager setIsPaidApp:NO];
    [WMAdSDKManager setLoglevel:WMAdSDKLogLevelDebug];
    NSLog(@"SDKVersion = %@", [WMAdSDKManager SDKVersion]);
    
    /*
     * 选启动图作为 开屏视图的背景图, 有效避免开屏加载慢 或者开屏失败
     */
    CGRect frame = [UIScreen mainScreen].bounds;
    UIImage *backgroundImage = [UIImage imageNamed:@"Group"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    // frame 强烈建议为屏幕大小
    WMSplashAdView *spalshView = [[WMSplashAdView alloc] initWithSlotID:@"800546808" frame:frame];
    // tolerateTimeout = CGFLOAT_MAX 转化为毫秒会溢出，等效于0 ， 默认tolerateTimeout = 0.5s
    spalshView.tolerateTimeout = 10;
    spalshView.delegate = self;
    spalshView.backgroundColor = backgroundColor;
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [spalshView loadAdData];
    spalshView.rootViewController = keyWindow.rootViewController;
    
    [keyWindow.rootViewController.view addSubview:spalshView];
    
    return YES;
}

- (void)spalshAdDidClose:(WMSplashAdView *)spalshAd {
    NSLog(@"splash close in the rihgt style");
    [spalshAd removeFromSuperview];
}

- (void)spalshAd:(WMSplashAdView *)spalshAd didFailWithError:(NSError *)error {
    NSLog(@"splash close with error %@", error);
    [spalshAd removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
