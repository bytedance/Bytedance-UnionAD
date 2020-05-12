//
//  UIImage+BUIcon.h
//  BUAdSDK
//
//  Created by carl on 2017/8/10.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kBU_endCardClose;
extern NSString *const kBU_fullClose;
extern NSString *const kBU_close;
extern NSString *const kBU_dislike;
extern NSString *const kBU_leftback;
extern NSString *const kBU_nextCell;
extern NSString *const kBU_play;
extern NSString *const kBU_pause;
extern NSString *const kBU_sliderDot;
extern NSString *const kBU_fullScreen;
extern NSString *const kBU_bottomPlay;
extern NSString *const kBU_bottomPause;
extern NSString *const kBU_bottomShadow;
extern NSString *const kBU_topShadow;
extern NSString *const kBU_shrinkScreen;
extern NSString *const kBU_fastForward;
extern NSString *const kBU_fastBackward;
extern NSString *const kBU_replay;
extern NSString *const kBU_voice;
extern NSString *const kBU_voice_silent;
extern NSString *const kBU_logo;
extern NSString *const kBU_logoAd;
extern NSString *const kBU_logoAd_oversea;
extern NSString *const kBU_GDPRBack;
extern NSString *const kBU_playableLoading;

@interface UIImage (BU_Icon)
// 异步获取image 不阻塞主线程
+ (void)bu_compatImageNamed:(NSString *)imageName block:(void(^)(UIImage *image))block;
// 同步方式
+ (UIImage *)bu_compatImageNamed:(NSString *)imageName;

@end
