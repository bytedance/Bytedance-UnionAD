//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDAdmob_FullScreenVideoCustomEventAdapter : NSObject

- (void)loadInterstitialForAdConfiguration:(GADMediationInterstitialAdConfiguration *)adConfiguration completionHandler:(GADMediationInterstitialLoadCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
