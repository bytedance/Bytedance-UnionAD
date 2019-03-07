//
//  BUDAdmob_RewardCustomEventAdapterDelegate.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardCustomEventAdapterDelegate.h"
#import <BUAdSDK/BURewardedVideoModel.h>
#import <GoogleMobileAds/Mediation/GADMRewardBasedVideoAdNetworkConnectorProtocol.h>
#import "BUDMacros.h"

@interface BUDAdmob_RewardCustomEventAdapterDelegate ()
{
    /// Connector from Google Mobile Ads SDK to receive reward-based video ad configurations.
    __weak id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
    
    /// Adapter for receiving notification of reward-based video ad request.
    __weak id<GADMRewardBasedVideoAdNetworkAdapter> _rewardBasedVideoAdAdapter;
}
@end

@implementation BUDAdmob_RewardCustomEventAdapterDelegate

- (instancetype)initWithRewardBasedVideoAdAdapter:(id<GADMRewardBasedVideoAdNetworkAdapter>)adapter
                      rewardBasedVideoAdconnector:(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    self = [super init];
    if (self) {
        _rewardBasedVideoAdConnector = connector;
        _rewardBasedVideoAdAdapter = adapter;
    }
    return self;
}


- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"reawrded video data did load");
    [_rewardBasedVideoAdConnector adapterDidSetUpRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"reawrded video did load");
    [_rewardBasedVideoAdConnector adapterDidReceiveRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewarded video will visible");
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewarded video did close");
    [_rewardBasedVideoAdConnector adapterDidCloseRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewarded video did click");
    [_rewardBasedVideoAdConnector adapterDidGetAdClick:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    BUD_Log(@"rewarded video material load fail");
    [_rewardBasedVideoAdConnector adapter:_rewardBasedVideoAdAdapter didFailToSetUpRewardBasedVideoAdWithError:error];
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error) {
        BUD_Log(@"rewarded play error");
    } else {
        BUD_Log(@"rewarded play finish");
        [_rewardBasedVideoAdConnector adapterDidCompletePlayingRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"rewarded verify failed");
    
    BUD_Log(@"Demo CustomEventAdapter RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    BUD_Log(@"Demo CustomEventAdapter RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    BUD_Log(@"rewarded verify succeed");
    BUD_Log(@"verify result: %@", verify ? @"success" : @"fail");
    
    BUD_Log(@"Demo CustomEventAdapter RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    BUD_Log(@"Demo CustomEventAdapter RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}
@end
