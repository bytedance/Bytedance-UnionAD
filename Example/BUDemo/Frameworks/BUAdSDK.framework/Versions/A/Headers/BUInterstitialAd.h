//
//  BUInterstitialAd.h
//  BUAdSDK
//
//  Created by carl on 2017/7/31.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUAdSDKDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BUSize;
@protocol BUInterstitialAdDelegate;

@interface BUInterstitialAd : NSObject
@property (nonatomic, weak, nullable) id<BUInterstitialAdDelegate> delegate;
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
 初始化BUInterstitialAd

 @param slotID 代码位ID
 @param expectSize 自定义size,默认 600px * 400px
 @return BUInterstitialAd
 */
- (instancetype)initWithSlotID:(NSString *)slotID size:(BUSize *)expectSize NS_DESIGNATED_INITIALIZER;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;
@end

@protocol BUInterstitialAdDelegate <NSObject>

@optional
/**
    点击插屏广告 回调该函数， 期间可能调起 AppStore ThirdApp WebView etc.
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdDidClick:(BUInterstitialAd *)interstitialAd;

/**
    关闭插屏广告 回调改函数，   {点击广告， 点击关闭}
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd;

/**
    BUInterstitialAd 广告将要消失， 用户点击关闭按钮
 
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdWillClose:(BUInterstitialAd *)interstitialAd;

/**
 BUInterstitialAd 广告加载成功
 
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd;

/**
  BUInterstitialAd 加载失败
 
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 - Parameter error: 包含详细是失败信息.
 */
- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;


/**
   即将展示 插屏广告
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdWillVisible:(BUInterstitialAd *)interstitialAd;
@end

NS_ASSUME_NONNULL_END
