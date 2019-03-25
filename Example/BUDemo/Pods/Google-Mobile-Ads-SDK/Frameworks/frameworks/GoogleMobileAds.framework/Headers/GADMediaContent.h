//
//  GADMediaContent.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Provides media content information. Interact with instances of this class on the main queue
/// only.
@interface GADMediaContent : NSObject

/// Media content aspect ratio (width/height). The value is 0 when there's no media content or the
/// media content aspect ratio is unknown.
@property(nonatomic, readonly) CGFloat aspectRatio;

/// The main image to be displayed when the media content doesn't contain video.
@property(nonatomic, nullable) UIImage *mainImage;

@end

NS_ASSUME_NONNULL_END
