//
//  MPMRAIDInterstitialCustomEvent.m
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPMRAIDInterstitialCustomEvent.h"
#import "MPAdConfiguration.h"
#import "MPError.h"
#import "MPLogging.h"

@interface MPMRAIDInterstitialCustomEvent ()

@property (nonatomic, strong) MPMRAIDInterstitialViewController *interstitial;

@end

@implementation MPMRAIDInterstitialCustomEvent

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPAdConfiguration * configuration = self.delegate.configuration;
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(self.class) dspCreativeId:configuration.dspCreativeId dspName:nil], self.adUnitId);

    self.interstitial = [[MPMRAIDInterstitialViewController alloc] initWithAdConfiguration:configuration];
    self.interstitial.delegate = self;

    // The MRAID ad view will handle the close button so we don't need the MPInterstitialViewController's close button.
    [self.interstitial setCloseButtonStyle:MPInterstitialCloseButtonStyleAlwaysHidden];
    [self.interstitial startLoading];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)controller
{
    MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], self.adUnitId);
    [self.interstitial presentInterstitialFromViewController:controller complete:^(NSError * error) {
        if (error != nil) {
            MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], self.adUnitId);
        }
        else {
            MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], self.adUnitId);
        }
    }];
}

#pragma mark - MPMRAIDInterstitialViewControllerDelegate

- (CLLocation *)location
{
    return [self.delegate location];
}

- (NSString *)adUnitId
{
    return [self.delegate adUnitId];
}

- (void)interstitialDidLoadAd:(MPInterstitialViewController *)interstitial
{
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], self.adUnitId);
    [self.delegate interstitialCustomEvent:self didLoadAd:self.interstitial];
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialViewController *)interstitial
{
    NSString * message = [NSString stringWithFormat:@"Failed to load creative:\n%@", self.delegate.configuration.adResponseHTMLString];
    NSError * error = [NSError errorWithCode:MOPUBErrorAdapterFailedToLoadAd localizedDescription:message];

    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], self.adUnitId);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)interstitialWillAppear:(MPInterstitialViewController *)interstitial
{
    [self.delegate interstitialCustomEventWillAppear:self];
}

- (void)interstitialDidAppear:(MPInterstitialViewController *)interstitial
{
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void)interstitialWillDisappear:(MPInterstitialViewController *)interstitial
{
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)interstitialDidDisappear:(MPInterstitialViewController *)interstitial
{
    [self.delegate interstitialCustomEventDidDisappear:self];

    // Deallocate the interstitial as we don't need it anymore. If we don't deallocate the interstitial after dismissal,
    // then the html in the webview will continue to run which could lead to bugs such as continuing to play the sound of an inline
    // video since the app may hold onto the interstitial ad controller. Moreover, we keep an array of controllers around as well.
    self.interstitial = nil;
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialViewController *)interstitial
{
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void)interstitialWillLeaveApplication:(MPInterstitialViewController *)interstitial
{
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

@end
