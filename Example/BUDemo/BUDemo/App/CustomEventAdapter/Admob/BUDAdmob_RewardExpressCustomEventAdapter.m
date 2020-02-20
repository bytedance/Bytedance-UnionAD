//
//  BUDAdmob_RewardExpressCustomEventAdapter.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/26.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmob_RewardExpressCustomEventAdapter.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDAdmob_RewardExpressCustomEventAdapter()<BUNativeExpressRewardedVideoAdDelegate>
{
    __weak id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
}
@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedVideoAd;

@end

@implementation BUDAdmob_RewardExpressCustomEventAdapter
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
    self.rewardedVideoAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:express_reward_ID rewardedVideoModel:model];
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

#pragma mark BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    [_rewardBasedVideoAdConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    [_rewardBasedVideoAdConnector adapterDidReceiveRewardBasedVideoAd:self];
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    [_rewardBasedVideoAdConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
}

- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    [_rewardBasedVideoAdConnector adapterDidOpenRewardBasedVideoAd:self];
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    [_rewardBasedVideoAdConnector adapterDidCloseRewardBasedVideoAd:self];
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
    [_rewardBasedVideoAdConnector adapterDidGetAdClick:self];
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    if (error) {
        
    } else {
        [_rewardBasedVideoAdConnector adapterDidCompletePlayingRewardBasedVideoAd:self];
    }
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        [_rewardBasedVideoAdConnector adapter:self didRewardUserWithReward:nil];
    }
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

@end
