//
//  BUDRewardCustomEventAdapterDelegate.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDRewardCustomEventAdapterDelegate.h"
#import <BUAdSDK/BURewardedVideoModel.h>
#import <GoogleMobileAds/Mediation/GADMRewardBasedVideoAdNetworkConnectorProtocol.h>

@interface BUDRewardCustomEventAdapterDelegate ()
{
    /// Connector from Google Mobile Ads SDK to receive reward-based video ad configurations.
    __weak id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
    
    /// Adapter for receiving notification of reward-based video ad request.
    __weak id<GADMRewardBasedVideoAdNetworkAdapter> _rewardBasedVideoAdAdapter;
}
@end

@implementation BUDRewardCustomEventAdapterDelegate

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
    NSLog(@"reawrded video Ad did load");
    NSLog(@"激励视频物料加载成功");
    [_rewardBasedVideoAdConnector adapterDidSetUpRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"reawrded video did load");
    [_rewardBasedVideoAdConnector adapterDidReceiveRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded video will visible");
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded video did close");
    [_rewardBasedVideoAdConnector adapterDidCloseRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded video did click");
    [_rewardBasedVideoAdConnector adapterDidGetAdClick:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"rewarded video material load fail");
    [_rewardBasedVideoAdConnector adapter:_rewardBasedVideoAdAdapter didFailToSetUpRewardBasedVideoAdWithError:error];
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"rewarded play error");
    } else {
        NSLog(@"rewarded play finish");
        [_rewardBasedVideoAdConnector adapterDidCompletePlayingRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded verify failed");
    
    NSLog(@"Demo CustomEventAdapter RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    NSLog(@"Demo CustomEventAdapter RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    NSLog(@"rewarded verify succeed");
    NSLog(@"verify result: %@", verify ? @"success" : @"fail");
    
    NSLog(@"Demo CustomEventAdapter RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    NSLog(@"Demo CustomEventAdapter RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}
@end
