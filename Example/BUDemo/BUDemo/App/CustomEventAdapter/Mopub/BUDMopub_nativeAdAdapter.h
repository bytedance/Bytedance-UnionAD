//
//  BUDMopub_MPNativeCustomEvent.h
//  BUDemo
//
//  Created by liudonghui on 2020/1/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <mopub-ios-sdk/MPNativeAdAdapter.h>
#import <BUAdSDK/BUNativeAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDMopub_nativeAdAdapter : NSObject  <MPNativeAdAdapter>

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd;
@property (nonatomic, strong) NSDictionary *properties;
@property (nonatomic, strong) NSURL *defaultActionURL;

@end

NS_ASSUME_NONNULL_END

