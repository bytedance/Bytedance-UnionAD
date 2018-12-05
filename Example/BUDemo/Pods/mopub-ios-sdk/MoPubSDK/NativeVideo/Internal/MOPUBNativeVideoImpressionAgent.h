//
//  MOPUBNativeVideoImpressionAgent.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MOPUBNativeVideoImpressionAgent : NSObject

- (instancetype)initWithVideoView:(UIView *)videoView requiredVisibilityPercentage:(CGFloat)visiblePercentage requiredPlaybackDuration:(NSTimeInterval)playbackDuration;

- (BOOL)shouldTrackImpressionWithCurrentPlaybackTime:(NSTimeInterval)currentPlaybackTime;

@end
