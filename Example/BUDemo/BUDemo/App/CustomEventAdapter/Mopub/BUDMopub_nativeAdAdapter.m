//
//  BUDMopub_MPNativeCustomEvent.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDMopub_nativeAdAdapter.h"
#import "BUDSlotID.h"

#import <mopub-ios-sdk/MPNativeAd.h>
#import <mopub-ios-sdk/MPNativeAdConstants.h>

@interface BUDMopub_nativeAdAdapter ()
@end

@implementation BUDMopub_nativeAdAdapter

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd {
    if (self = [super init]) {
        self.properties = [self buNativeAdToDic:nativeAd];
    }
    return self;
}

- (NSDictionary *)buNativeAdToDic:(BUNativeAd *)nativeAd {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:nativeAd.data.AdTitle forKey:kAdTitleKey];
    [dic setValue:nativeAd.data.AdDescription forKey:kAdTextKey];
    [dic setValue:nativeAd.data.buttonText forKey:kAdCTATextKey];
    [dic setValue:nativeAd.data.icon.imageURL forKey:kAdIconImageKey];
    if (nativeAd.data.imageAry.count > 0) {
        [dic setValue:nativeAd.data.imageAry.firstObject.imageURL forKey:kAdMainImageKey];
    }
    // This is translate the ByteDance nativeAd
    [dic setValue:nativeAd forKey:@"bu_nativeAd"];
    return [dic copy];
}

- (BOOL)enableThirdPartyClickTracking {
    return NO;
}
@end
