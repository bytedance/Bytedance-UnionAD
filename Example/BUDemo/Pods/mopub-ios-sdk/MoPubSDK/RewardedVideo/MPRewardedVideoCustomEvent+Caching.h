//
//  MPRewardedVideoCustomEvent+Caching.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPRewardedVideoCustomEvent.h"

/**
 * Provides caching support for network SDK initialization parameters.
 */
@interface MPRewardedVideoCustomEvent (Caching)

/**
 * Updates the initialization parameters for the current network.
 * @param params New set of initialization parameters. Nothing will be done if `nil` is passed in.
 */
- (void)setCachedInitializationParameters:(NSDictionary * _Nullable)params;

/**
 * Retrieves the initialization parameters for the current network (if any).
 * @return The cached initialization parameters for the network. This may be `nil` if not parameters were found.
 */
- (NSDictionary * _Nullable)cachedInitializationParameters;

@end
