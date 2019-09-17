//
//  MPAnalyticsTracker.h
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

@class MPAdConfiguration;

@interface MPAnalyticsTracker : NSObject

+ (MPAnalyticsTracker *)sharedTracker;

- (void)trackImpressionForConfiguration:(MPAdConfiguration *)configuration;
- (void)trackClickForConfiguration:(MPAdConfiguration *)configuration;
- (void)sendTrackingRequestForURLs:(NSArray *)URLs;

@end
