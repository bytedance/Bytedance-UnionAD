//
//  WMNativeAd.h
//  WMAdSDK
//
//  Created by chenren on 18/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WMAdSlot.h"
#import "WMMaterialMeta.h"

@protocol WMNativeAdDelegate;

NS_ASSUME_NONNULL_BEGIN


/**
 抽象的广告位，包含广告数据加载， 展示，响应
 */
@interface WMNativeAd : NSObject

/**
 广告位的描述说明， 目前Native广告支持信息流 插屏 Banner广告位 开屏广告位
 */
@property (nonatomic, strong, readwrite, nullable) WMAdSlot *adslot;

/**
 广告位的素材资源
 */
@property (nonatomic, strong, readonly, nullable) WMMaterialMeta *data;

/**
 广告位加载展示响应的代理回调，可以设置为遵循<WMNativeAdDelegate>的任何类型，不限于Viewcontroller
 */
@property (nonatomic, weak, readwrite, nullable) id<WMNativeAdDelegate> delegate;

/**
 广告位展示落地页ViewController的rootviewController，必传参数
 */
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 创建一个Native广告的推荐构造函数
 @param slot 广告位描述信息
 @return Native广告位
 */
- (instancetype)initWithSlot:(WMAdSlot *)slot;

// 广告类与view相关联绑定，注册具体事件，比如跳转页面、打电话、下载，行为由SDK控制，不建议使用，比如有可能注册电话事件但实际没有电话信息
- (void)registerViewForInteraction:(UIView *)view
               withInteractionType:(WMInteractionType)interactionType;

/**
 定义原生广告视图中可以点击的 视图区域，行为由SDK控制
 @param view 原生广告的视图，完整可点击区域
 */
- (void)registerViewForInteraction:(UIView *)view;

/**
 定义原生广告视图中可以点击的 视图区域， 减少误点概率，提升用户体验
 @param view 包含原生广告的视图
 @param clickableViews 广告视图中可以被点击的响应对象
 */
- (void)registerViewForInteraction:(UIView *)view
                withClickableViews:(NSArray<UIView *> *_Nullable)clickableViews;

/// 广告类解除和view的绑定
- (void)unregisterView;

/**
 主动 请求广告数据
 */
- (void)loadAdData;

@end


@protocol WMNativeAdDelegate <NSObject>

@optional

/**
 nativeAd 网络加载成功
 @param nativeAd 加载成功
 */
- (void)nativeAdDidLoad:(WMNativeAd *)nativeAd;

/**
 nativeAd 出现错误
 @param nativeAd 错误的广告
 @param error 错误原因
 */
- (void)nativeAd:(WMNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error;

/**
 nativeAd 即将进入可视区域
 @param nativeAd 广告位即将出现在可视区域
 */
- (void)nativeAdDidBecomeVisible:(WMNativeAd *)nativeAd;

/**
 nativeAd 被点击

 @param nativeAd 被点击的 广告位
 @param view 被点击的视图
 */
- (void)nativeAdDidClick:(WMNativeAd *)nativeAd withView:(UIView *_Nullable)view;

@end

NS_ASSUME_NONNULL_END
