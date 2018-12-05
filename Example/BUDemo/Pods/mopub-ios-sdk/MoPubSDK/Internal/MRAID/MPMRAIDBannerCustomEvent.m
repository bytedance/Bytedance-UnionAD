//
//  MPMRAIDBannerCustomEvent.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPMRAIDBannerCustomEvent.h"
#import "MPLogging.h"
#import "MPAdConfiguration.h"
#import "MRController.h"
#import "MPWebView.h"
#import "MPViewabilityTracker.h"

@interface MPMRAIDBannerCustomEvent () <MRControllerDelegate>

@property (nonatomic, strong) MRController *mraidController;

@end

@implementation MPMRAIDBannerCustomEvent

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Loading MoPub MRAID banner");
    MPAdConfiguration *configuration = [self.delegate configuration];

    CGRect adViewFrame = CGRectZero;
    if ([configuration hasPreferredSize]) {
        adViewFrame = CGRectMake(0, 0, configuration.preferredSize.width,
                                 configuration.preferredSize.height);
    }

    self.mraidController = [[MRController alloc] initWithAdViewFrame:adViewFrame
                                                     adPlacementType:MRAdViewPlacementTypeInline
                                                            delegate:self];
    [self.mraidController loadAdWithConfiguration:configuration];
}

#pragma mark - MRControllerDelegate

- (CLLocation *)location
{
    return [self.delegate location];
}

- (NSString *)adUnitId
{
    return [self.delegate adUnitId];
}

- (MPAdConfiguration *)adConfiguration
{
    return [self.delegate configuration];
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return [self.delegate viewControllerForPresentingModalView];
}

- (void)adDidLoad:(UIView *)adView
{
    MPLogInfo(@"MoPub MRAID banner did load");
    [self.delegate bannerCustomEvent:self didLoadAd:adView];
}

- (void)adDidFailToLoad:(UIView *)adView
{
    MPLogInfo(@"MoPub MRAID banner did fail");
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)closeButtonPressed
{
    //don't care
}

- (void)appShouldSuspendForAd:(UIView *)adView
{
    MPLogInfo(@"MoPub MRAID banner will begin action");
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)appShouldResumeFromAd:(UIView *)adView
{
    MPLogInfo(@"MoPub MRAID banner did end action");
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)trackImpressionsIncludedInMarkup
{
    [self.mraidController.mraidWebView stringByEvaluatingJavaScriptFromString:@"webviewDidAppear();"];
}

- (void)startViewabilityTracker
{
    [self.mraidController.viewabilityTracker startTracking];
}

@end
