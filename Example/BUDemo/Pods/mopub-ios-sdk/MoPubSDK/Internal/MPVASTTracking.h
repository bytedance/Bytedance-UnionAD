//
//  MPVASTTracking.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

@class MPVideoConfig;

typedef NS_ENUM(NSUInteger, MPVideoEventType) {
    MPVideoEventTypeTimeUpdate = 0,
    MPVideoEventTypeMuted,
    MPVideoEventTypeUnmuted,
    MPVideoEventTypePause,
    MPVideoEventTypeResume,
    MPVideoEventTypeFullScreen,
    MPVideoEventTypeExitFullScreen,
    MPVideoEventTypeExpand,
    MPVideoEventTypeCollapse,
    MPVideoEventTypeCompleted,
    MPVideoEventTypeImpression,
    MPVideoEventTypeClick,
    MPVideoEventTypeError
};

@interface MPVASTTracking : NSObject

@property (nonatomic, readonly) MPVideoConfig *videoConfig;
@property (nonatomic) NSTimeInterval videoDuration;

- (instancetype)initWithMPVideoConfig:(MPVideoConfig *)videoConfig videoView:(UIView *)videoView;
- (void)handleVideoEvent:(MPVideoEventType)videoEventType videoTimeOffset:(NSTimeInterval)timeOffset;
- (void)handleNewVideoView:(UIView *)videoView;

@end
