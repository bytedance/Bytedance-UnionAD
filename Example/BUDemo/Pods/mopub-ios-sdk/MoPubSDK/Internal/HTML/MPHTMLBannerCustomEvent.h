//
//  MPHTMLBannerCustomEvent.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPBannerCustomEvent.h"
#import "MPAdWebViewAgent.h"
#import "MPPrivateBannerCustomEventDelegate.h"

@interface MPHTMLBannerCustomEvent : MPBannerCustomEvent <MPAdWebViewAgentDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, weak) id<MPPrivateBannerCustomEventDelegate> delegate;
#pragma clang diagnostic pop

@end
