//
//  BUSplashAdView.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"
#import "BUSplashZoomOutView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUSplashAdDelegate;

@interface BUSplashAdView : UIView
/**
The unique identifier of splash ad.
 */
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;

/**
 Maximum allowable load timeout, default 3s, unit s.
 */
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;


/**
 Whether hide skip button, default NO.
 If you hide the skip button, you need to customize the countdown.
 */
@property (nonatomic, assign) BOOL hideSkipButton;

///optional: Whether need splashZoomOutAd, default NO.
@property (nonatomic, assign) BOOL needSplashZoomOutAd;

/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<BUSplashAdDelegate> delegate;

/*
 required.
 Root view controller for handling ad actions.
 */
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 Whether the splash ad data has been loaded.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

/// When it is a zoom out advertisement, it has value.
@property (nonatomic, strong, readonly) BUSplashZoomOutView *zoomOutView;

/**
 Initializes splash ad with slot id and frame.
 @param slotID : the unique identifier of splash ad
 @param frame : the frame of splashAd view. It is recommended for the mobile phone screen.
 @return BUSplashAdView
 */
- (instancetype)initWithSlotID:(NSString *)slotID frame:(CGRect)frame;

/**
adload_seq：（针对聚合广告位）传递本次请求是为“自然日内某设备某广告位置第N次展示机会”发出的广告请求，同物理位置在自然日从1开始计数，不同物理位置独立计数；example：某原生广告位置，当天第5次产生展示机会，这次展示机向穿山甲发送了4次广告请求，则这4次广告请求的"adload_seq"的值应为5。第二天重新开始计数。

prime_rit：（针对聚合广告位）广告物理位置对应的固定穿山甲广告位id，可以使用第一层的广告位id也可以为某一层的广告位id，但要求同一物理位置在该字段固定上报同一广告位id，不频繁更换；example：某原生广告位，当天共发出了1000个请求，这1000个请求中使用了5个不同target的穿山甲rit，用某X rit来作为该位置的标记rit，则这1000次请求的prime_rit都需要上报X rit的rit id。
*/

- (instancetype)initWithSlotID:(NSString *)slotID adloadSeq:(NSInteger)adloadSeq primeRit:(NSString * __nullable)primeRit frame:(CGRect)frame;
/**
 Load splash ad datas.
 Start the countdown(@tolerateTimeout) as soon as you request datas.
 */
- (void)loadAdData;

@end


@protocol BUSplashAdDelegate <NSObject>

@optional
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError * _Nullable)error;

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(BUSplashAdView *)splashAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType;

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd;

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd;

@end

NS_ASSUME_NONNULL_END

