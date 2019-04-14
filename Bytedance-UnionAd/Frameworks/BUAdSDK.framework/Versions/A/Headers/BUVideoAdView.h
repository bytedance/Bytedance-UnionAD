//
//  BUVideoAdView.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUPlayerPublicDefine.h"

@class BUMaterialMeta;

NS_ASSUME_NONNULL_BEGIN

/**
 Control TikTok Audience Network video player.
 */
@protocol BUVideoEngine <NSObject>

/**
 Get the already played time.
 */
- (CGFloat)currentPlayTime;

@end

@protocol BUVideoAdViewDelegate;


@interface BUVideoAdView : UIView<BUPlayerDelegate, BUVideoEngine>

@property (nonatomic, weak, nullable) id<BUVideoAdViewDelegate> delegate;

/// required. Root view controller for handling ad actions.
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 Whether to allow pausing the video by clicking, default NO. Only for draw video(vertical video ads).
 **/
@property (nonatomic, assign) BOOL drawVideoClickEnable;

/**
 material information.
 */
@property (nonatomic, strong, readwrite, nullable) BUMaterialMeta *materialMeta;

- (instancetype)initWithMaterial:(BUMaterialMeta *)materialMeta;

/**
 Resume to the corresponding time.
 */
- (void)playerSeekToTime:(CGFloat)time;

/**
 Support configuration for pause button.
 @param playImg : the image of the button
 @param playSize : the size of the button. Set as cgsizezero to use default icon size.
 */
- (void)playerPlayIncon:(UIImage *)playImg playInconSize:(CGSize)playSize;

@end

@protocol BUVideoAdViewDelegate <NSObject>

@optional

/**
 This method is called when videoadview failed to play.
 @param error : the reason of error
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 This method is called when videoadview playback status changed.
 @param playerState : player state after changed
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState;

/**
 This method is called when videoadview end of play.
 */
- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView;
@end

NS_ASSUME_NONNULL_END
