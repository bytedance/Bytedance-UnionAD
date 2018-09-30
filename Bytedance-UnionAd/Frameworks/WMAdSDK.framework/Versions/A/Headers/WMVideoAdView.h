//
//  WMVideoAdView.h
//  WMAdSDK
//
//  Created by gdp on 2017/12/21.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMPlayerPublicDefine.h"

@class WMMaterialMeta;

NS_ASSUME_NONNULL_BEGIN

/**
 控制网盟视频播放器
 */
@protocol WMVideoEngine <NSObject>

/**
 开始播放
 */
- (void)play;

/**
 暂停播放
 */
- (void)pause;

/**
 获取当前已播放时间
 */
- (CGFloat)currentPlayTime;

/**
 设置是否静音
 */
- (void)setMute:(BOOL)isMute;

@end

@protocol WMVideoAdViewDelegate;


@interface WMVideoAdView : UIView<WMPlayerDelegate, WMVideoEngine>

@property (nonatomic, weak, nullable) id<WMVideoAdViewDelegate> delegate;

/// 广告位展示落地页ViewController的rootviewController，必传参数
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 materialMeta 物料信息
 */
@property (nonatomic, strong, readwrite, nullable) WMMaterialMeta *materialMeta;

/**
 是否是cellVideo
 */
@property (nonatomic, assign) BOOL isCellVideo;

- (instancetype)initWithMaterial:(WMMaterialMeta *)materialMeta;

/**
 续播到对应的time
 
 @param time 续播时间
 */
- (void)playerSeekToTime:(CGFloat)time;

@end

@protocol WMVideoAdViewDelegate <NSObject>

@optional
/**
 videoAdView 播放失败

 @param videoAdView 当前展示的 videoAdView 视图
 @param error 错误原因
 */
- (void)videoAdView:(WMVideoAdView *)videoAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 videoAdView 播放状态改变

 @param videoAdView 当前展示的 videoAdView 视图
 @param playerState 当前播放完成
 */
- (void)videoAdView:(WMVideoAdView *)videoAdView stateDidChanged:(WMPlayerPlayState)playerState;

/**
 videoAdView 播放结束

 @param videoAdView 当前展示的 videoAdView 视图
 */
- (void)playerDidPlayFinish:(WMVideoAdView *)videoAdView;
@end

NS_ASSUME_NONNULL_END
