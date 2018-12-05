//
//  MPBannerAdManagerDelegate.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

@class MPAdView;
@protocol MPAdViewDelegate;

@protocol MPBannerAdManagerDelegate <NSObject>

- (NSString *)adUnitId;
- (MPNativeAdOrientation)allowedNativeAdsOrientation;
- (MPAdView *)banner;
- (id<MPAdViewDelegate>)bannerDelegate;
- (CGSize)containerSize;
- (UIViewController *)viewControllerForPresentingModalView;

- (void)invalidateContentView;

- (void)managerDidLoadAd:(UIView *)ad;
- (void)managerDidFailToLoadAd;
- (void)userActionWillBegin;
- (void)userActionDidFinish;
- (void)userWillLeaveApplication;

@end
