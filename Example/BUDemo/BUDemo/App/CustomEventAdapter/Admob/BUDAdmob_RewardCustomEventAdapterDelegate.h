//
//  BUDAdmob_RewardCustomEventAdapterDelegate.h
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BURewardedVideoAd.h>

@protocol GADMRewardBasedVideoAdNetworkAdapter;
@protocol GADMRewardBasedVideoAdNetworkConnector;

@interface BUDAdmob_RewardCustomEventAdapterDelegate : NSObject<BURewardedVideoAdDelegate>

/// Returns a SampleAdapterDelegate with a reward-based video ad adapter and reward-based video ad
/// connector.
- (instancetype)initWithRewardBasedVideoAdAdapter:(id<GADMRewardBasedVideoAdNetworkAdapter>)adapter
                      rewardBasedVideoAdconnector:
(id<GADMRewardBasedVideoAdNetworkConnector>)connector
NS_DESIGNATED_INITIALIZER;

/// Unavailable.
- (instancetype)init NS_UNAVAILABLE;

@end
