//
//  GADUnifiedNativeAd+CustomClickGesture.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google Inc. All rights reserved.
//

#import <GoogleMobileAds/GADUnifiedNativeAd.h>

@interface GADUnifiedNativeAd (CustomClickGesture)

/// Enables custom click gestures. Must be called before the ad is associated with an ad view.
/// Available for whitelisted accounts only.
- (void)enableCustomClickGestures;

/// Records a click triggered by a custom click gesture.
- (void)recordCustomClickGesture;

@end
