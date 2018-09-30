//
//  WMInterstitialAd.h
//  WMAdSDK
//
//  Created by carl on 2017/7/31.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMAdSDKDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class WMSize;
@protocol WMInterstitialAdDelegate;

@interface WMInterstitialAd : NSObject
@property (nonatomic, weak, nullable) id<WMInterstitialAdDelegate> delegate;
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
 初始化WMInterstitialAd

 @param slotID 代码位ID
 @param expectSize 自定义size,默认 600px * 400px
 @return WMInterstitialAd
 */
- (instancetype)initWithSlotID:(NSString *)slotID size:(WMSize *)expectSize NS_DESIGNATED_INITIALIZER;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;
@end

@protocol WMInterstitialAdDelegate <NSObject>

@optional
/**
    点击插屏广告 回调该函数， 期间可能调起 AppStore ThirdApp WebView etc.
 - Parameter interstitialAd: 产生该事件的 WMInterstitialAd 对象.
 */
- (void)interstitialAdDidClick:(WMInterstitialAd *)interstitialAd;

/**
    关闭插屏广告 回调改函数，   {点击广告， 点击关闭}
 - Parameter interstitialAd: 产生该事件的 WMInterstitialAd 对象.
 */
- (void)interstitialAdDidClose:(WMInterstitialAd *)interstitialAd;

/**
    WMInterstitialAd 广告将要消失， 用户点击关闭按钮
 
 - Parameter interstitialAd: 产生该事件的 WMInterstitialAd 对象.
 */
- (void)interstitialAdWillClose:(WMInterstitialAd *)interstitialAd;

/**
 WMInterstitialAd 广告加载成功
 
 - Parameter interstitialAd: 产生该事件的 WMInterstitialAd 对象.
 */
- (void)interstitialAdDidLoad:(WMInterstitialAd *)interstitialAd;

/**
  WMInterstitialAd 加载失败
 
 - Parameter interstitialAd: 产生该事件的 WMInterstitialAd 对象.
 - Parameter error: 包含详细是失败信息.
 */
- (void)interstitialAd:(WMInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;


/**
   即将展示 插屏广告
 - Parameter interstitialAd: 产生该事件的 WMInterstitialAd 对象.
 */
- (void)interstitialAdWillVisible:(WMInterstitialAd *)interstitialAd;
@end

NS_ASSUME_NONNULL_END
