//
//  BUDAdmob_nativeAdModel.h
//  BUDemo
//
//  Created by liudonghui on 2020/1/5.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/Mediation/GADMediationNativeAd.h>
#import <BUAdSDK/BUNativeAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDAdmob_nativeAdModel : NSObject <GADMediatedUnifiedNativeAd>

@property (nonatomic, strong) BUNativeAd *nativeAd;

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
