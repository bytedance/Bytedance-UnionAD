//
//  BUBannerAdView.h
//  BUAdSDK
//
//  Created by 曹清然 on 2017/5/25.
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
 轮播间隔，单位秒，设置时间在 30~120s 范围内，初始化时传入。若不符合，则不轮播。
 */
@property (nonatomic, assign, readonly) NSInteger interval;

/**
 dislikeButton 默认已添加到 BannerView 的右上角， 响应 dislike原因
 */
@property (nonatomic, strong, readonly, nonnull) UIButton *dislikeButton;

- (instancetype)initWithIdentifier:(NSString *)slotID
                rootViewController:(nullable UIViewController *)rootViewController
                            adSize:(CGSize)adSize
                  withShowPosition:(BUAdSlotPosition)showPosition
             WithIsSupportDeepLink:(BOOL)isSupportDeepLink;

- (instancetype)initWithIdentifier:(NSString *)slotID
                rootViewController:(nullable UIViewController *)rootViewController
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

- (void)loadAdData;

- (IBAction)dislikeAction:(id)sender;
@end

@protocol BUBannerAdViewDelegate <NSObject>

@optional

/**
 bannerAdView 广告位加载成功

 @param bannerAdView 视图
 @param nativeAd 内部使用的NativeAd
 */
- (void)bannerAdViewDidLoad:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;

/**
 bannerAdView 广告位展示新的广告

 @param bannerAdView 当前展示的Banner视图
 @param nativeAd 内部使用的NativeAd
 */
- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;

/**
 bannerAdView 广告位点击

 @param bannerAdView 当前展示的Banner视图
 @param nativeAd 内部使用的NativeAd
 */
- (void)bannerAdViewDidClick:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;

/**
 bannerAdView 广告位发生错误

 @param bannerAdView 当前展示的Banner视图
 @param error 错误原因
 */
- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 bannerAdView 广告位点击不喜欢

 @param bannerAdView 当前展示的Banner视图
 @param filterwords 选择不喜欢理由
 */
- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords;

@end

NS_ASSUME_NONNULL_END
