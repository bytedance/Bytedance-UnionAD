//
//  MPInterstitialViewController.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <UIKit/UIKit.h>
#import "MPExtendedHitBoxButton.h"
#import "MPGlobal.h"

@class CLLocation;

@protocol MPInterstitialViewControllerDelegate;

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPInterstitialViewController : UIViewController

@property (nonatomic, assign) MPInterstitialCloseButtonStyle closeButtonStyle;
@property (nonatomic, assign) MPInterstitialOrientationType orientationType;
@property (nonatomic, strong) MPExtendedHitBoxButton *closeButton;
@property (nonatomic, weak) id<MPInterstitialViewControllerDelegate> delegate;

- (void)presentInterstitialFromViewController:(UIViewController *)controller complete:(void(^)(NSError *))complete;
- (void)dismissInterstitialAnimated:(BOOL)animated;
- (BOOL)shouldDisplayCloseButton;
- (void)willPresentInterstitial;
- (void)didPresentInterstitial;
- (void)willDismissInterstitial;
- (void)didDismissInterstitial;
- (void)layoutCloseButton;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol MPInterstitialViewControllerDelegate <NSObject>

- (NSString *)adUnitId;
- (void)interstitialDidLoadAd:(MPInterstitialViewController *)interstitial;
- (void)interstitialDidFailToLoadAd:(MPInterstitialViewController *)interstitial;
- (void)interstitialWillAppear:(MPInterstitialViewController *)interstitial;
- (void)interstitialDidAppear:(MPInterstitialViewController *)interstitial;
- (void)interstitialWillDisappear:(MPInterstitialViewController *)interstitial;
- (void)interstitialDidDisappear:(MPInterstitialViewController *)interstitial;
- (void)interstitialDidReceiveTapEvent:(MPInterstitialViewController *)interstitial;
- (void)interstitialWillLeaveApplication:(MPInterstitialViewController *)interstitial;

@optional
- (CLLocation *)location;
- (void)interstitialRewardedVideoEnded;

@end
