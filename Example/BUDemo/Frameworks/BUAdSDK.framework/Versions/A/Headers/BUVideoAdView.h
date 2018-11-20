//
//  BUVideoAdView.h
//  BUAdSDK
//
//  Created by gdp on 2017/12/21.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUPlayerPublicDefine.h"

@class BUMaterialMeta;

NS_ASSUME_NONNULL_BEGIN

/**
 控制网盟视频播放器
 */
@protocol BUVideoEngine <NSObject>

/**
 获取当前已播放时间
 */
- (CGFloat)currentPlayTime;

/**
 设置是否静音
 */
- (void)setMute:(BOOL)isMute;

@end

@protocol BUVideoAdViewDelegate;


@interface BUVideoAdView : UIView<BUPlayerDelegate, BUVideoEngine>

@property (nonatomic, weak, nullable) id<BUVideoAdViewDelegate> delegate;

/// 广告位展示落地页ViewController的rootviewController，必传参数
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 Draw视频支持点击暂停，默认NO，该字段仅对Draw竖版原生视频有效
 **/
@property (nonatomic, assign) BOOL drawVideoClickEnable;

/**
 materialMeta 物料信息
 */
@property (nonatomic, strong, readwrite, nullable) BUMaterialMeta *materialMeta;

- (instancetype)initWithMaterial:(BUMaterialMeta *)materialMeta;

/**
 续播到对应的time
 
 @param time 续播时间
 */
- (void)playerSeekToTime:(CGFloat)time;
/**
 播放暂停按钮支持配置
 
 @param playImg 播放按钮
 @param playSize 播放按钮大小 设置CGSizeZero则为默认图标大小
 */
- (void)playerPlayIncon:(UIImage *)playImg playInconSize:(CGSize)playSize;
/**
 播放，暂停功能
 */
- (void)tapPlay;
- (void)tapPause;
@end

@protocol BUVideoAdViewDelegate <NSObject>

@optional
/**
 videoAdView 播放失败

 @param videoAdView 当前展示的 videoAdView 视图
 @param error 错误原因
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 videoAdView 播放状态改变

 @param videoAdView 当前展示的 videoAdView 视图
 @param playerState 当前播放完成
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState;

/**
 videoAdView 播放结束

 @param videoAdView 当前展示的 videoAdView 视图
 */
- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView;
@end

NS_ASSUME_NONNULL_END
