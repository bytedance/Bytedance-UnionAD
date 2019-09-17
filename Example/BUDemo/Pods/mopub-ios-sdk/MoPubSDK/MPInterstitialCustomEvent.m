//
//  MPInterstitialCustomEvent.m
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPInterstitialCustomEvent.h"

@implementation MPInterstitialCustomEvent

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    // The default implementation of this method does nothing. Subclasses must override this method
    // and implement code to load an interstitial here.
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup
{
    // By default, the original requestInterstitialWithCustomEventInfo: method will be called.
    // Otherwise subclasses must override this method and implement code to load an interstitial here.
    [self requestInterstitialWithCustomEventInfo:info];
}

- (BOOL)enableAutomaticImpressionAndClickTracking
{
    // Subclasses may override this method to return NO to perform impression and click tracking
    // manually.
    return YES;
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    // The default implementation of this method does nothing. Subclasses must override this method
    // and implement code to display an interstitial here.
}

@end
