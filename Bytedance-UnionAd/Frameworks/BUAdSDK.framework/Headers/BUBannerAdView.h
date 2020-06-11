//
//  BUBannerAdView.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUNativeAd.h"

@class BUDislikeWords, BUAdSlot;
@protocol BUBannerAdViewDelegate;


NS_ASSUME_NONNULL_BEGIN

@interface BUBannerAdView : UIView

@property (nonatomic, weak, nullable) id<BUBannerAdViewDelegate> delegate;

/**
 The carousel interval, in seconds, is set in the range of 30~120s, and is passed during initialization. If it does not meet the requirements, it will not be in carousel ad.
 */
@property (nonatomic, assign, readonly) NSInteger interval;

/**
 The dislikeButton has been added to the upper right corner of the BannerView by default, it will respond to dislike reasons.
 */
@property (nonatomic, strong, readonly, nonnull) UIButton *dislikeButton;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

- (instancetype)initWithIdentifier:(NSString *)slotID
                rootViewController:(UIViewController *)rootViewController
                            adSize:(CGSize)adSize
                  withShowPosition:(BUAdSlotPosition)showPosition
             WithIsSupportDeepLink:(BOOL)isSupportDeepLink;

- (instancetype)initWithIdentifier:(NSString *)slotID
                rootViewController:(UIViewController *)rootViewController
                            adSize:(CGSize)adSize
                  withShowPosition:(BUAdSlotPosition)showPosition
             WithIsSupportDeepLink:(BOOL)isSupportDeepLink
                          interval:(NSInteger)interval;

- (instancetype)initWithSlotID:(NSString *)slotID
                          size:(BUSize *)adSize
            rootViewController:(UIViewController *)rootViewController;

- (instancetype)initWithSlotID:(NSString *)slotID
                          size:(BUSize *)adSize
            rootViewController:(UIViewController *)rootViewController
                      interval:(NSInteger)interval;

/**
adload_seq：（针对聚合广告位）传递本次请求是为“自然日内某设备某广告位置第N次展示机会”发出的广告请求，同物理位置在自然日从1开始计数，不同物理位置独立计数；example：某原生广告位置，当天第5次产生展示机会，这次展示机向穿山甲发送了4次广告请求，则这4次广告请求的"adload_seq"的值应为5。第二天重新开始计数。

prime_rit：（针对聚合广告位）广告物理位置对应的固定穿山甲广告位id，可以使用第一层的广告位id也可以为某一层的广告位id，但要求同一物理位置在该字段固定上报同一广告位id，不频繁更换；example：某原生广告位，当天共发出了1000个请求，这1000个请求中使用了5个不同target的穿山甲rit，用某X rit来作为该位置的标记rit，则这1000次请求的prime_rit都需要上报X rit的rit id。
*/

- (instancetype)initWithSlotID:(NSString *)slotID
                       adloadSeq:(NSInteger)adloadSeq
                      primeRit:(NSString *)primeRit
            rootViewController:(UIViewController *)rootViewController
                        adSize:(CGSize)adSize
              withShowPosition:(BUAdSlotPosition)showPosition
         WithIsSupportDeepLink:(BOOL)isSupportDeepLink;

- (void)loadAdData;

- (IBAction)dislikeAction:(id)sender;
@end

@protocol BUBannerAdViewDelegate <NSObject>

@optional

/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 @param nativeAd : nativeAd for bannerAdView
 */
- (void)bannerAdViewDidLoad:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;

/**
 This method is called when bannerAdView ad slot failed to load.
 @param error : the reason of error
 */
- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;

/**
 This method is called when bannerAdView is clicked.
 */
- (void)bannerAdViewDidClick:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;

/**
 This method is called when the user clicked dislike button and chose dislike reasons.
 @param filterwords : the array of reasons for dislike.
 */
- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)bannerAdViewDidCloseOtherController:(BUBannerAdView *)bannerAdView interactionType:(BUInteractionType)interactionType;

@end

NS_ASSUME_NONNULL_END

