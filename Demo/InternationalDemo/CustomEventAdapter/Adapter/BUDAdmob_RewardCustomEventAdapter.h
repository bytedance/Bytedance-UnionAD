//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

//rewardedvideo ad adapter
@interface BUDAdmob_RewardCustomEventAdapter : NSObject

- (void)loadRewardedAdForAdConfiguration:
(nonnull GADMediationRewardedAdConfiguration *)adConfiguration
                       completionHandler:
(nonnull GADMediationRewardedLoadCompletionHandler)completionHandler;

@end
