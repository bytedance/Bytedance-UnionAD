//
//  BUPlayerPublicDefine.h
//  BUAdSDK
//
//  Created by bytedance_yuanhuan on 2018/8/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef BUPlayerPublicDefine_h
#define BUPlayerPublicDefine_h

/**
 * 播放器种状态
 */
typedef NS_ENUM(NSInteger, BUPlayerPlayState) {
    BUPlayerStateFailed    = 0,  // 播放失败
    BUPlayerStateBuffering = 1,  // 缓冲中
    BUPlayerStatePlaying   = 2,  // 播放中
    BUPlayerStateStopped   = 3,  // 停止播放
    BUPlayerStatePause     = 4,   // 暂停播放
    BUPlayerStateDefalt    = 5    // 初始化状态
};

@class BUPlayer;

@protocol BUPlayerDelegate <NSObject>

@optional
/**
 * 播放器状态改变
 */
- (void)player:(BUPlayer *)player stateDidChanged:(BUPlayerPlayState)playerState;
/**
 * 播放器准备完成
 */
- (void)playerReadyToPlay:(BUPlayer *)player;
/**
 * 播放完成或者发生错误
 */
- (void)playerDidPlayFinish:(BUPlayer *)player error:(NSError *)error;

/**
 * 播放器上识别的点击事件
 */
- (void)player:(BUPlayer *)player recognizeTapGesture:(UITapGestureRecognizer *)gesture;


/**
 * 播放器播放过程中视图被点击
 */
- (void)playerTouchesBegan:(BUPlayer *)player;

@end

#endif /* BUPlayerPublicDefine_h */
