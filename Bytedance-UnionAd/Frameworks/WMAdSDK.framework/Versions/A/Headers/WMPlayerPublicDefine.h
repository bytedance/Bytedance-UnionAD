//
//  WMPlayerPublicDefine.h
//  WMAdSDK
//
//  Created by bytedance_yuanhuan on 2018/8/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef WMPlayerPublicDefine_h
#define WMPlayerPublicDefine_h

/**
 * 播放器种状态
 */
typedef NS_ENUM(NSInteger, WMPlayerPlayState) {
    WMPlayerStateFailed    = 0,  // 播放失败
    WMPlayerStateBuffering = 1,  // 缓冲中
    WMPlayerStatePlaying   = 2,  // 播放中
    WMPlayerStateStopped   = 3,  // 停止播放
    WMPlayerStatePause     = 4,   // 暂停播放
    WMPlayerStateDefalt    = 5    // 初始化状态
};

@class WMPlayer;

@protocol WMPlayerDelegate <NSObject>

@optional
/**
 * 播放器状态改变
 */
- (void)player:(WMPlayer *)player stateDidChanged:(WMPlayerPlayState)playerState;
/**
 * 播放器准备完成
 */
- (void)playerReadyToPlay:(WMPlayer *)player;
/**
 * 播放完成或者发生错误
 */
- (void)playerDidPlayFinish:(WMPlayer *)player error:(NSError *)error;

/**
 * 播放器上识别的点击事件
 */
- (void)player:(WMPlayer *)player recognizeTapGesture:(UITapGestureRecognizer *)gesture;


/**
 * 播放器播放过程中视图被点击
 */
- (void)playerTouchesBegan:(WMPlayer *)player;

@end

#endif /* WMPlayerPublicDefine_h */
