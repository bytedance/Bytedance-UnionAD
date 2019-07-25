//
//  BUDMopub_RewardedVideoCustomEvent.m
//  mopub_adaptor
//
//  Created by bytedance_yuanhuan on 2018/9/18.
//  Copyright © 2018年 Siwant. All rights reserved.
//

#import "BUDMopub_RewardedVideoCustomEvent.h"
#import "BUDMopub_RewardVideoCustomEventDelegate.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDMopub_RewardedVideoCustomEvent ()
@property (nonatomic, strong) BURewardedVideoAd *rewardVideoAd;
@property (nonatomic, strong) BUDMopub_RewardVideoCustomEventDelegate *customEventDelegate;
@end

@implementation BUDMopub_RewardedVideoCustomEvent

-(void)initializeSdkWithParameters:(NSDictionary *)parameters {

}
    
-(void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info {
    
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    
    BURewardedVideoAd *RewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:@"900546826" rewardedVideoModel:model];
    RewardedVideoAd.delegate = self.customEventDelegate;
    self.rewardVideoAd = RewardedVideoAd;
    [RewardedVideoAd loadAdData];
}

-(BOOL)hasAdAvailable {
    return self.rewardVideoAd.isAdValid;
}
    
-(void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    [self.rewardVideoAd showAdFromRootViewController:viewController ritScene:0 ritSceneDescribe:nil];
}

-(BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

- (BUDMopub_RewardVideoCustomEventDelegate *)customEventDelegate {
    if (!_customEventDelegate) {
        _customEventDelegate = [[BUDMopub_RewardVideoCustomEventDelegate alloc] init];
        _customEventDelegate.adapter = self;
    }
    return _customEventDelegate;
}
@end
