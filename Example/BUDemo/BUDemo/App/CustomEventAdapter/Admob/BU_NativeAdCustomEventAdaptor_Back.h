//
//  BUDAdmob_FeedNativeCustomEventAdapter.h
//  BUDemo
//
//  Created by liudonghui on 2020/1/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDBaseExampleViewController.h"
#import <GoogleMobileAds/GADCustomEventNativeAd.h>
#import <BUAdSDK/BUNativeAdsManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface BU_NativeAdCustomEventAdaptor_Back : NSObject <GADCustomEventNativeAd,BUNativeAdsManagerDelegate>

@end

NS_ASSUME_NONNULL_END
