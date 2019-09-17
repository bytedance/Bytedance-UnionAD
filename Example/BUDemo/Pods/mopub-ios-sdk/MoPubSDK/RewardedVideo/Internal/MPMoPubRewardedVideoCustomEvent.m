//
//  MPMoPubRewardedVideoCustomEvent.m
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPMoPubRewardedVideoCustomEvent.h"
#import "MPMRAIDInterstitialViewController.h"
#import "MPError.h"
#import "MPLogging.h"
#import "MPRewardedVideoReward.h"
#import "MPAdConfiguration.h"
#import "MPRewardedVideoAdapter.h"
#import "MPRewardedVideoReward.h"
#import "MPRewardedVideoError.h"

@interface MPMoPubRewardedVideoCustomEvent() <MPInterstitialViewControllerDelegate>

@property (nonatomic) MPMRAIDInterstitialViewController *interstitial;
@property (nonatomic) BOOL adAvailable;

@end

@implementation MPMoPubRewardedVideoCustomEvent

@dynamic delegate;

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info
{
    MPAdConfiguration * configuration = self.delegate.configuration;
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(configuration.customEventClass) dspCreativeId:configuration.dspCreativeId dspName:nil], self.adUnitId);

    self.interstitial = [[MPMRAIDInterstitialViewController alloc] initWithAdConfiguration:configuration];
    self.interstitial.delegate = self;

    [self.interstitial setCloseButtonStyle:MPInterstitialCloseButtonStyleAlwaysHidden];
    [self.interstitial startLoading];
}

- (BOOL)hasAdAvailable
{
    return self.adAvailable;
}

- (void)handleAdPlayedForCustomEventNetwork
{
    // no-op
}

- (void)handleCustomEventInvalidated
{
    // no-op
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController
{
    MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], self.adUnitId);

    // Error handling block.
    __typeof__(self) __weak weakSelf = self;
    void (^onShowError)(NSError *) = ^(NSError * error) {
        __typeof__(self) strongSelf = weakSelf;
        if (strongSelf != nil) {
            MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(strongSelf.class) error:error], strongSelf.adUnitId);

            [strongSelf.delegate rewardedVideoDidFailToPlayForCustomEvent:strongSelf error:error];
        }
    };

    // No ad available to show.
    if (!self.hasAdAvailable) {
        NSError * error = [NSError errorWithDomain:MoPubRewardedVideoAdsSDKDomain code:MPRewardedVideoAdErrorNoAdsAvailable userInfo:nil];
        onShowError(error);
        return;
    }

    [self.interstitial presentInterstitialFromViewController:viewController complete:^(NSError * error) {
        if (error != nil) {
            onShowError(error);
        }
        else {
            MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], self.adUnitId);
        }
    }];
}

#pragma mark - MPMRAIDInterstitialViewControllerDelegate

- (void)interstitialDidLoadAd:(MPInterstitialViewController *)interstitial
{
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], self.adUnitId);

    self.adAvailable = YES;
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
}

- (void)interstitialDidAppear:(MPInterstitialViewController *)interstitial
{
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
}

- (void)interstitialWillAppear:(MPInterstitialViewController *)interstitial
{
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialViewController *)interstitial
{
    NSString * message = [NSString stringWithFormat:@"Failed to load creative:\n%@", self.delegate.configuration.adResponseHTMLString];
    NSError * error = [NSError errorWithCode:MOPUBErrorAdapterFailedToLoadAd localizedDescription:message];
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], self.adUnitId);

    self.adAvailable = NO;
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:nil];
}

- (void)interstitialWillDisappear:(MPInterstitialViewController *)interstitial
{
    [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
}

- (void)interstitialDidDisappear:(MPInterstitialViewController *)interstitial
{
    self.adAvailable = NO;
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];

    // Get rid of the interstitial view controller when done with it so we don't hold on longer than needed
    self.interstitial = nil;
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialViewController *)interstitial
{
    [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
}

- (void)interstitialWillLeaveApplication:(MPInterstitialViewController *)interstitial
{
    [self.delegate rewardedVideoWillLeaveApplicationForCustomEvent:self];
}

- (void)interstitialRewardedVideoEnded
{
    MPLogInfo(@"MoPub rewarded video finished playing.");
    [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:[self configuration].selectedReward];
}

#pragma mark - MPPrivateRewardedVideoCustomEventDelegate
- (NSString *)adUnitId
{
    return [self.delegate adUnitId];
}

- (MPAdConfiguration *)configuration
{
    return [self.delegate configuration];
}

@end
