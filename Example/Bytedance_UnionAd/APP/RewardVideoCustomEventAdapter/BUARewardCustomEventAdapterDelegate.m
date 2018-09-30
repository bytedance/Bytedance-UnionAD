//
//  BUARewardCustomEventAdapterDelegate.m
//  BUAemo
//
//  Created by bytedance_yuanhuan on 2018/4/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUARewardCustomEventAdapterDelegate.h"
#import <WMAdSDK/WMRewardedVideoModel.h>
#import <GoogleMobileAds/Mediation/GADMRewardBasedVideoAdNetworkConnectorProtocol.h>

@interface BUARewardCustomEventAdapterDelegate ()
{
    /// Connector from Google Mobile Ads SDK to receive reward-based video ad configurations.
    __weak id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
    
    /// Adapter for receiving notification of reward-based video ad request.
    __weak id<GADMRewardBasedVideoAdNetworkAdapter> _rewardBasedVideoAdAdapter;
}
@end

@implementation BUARewardCustomEventAdapterDelegate

- (instancetype)initWithRewardBasedVideoAdAdapter:(id<GADMRewardBasedVideoAdNetworkAdapter>)adapter
                      rewardBasedVideoAdconnector:
(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    self = [super init];
    if (self) {
        _rewardBasedVideoAdConnector = connector;
        _rewardBasedVideoAdAdapter = adapter;
    }
    return self;
}


- (void)rewardedVideoAdDidLoad:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"reawrded video Ad did load");
    NSLog(@"激励视频物料加载成功");
    [_rewardBasedVideoAdConnector adapterDidSetUpRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdVideoDidLoad:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"reawrded video did load");
    [_rewardBasedVideoAdConnector adapterDidReceiveRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdWillVisible:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded video will visible");
}

- (void)rewardedVideoAdDidClose:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded video did close");
    [_rewardBasedVideoAdConnector adapterDidCloseRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAdDidClickDownload:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded video did click download");
    [_rewardBasedVideoAdConnector adapterDidGetAdClick:_rewardBasedVideoAdAdapter];
}

- (void)rewardedVideoAd:(WMRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"rewarded video material load fail");
    [_rewardBasedVideoAdConnector adapter:_rewardBasedVideoAdAdapter didFailToSetUpRewardBasedVideoAdWithError:error];
}

- (void)rewardedVideoAdDidPlayFinish:(WMRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"rewarded play error");
    } else {
        NSLog(@"rewarded play finish");
        [_rewardBasedVideoAdConnector adapterDidCompletePlayingRewardBasedVideoAd:_rewardBasedVideoAdAdapter];
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(WMRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewarded verify failed");
}

- (void)rewardedVideoAdServerRewardDidSucceed:(WMRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    NSLog(@"rewarded verify succeed");
    NSLog(@"verify result: %@", verify ? @"success" : @"fail");
}
@end
