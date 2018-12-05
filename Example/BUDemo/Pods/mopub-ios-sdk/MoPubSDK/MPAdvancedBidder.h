//
//  MPAdvancedBidder.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>

@protocol MPAdvancedBidder <NSObject>
@required
/**
 * The name of the network that generated the token.
 * @remark This value should correspond to `creative_network_name` in the dashboard.
 */
@property (nonatomic, copy, readonly) NSString * _Nonnull creativeNetworkName;

/**
 * An identity token needed for ORTB requests to the bidder.
 */
@property (nonatomic, copy, readonly) NSString * _Nonnull token;
@end
