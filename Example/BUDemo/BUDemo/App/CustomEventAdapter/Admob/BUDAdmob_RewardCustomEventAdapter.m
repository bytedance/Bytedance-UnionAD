//
//  BUDAdmob_RewardCustomEventAdapter.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardCustomEventAdapter.h"
#import <BUAdSDK/BURewardedVideoModel.h>
#import <BUAdSDK/BURewardedVideoAd.h>
#import "BUDMacros.h"
#import "BUDSlotID.h"

@interface BUDAdmob_RewardCustomEventAdapter ()<BURewardedVideoAdDelegate>
{
    __weak id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
}
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;

@end

@implementation BUDAdmob_RewardCustomEventAdapter

+ (NSString *)adapterVersion {
    return @"1.0";
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return Nil;
}

- (instancetype)initWithRewardBasedVideoAdNetworkConnector:(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    if (!connector) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _rewardBasedVideoAdConnector = connector;
    }
    return self;
}

- (void)setUp {
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterDidSetUpRewardBasedVideoAd:self];
}

- (void)requestRewardBasedVideoAd {
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:normal_reward_ID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
}

- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
    if ([_rewardedVideoAd isAdValid]) {
        [_rewardedVideoAd showAdFromRootViewController:viewController ritScene:0 ritSceneDescribe:nil];
    } else {
        BUD_Log(@"No ads to show.");
    }
}

- (void)stopBeingDelegate {
    _rewardedVideoAd.delegate = nil;
}

#pragma mark BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    [_rewardBasedVideoAdConnector adapterDidReceiveRewardBasedVideoAd:self];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [_rewardBasedVideoAdConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    [_rewardBasedVideoAdConnector adapterDidOpenRewardBasedVideoAd:self];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    [_rewardBasedVideoAdConnector adapterDidCloseRewardBasedVideoAd:self];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    [_rewardBasedVideoAdConnector adapterDidGetAdClick:self];
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error) {
    } else {
        [_rewardBasedVideoAdConnector adapterDidCompletePlayingRewardBasedVideoAd:self];
    }
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        [_rewardBasedVideoAdConnector adapter:self didRewardUserWithReward:nil];
    }
    BUD_Log(@"%s", __func__);
}

@end
