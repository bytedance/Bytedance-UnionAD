//
//  BUDRewardCustomEventAdapter.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/4/11.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDRewardCustomEventAdapter.h"
#import "BUDRewardCustomEventAdapterDelegate.h"
#import <BUAdSDK/BURewardedVideoModel.h>
#import <BUAdSDK/BURewardedVideoAd.h>

@interface BUDRewardCustomEventAdapter ()
{
    __weak id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
    BUDRewardCustomEventAdapterDelegate *_adapterDelegate;
}
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;

@end

@implementation BUDRewardCustomEventAdapter

+ (NSString *)adapterVersion {
    return @"1.0";
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    // OPTIONAL: Create your own class implementing GADAdNetworkExtras and return that class type
    // here for your publishers to use. This class does not use extras.
    return Nil;
}

- (instancetype)initWithRewardBasedVideoAdNetworkConnector:(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    if (!connector) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _rewardBasedVideoAdConnector = connector;
        _adapterDelegate = [[BUDRewardCustomEventAdapterDelegate alloc] initWithRewardBasedVideoAdAdapter:self rewardBasedVideoAdconnector:_rewardBasedVideoAdConnector];
    }
    return self;
}

/// Tells the adapter to set up reward based video ads. When set up fails, the Sample SDK may try to
/// set up the adapter again.
- (void)setUp {
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    model.isShowDownloadBar = YES;
    ///配置slotId
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:@"900546748" rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = _adapterDelegate;
    [self.rewardedVideoAd loadAdData];
}

/// Tells the adapter to request a reward based video ad, if checkAdAvailability is true. Otherwise,
/// the connector notifies the adapter that the reward based video ad failed to load.
- (void)requestRewardBasedVideoAd {
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    if ([_rewardedVideoAd isAdValid]) {
        [strongConnector adapterDidReceiveRewardBasedVideoAd:self];
    } else {
        NSString *description = @"Failed to load ad.";
        NSDictionary *userInfo =
        @{NSLocalizedDescriptionKey : description, NSLocalizedFailureReasonErrorKey : description};
        NSError *error =
        [NSError errorWithDomain:@"com.google.mediation.toutiao" code:0 userInfo:userInfo];
        [strongConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
    }
}

/// Tells the adapter to present the reward based video ad with the provided view controller, if the
/// ad is available. Otherwise, logs a message with the reason for failure.
- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
    if ([_rewardedVideoAd isAdValid]) {
        // The reward based video ad is available, present the ad.
        [_rewardedVideoAd showAdFromRootViewController:viewController];
    } else {
        // Because publishers are expected to check that an ad is available before trying to show one,
        // the above conditional should always hold true. If for any reason the adapter is not ready to
        // present an ad, however, it should log an error with reason for failure.
        NSLog(@"No ads to show.");
    }
}

- (void)stopBeingDelegate {
    _rewardedVideoAd.delegate = nil;
}
@end
