//
//  WMSplashAdView.h
//  WMAdSDK
//
//  Created by carl on 2017/8/1.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WMSplashAdDelegate;

@interface WMSplashAdView : UIView
/**
 插屏广告位 id
 */
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;

/**
 允许最大的加载超时时间, 默认2s, 单位s
 */
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;


/**
 隐藏跳过按钮, 默认NO， 隐藏跳过按钮之后， 需要自定义实现倒计时
 */
@property (nonatomic, assign) BOOL hideSkipButton;

/**
 开屏启动的 状态回调
 */
@property (nonatomic, weak, nullable) id<WMSplashAdDelegate> delegate;

/*
 广告位展示落地页ViewController的rootviewController，必传参数
 */
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 开屏数据是否已经加载完成
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;


/**
  实例开屏广告视图
 @param slotID 广告位id
 @param frame 建议为手机屏幕，否者影响展示效果
 @return 开屏广告视图
 */
- (instancetype)initWithSlotID:(NSString *)slotID frame:(CGRect)frame;

/**
 初始化开屏视图后需要主动 加载数据， 并开始超时计时 @tolerateTimeout
 */
- (void)loadAdData;
@end


@protocol WMSplashAdDelegate <NSObject>

@optional
/**
 点击开屏广告 回调该函数， 期间可能吊起 AppStore ThirdApp WebView etc.
 - Parameter spalshAd: 产生该事件的 SplashView 对象.
 */
- (void)spalshAdDidClick:(WMSplashAdView *)spalshAd;

/**
    关闭开屏广告， {点击广告， 点击跳过，超时}
 - Parameter spalshAd: 产生该事件的 SplashView 对象.
 */
- (void)spalshAdDidClose:(WMSplashAdView *)spalshAd;

/**
   spalshAd 广告将要消失， 用户点击 {跳过 超时}
 - Parameter spalshAd: 产生该事件的 SplashView 对象.
 */
- (void)spalshAdWillClose:(WMSplashAdView *)spalshAd;

/**
 spalshAd 广告加载成功
 - Parameter spalshAd: 产生该事件的 SplashView 对象.
 */
- (void)spalshAdDidLoad:(WMSplashAdView *)spalshAd;

/**
 spalshAd 加载失败
 
 - Parameter spalshAd: 产生该事件的 SplashView 对象.
 - Parameter error: 包含详细是失败信息.
 */
- (void)spalshAd:(WMSplashAdView *)spalshAd didFailWithError:(NSError *)error;

/**
 即将展示 开屏广告
 - Parameter spalshAd: 产生该事件的 SplashView 对象.
 */
- (void)spalshAdWillVisible:(WMSplashAdView *)spalshAd;
@end

NS_ASSUME_NONNULL_END

