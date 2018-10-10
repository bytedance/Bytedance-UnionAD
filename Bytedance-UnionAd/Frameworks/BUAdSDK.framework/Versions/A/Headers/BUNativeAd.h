//
//  BUNativeAd.h
//  BUAdSDK
//
//  Created by chenren on 18/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUAdSlot.h"
#import "BUMaterialMeta.h"
#import "BUVideoAdView.h"

@protocol BUNativeAdDelegate;

NS_ASSUME_NONNULL_BEGIN


/**
 抽象的广告位，包含广告数据加载、响应回调
 目前Native支持原生广告，原生广告包括信息流（多条广告，图文+视频形式）、一般原生广告（单条广告，图文+视频形式），原生banner、原生插屏
 同时支持插屏、Banner、开屏、激励视频、全屏视频
 */
@interface BUNativeAd : NSObject

/**
 广告位的描述说明
 */
@property (nonatomic, strong, readwrite, nullable) BUAdSlot *adslot;

/**
 广告位的素材资源
 */
@property (nonatomic, strong, readonly, nullable) BUMaterialMeta *data;

/**
 广告位加载展示响应的代理回调，可以设置为遵循<BUNativeAdDelegate>的任何类型，不限于Viewcontroller
 */
@property (nonatomic, weak, readwrite, nullable) id<BUNativeAdDelegate> delegate;

/**
 广告位展示落地页通过rootviewController进行跳转，必传参数，跳转方式分为pushViewController和presentViewController两种方式
 */
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 创建一个Native广告的推荐构造函数
 @param slot 广告位描述信息
 @return Native广告位
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot;

/**
 定义原生广告视图中，注册可点击视图
 @param containerView 注册原生广告的容器视图，必传参数，交互类型在平台配置，包括查看视频详情、打电话、落地页、下载、外部浏览器打开等
 @param clickableViews 注册创意按钮，可选参数，交互类型在平台配置，包括电话、落地页、下载、外部浏览器打开、短信、email、视频详情页等
 @note 同一nativeAd对象请勿重复注册同一视图
 */
- (void)registerContainer:(__kindof UIView *)containerView
       withClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;

/// 广告类解除和view的绑定
- (void)unregisterView;

/**
 主动 请求广告数据
 */
- (void)loadAdData;

@end


@protocol BUNativeAdDelegate <NSObject>

@optional

/**
 nativeAd 网络加载成功
 @param nativeAd 加载成功
 */
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd;

/**
 nativeAd 出现错误
 @param nativeAd 错误的广告
 @param error 错误原因
 */
- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error;

/**
 nativeAd 广告已展示
 @param nativeAd 出现在可视区域的广告位
 */
- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd;

/**
 nativeAd 被点击

 @param nativeAd 被点击的 广告位
 @param view 被点击的视图
 */
- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view;

/**
 用户点击 dislike功能
 @param nativeAd 被点击的 广告位
 @param filterWords 不喜欢的原因， 可能为空
 */
- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords;
@end

NS_ASSUME_NONNULL_END
