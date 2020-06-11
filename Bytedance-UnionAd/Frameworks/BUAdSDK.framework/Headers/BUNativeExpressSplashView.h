//
//  BUNativeExpressSplashView.h
//  BUAdSDK
//
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"

@class BUNativeExpressSplashView;

NS_ASSUME_NONNULL_BEGIN
@protocol BUNativeExpressSplashViewDelegate <NSObject>
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)nativeExpressSplashViewDidLoad:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressSplashView:(BUNativeExpressSplashView *)splashAdView didFailWithError:(NSError * _Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpressSplashViewRenderSuccess:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressSplashViewRenderFail:(BUNativeExpressSplashView *)splashAdView error:(NSError * __nullable)error;

/**
 This method is called when nativeExpressSplashAdView will be showing.
 */
- (void)nativeExpressSplashViewWillVisible:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when nativeExpressSplashAdView is clicked.
 */
- (void)nativeExpressSplashViewDidClick:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when nativeExpressSplashAdView's skip button is clicked.
 */
- (void)nativeExpressSplashViewDidClickSkip:(BUNativeExpressSplashView *)splashAdView;
/**
 This method is called when nativeExpressSplashAdView countdown equals to zero
 */
- (void)nativeExpressSplashViewCountdownToZero:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when nativeExpressSplashAdView closed.
 */
- (void)nativeExpressSplashViewDidClose:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when when video ad play completed or an error occurred.
 */
- (void)nativeExpressSplashViewFinishPlayDidPlayFinish:(BUNativeExpressSplashView *)splashView didFailWithError:(NSError *)error;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressSplashViewDidCloseOtherController:(BUNativeExpressSplashView *)splashView interactionType:(BUInteractionType)interactionType;

@end



@interface BUNativeExpressSplashView : UIView
/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<BUNativeExpressSplashViewDelegate> delegate;

/**
 Maximum allowable load timeout, default 3s, unit s.
 */
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;

/**
 Whether hide skip button, default NO.
 If you hide the skip button, you need to customize the countdown.
 */
@property (nonatomic, assign) BOOL hideSkipButton;

/**
 Whether the splash ad data has been loaded.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

/**
 Initializes native express splash ad with slot id and frame.
 @param slotID : the unique identifier of splash ad
 @param adSize : the adSize of native express splashAd view. It is recommended for the mobile phone screen.
 @return BUNativeExpressSplashView
 */
- (instancetype)initWithSlotID:(NSString *)slotID adSize:(CGSize)adSize rootViewController:(UIViewController *)rootViewController;

/**
 adload_seq：（针对聚合广告位）传递本次请求是为“自然日内某设备某广告位置第N次展示机会”发出的广告请求，同物理位置在自然日从1开始计数，不同物理位置独立计数；example：某原生广告位置，当天第5次产生展示机会，这次展示机向穿山甲发送了4次广告请求，则这4次广告请求的"adload_seq"的值应为5。第二天重新开始计数。

 prime_rit：（针对聚合广告位）广告物理位置对应的固定穿山甲广告位id，可以使用第一层的广告位id也可以为某一层的广告位id，但要求同一物理位置在该字段固定上报同一广告位id，不频繁更换；example：某原生广告位，当天共发出了1000个请求，这1000个请求中使用了5个不同target的穿山甲rit，用某X rit来作为该位置的标记rit，则这1000次请求的prime_rit都需要上报X rit的rit id。
 */
- (instancetype)initWithSlotID:(NSString *)slotID adloadSeq:(NSInteger)adloadSeq primeRit:(NSString * __nullable)primeRit adSize:(CGSize)adSize rootViewController:(UIViewController *)rootViewController;

/**
 Load splash ad datas.
 Start the countdown(@tolerateTimeout) as soon as you request datas.
 */
- (void)loadAdData;

/**
 Remove splash view.
 Stop the countdown as soon as you call this method.
 移除开屏视图
 一旦调用这个方法，倒计时将自动停止
 */
- (void)removeSplashView;

@end

NS_ASSUME_NONNULL_END
