//
//  BUDAdmob_NativeFeedAd.h
//  AdmobAdapterDemo
//
//  Created by Gu Chan on 2020/07/06.
//  Copyright © 2020 GuChan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <BUAdSDK/BUAdSDK.h>

@interface BUDAdmob_NativeFeedAd: NSObject <GADMediatedUnifiedNativeAd>

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd disableImageLoading:(BOOL)disableImageLoading;

@end
