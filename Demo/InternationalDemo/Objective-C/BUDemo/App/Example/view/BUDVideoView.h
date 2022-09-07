//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// status of player
typedef NS_ENUM (NSUInteger, BUDVideoViewStatus) {
    BUDVideoViewStatusDefaut,
    BUDVideoViewStatusReady,
    BUDVideoViewStatusPlaying,
    BUDVideoViewStatusStopped,
    BUDVideoViewStatusPaused,
    BUDVideoViewStatusResumed,
    BUDVideoViewStatusAbort,
    BUDVideoViewStatusError,
};

/// JUST demo video view, used for show how to use custom feed video.
@interface BUDVideoView : UIView

/// Is playing or not, can not be observed
@property (nonatomic, assign, readonly) BOOL isPlaying;

/// Status of video player, observable
@property (nonatomic, assign, readonly) BUDVideoViewStatus status;

/// error of video player
@property (nonatomic, strong, readonly) NSError *error;

/// load url from local or remote
/// @param URL url of video file
- (void)loadURL:(NSURL *)URL;

/// play video, loadURL before, will seek to 0s if is playing/paused/stoped
- (void)play;

/// resume video only is paused
- (void)resume;

/// pause video
- (void)pause;

/// abort, equal to stop, but it means be stoped by user, stop means playing to the end
- (void)abort;

@end

@interface BUDVideoView (Item)

/// the total length of current video, unit seconds
- (NSTimeInterval)durationOfCurrentItem;

/// has watch length of current video, unit seconds
- (NSTimeInterval)watchedDurationOfCurrentItem;

@end

NS_ASSUME_NONNULL_END
