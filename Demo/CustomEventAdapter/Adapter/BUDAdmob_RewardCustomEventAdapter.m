//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDAdmob_RewardCustomEventAdapter.h"
#import "BUDAdmobTool.h"
#import <PAGAdSDK/PAGRewardedAd.h>
#import <PAGAdSDK/PAGRewardModel.h>

@interface BUDAdmob_RewardCustomEventAdapter ()<PAGRewardedAdDelegate,GADMediationRewardedAd>
{
}

@property (nonatomic, weak, nullable) id<GADMediationRewardedAdEventDelegate> delegate;
@property (nonatomic, strong) PAGRewardedAd *rewardedAd;

@end


@implementation BUDAdmob_RewardCustomEventAdapter

NSString *const REWARD_PLACEMENT_ID = @"placementID";

- (void)loadRewardedAdForAdConfiguration:
(nonnull GADMediationRewardedAdConfiguration *)adConfiguration
                       completionHandler:
(nonnull GADMediationRewardedLoadCompletionHandler)completionHandler {
    // Look for the "parameter" key to fetch the parameter you defined in the AdMob UI.
    NSDictionary<NSString *, id> *credentials = adConfiguration.credentials.settings;
    NSString *placementID = credentials[@"parameter"];
    NSLog(@"placementID=%@",placementID);
    if (placementID != nil){
        /// tag
        [BUDAdmobTool setExtData];
        __weak typeof(self) weakSelf = self;
        [PAGRewardedAd loadAdWithSlotID:placementID request:[PAGRewardedRequest request] completionHandler:^(PAGRewardedAd * _Nullable rewardedAd, NSError * _Nullable error) {
            if(rewardedAd) {
                
            }
            weakSelf.rewardedAd = rewardedAd;
            weakSelf.rewardedAd.delegate = weakSelf;
            weakSelf.delegate = completionHandler(weakSelf, nil);
        }];
    } else {
        NSLog(@"no placement ID for requesting.");
        [self.delegate didFailToPresentWithError:[NSError errorWithDomain:@"error placementID" code:-1 userInfo:nil]];
        [self _logWithSEL:_cmd msg:@"called didFailToPresentWithError:code:userInfo:"];
    }
}

#pragma mark - GADMediationRewardedAd
- (void)presentFromViewController:(nonnull UIViewController *)viewController{
    if (self.rewardedAd) {
        [self.rewardedAd presentFromRootViewController:viewController];
    }
    else {
        NSError *error =
              [NSError errorWithDomain:@"GADMediationAdapterSampleAdNetwork"
                                  code:0
                              userInfo:@{NSLocalizedDescriptionKey : @"Unable to display ad."}];
        [self.delegate didFailToPresentWithError:error];
    }
}

#pragma mark - PAGRewardedAdDelegate

- (void)adDidShow:(PAGRewardedAd *)ad {
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
    [self _logWithSEL:_cmd msg:@"called willPresentFullScreenView: and reportImpression:"];
}

- (void)adDidClick:(PAGRewardedAd *)ad {
    [self.delegate reportClick];
    [self _logWithSEL:_cmd msg:@"called reportClick:"];
}

- (void)adDidDismiss:(PAGRewardedAd *)ad {
    [self.delegate willDismissFullScreenView];
    [self.delegate didDismissFullScreenView];
    [self _logWithSEL:_cmd msg:@"called willDismissFullScreenView: and didDismissFullScreenView:"];
}

- (void)rewardedAd:(PAGRewardedAd *)rewardedAd userDidEarnReward:(PAGRewardModel *)rewardModel {
    NSString *amountStr = [NSString stringWithFormat:@"%ld", rewardModel.rewardAmount];
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:amountStr];
    GADAdReward *aReward =
          [[GADAdReward alloc] initWithRewardType:@""
                                     rewardAmount:amount];
    [self.delegate didRewardUserWithReward:aReward];
    [self _logWithSEL:_cmd msg:[NSString stringWithFormat:@"called didRewardUserWithReward, rewardName:%@ rewardMount:%ld",rewardModel.rewardName,(long)rewardModel.rewardAmount]];
}

- (void)rewardedAd:(PAGRewardedAd *)rewardedAd userEarnRewardFailWithError:(NSError *)error {
    [self _logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@",error]];
}

#pragma mark - private

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    NSLog(@"BUDAdmob_RewardCustomEventAdapter | %@ | %@", NSStringFromSelector(sel), msg);
}


@end
