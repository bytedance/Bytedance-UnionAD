//
//  WMRewardedVideoAd.h
//  WMAdSDK
//
//  Created by gdp on 2018/1/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WMRewardedVideoAdDelegate;
@class WMRewardedVideoModel;

@interface WMRewardedVideoAd : NSObject
@property (nonatomic, strong) WMRewardedVideoModel *rewardedVideoModel;
@property (nonatomic, weak, nullable) id<WMRewardedVideoAdDelegate> delegate;

/**
 物料有效 数据不为空且没有展示过为 YES, 重复展示不计费.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(WMRewardedVideoModel *)model;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end

@protocol WMRewardedVideoAdDelegate <NSObject>

@optional

/**
 rewardedVideoAd 激励视频广告物料加载成功
 
 @param rewardedVideoAd 当前激励视频素材
 */
- (void)rewardedVideoAdDidLoad:(WMRewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告视频加载成功
 
 @param rewardedVideoAd 当前激励视频素材
 */
- (void)rewardedVideoAdVideoDidLoad:(WMRewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 广告位即将展示
 
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdWillVisible:(WMRewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告关闭
 
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdDidClose:(WMRewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告点击下载
 
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdDidClickDownload:(WMRewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告素材加载失败
 
 @param rewardedVideoAd 当前激励视频对象
 @param error 错误对象
 */
- (void)rewardedVideoAd:(WMRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
 rewardedVideoAd 激励视频广告播放完成或发生错误
 
 @param rewardedVideoAd 当前激励视频对象
 @param error 错误对象
 */
- (void)rewardedVideoAdDidPlayFinish:(WMRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
 服务器校验后的结果,异步 rewardedVideoAd publisher 终端返回 20000
 
 @param rewardedVideoAd 当前激励视频对象
 @param verify 有效性验证结果
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(WMRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;

/**
 rewardedVideoAd publisher 终端返回非 20000
 
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdServerRewardDidFail:(WMRewardedVideoAd *)rewardedVideoAd;

@end

NS_ASSUME_NONNULL_END
