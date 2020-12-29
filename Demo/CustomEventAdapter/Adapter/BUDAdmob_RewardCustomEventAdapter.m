//
//  BUDAdmob_RewardCustomEventAdapter.m
//  AdmobAdapterDemo
//
//  Created by Gu Chan on 2020/07/03.
//  Copyright © 2020 GuChan. All rights reserved.
//

#import "BUDAdmob_RewardCustomEventAdapter.h"
#import <BUAdSDK/BURewardedVideoModel.h>
#import <BUAdSDK/BURewardedVideoAd.h>
#import <BUAdSDK/BUAdSDK.h>


@interface BUDAdmob_RewardCustomEventAdapter ()<BURewardedVideoAdDelegate,GADMediationRewardedAd>
{
}

@property (nonatomic, weak, nullable) id<GADMediationRewardedAdEventDelegate> delegate;
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@property (nonatomic, copy) GADMediationRewardedLoadCompletionHandler completionHandler;

@end



@implementation BUDAdmob_RewardCustomEventAdapter

NSString *const REWARD_PANGLE_PLACEMENT_ID = @"placementID";

#pragma mark - GADMediationAdapter
/// Returns the adapter version.
+ (GADVersionNumber)version{
    NSString *versionString = @"1.0.0";
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 3) {
        version.majorVersion = [versionComponents[0] integerValue];
        version.minorVersion = [versionComponents[1] integerValue];
        version.patchVersion = [versionComponents[2] integerValue];
    }
    return version;
}

/// Returns the ad SDK version.
+ (GADVersionNumber)adSDKVersion{
    NSString *versionString = BUAdSDKManager.SDKVersion;
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 4) {
        version.majorVersion = [versionComponents[0] integerValue];
        version.minorVersion = [versionComponents[1] integerValue];
        version.patchVersion = [versionComponents[2] integerValue];
    }
    return version;
}

/// The extras class that is used to specify additional parameters for a request to this ad network.
/// Returns Nil if the network doesn't have publisher provided extras.
+ (nullable Class<GADAdNetworkExtras>)networkExtrasClass {
    return Nil;
}

- (void)loadRewardedAdForAdConfiguration:
(nonnull GADMediationRewardedAdConfiguration *)adConfiguration
                       completionHandler:
(nonnull GADMediationRewardedLoadCompletionHandler)completionHandler {
    // Look for the "parameter" key to fetch the parameter you defined in the AdMob UI.
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    //User ID, a required parameter for rewarded video ads
    model.userId = @"your app user id";
    NSDictionary<NSString *, id> *credentials = adConfiguration.credentials.settings;
    NSString *placementID = [self processParams:(credentials[@"parameter"])];
    NSLog(@"placementID=%@",placementID);
    if (placementID != nil){
        self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:placementID rewardedVideoModel:model];
        self.rewardedVideoAd.delegate = self;
        [self.rewardedVideoAd loadAdData];
        self.completionHandler = completionHandler;
    } else {
        NSLog(@"no pangle placement ID for requesting.");
        [self.delegate didFailToPresentWithError:[NSError errorWithDomain:@"error placementID" code:-1 userInfo:nil]];
    }
}


#pragma mark - GADMediationRewardedAd
- (void)presentFromViewController:(nonnull UIViewController *)viewController{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if ([_rewardedVideoAd isAdValid]) {
        [_rewardedVideoAd showAdFromRootViewController:viewController ritScene:0 ritSceneDescribe:nil];
    } else {
        NSLog(@"No Pange reward ads to show.");
        NSError *error =
        [NSError errorWithDomain:@"GADMediationAdapterSampleAdNetwork"
                            code:0
                        userInfo:@{NSLocalizedDescriptionKey : @"Unable to display ad."}];
        [self.delegate didFailToPresentWithError:error];
    }
#pragma clang diagnostic pop
}

#pragma mark BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    if (self.completionHandler) {
        self.delegate = self.completionHandler(self, nil);
    }
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (self.completionHandler) {
        self.completionHandler(nil, error);
    }
    NSLog(@"rewardedVideoAd with error %@", error.description);
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate willPresentFullScreenView];
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate reportImpression];
    [self.delegate didStartVideo];
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd{
    [self.delegate willDismissFullScreenView];
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate didDismissFullScreenView];
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    [self.delegate reportClick];
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [self.delegate didEndVideo];
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd error:(NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        NSNumber *amount = [NSDecimalNumber numberWithInteger:rewardedVideoAd.rewardedVideoModel.rewardAmount];
        
        GADAdReward *aReward =
        [[GADAdReward alloc] initWithRewardType:@""
                                   rewardAmount:[NSDecimalNumber decimalNumberWithDecimal:[amount decimalValue]]];
        
        [self.delegate didRewardUserWithReward:aReward];
    }
    NSLog(@"%s", __func__);
}


- (NSString *)processParams:(NSString *)param {
    if (!param) {
        return nil;
    }
    NSError *jsonReadingError;
    NSData *data = [param dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&jsonReadingError];
    
    if (jsonReadingError) {
        NSLog(@"jsonReadingError. data=[%@], error=[%@]", json, jsonReadingError);
        return nil;
    }
    
    if (![NSJSONSerialization isValidJSONObject:json]) {
        NSLog(@"This is NOT JSON data.[%@]", json);
        return nil;
    }
    NSString *placementID = json[REWARD_PANGLE_PLACEMENT_ID];
    return placementID;
}

@end
