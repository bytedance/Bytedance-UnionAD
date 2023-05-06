//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDAdmob_BannerCustomEventAdapter : NSObject

@property(nonatomic, readonly, nonnull) UIView *view;

- (void)loadBannerForAdConfiguration:(GADMediationBannerAdConfiguration *)adConfiguration completionHandler:(GADMediationBannerLoadCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END

