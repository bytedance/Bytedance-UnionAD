//
//  BUDMopub_NativeAdCustomEvent.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDMopub_NativeAdCustomEvent.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDMopub_nativeAdAdapter.h"

#import <BUAdSDK/BUNativeAd.h>
#import <mopub-ios-sdk/MPNativeAdRendererSettings.h>
#import <mopub-ios-sdk/MPNativeAd.h>

@interface BUDMopub_NativeAdCustomEvent () <BUNativeAdDelegate>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@end
 
@implementation BUDMopub_NativeAdCustomEvent

- (BUNativeAd *)nativeAd {
    if (_nativeAd == nil) {
        BUAdSlot *slot = [[BUAdSlot alloc] init];
        slot.ID = native_feed_ID;
        slot.AdType = BUAdSlotAdTypeFeed;
        slot.position = BUAdSlotPositionTop;
        slot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
        slot.isSupportDeepLink = YES;
        
        _nativeAd = [[BUNativeAd alloc] initWithSlot:slot];
        _nativeAd.delegate = self;
    }
    return _nativeAd;
}

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    [self.nativeAd loadAdData];
}

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    [self.nativeAd loadAdData];
}

#pragma mark - BUNativeAdDelegate

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *)error {
    BUD_Log(@"%s",__func__);
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
    BUDMopub_nativeAdAdapter *adapter = [[BUDMopub_nativeAdAdapter alloc] initWithBUNativeAd:nativeAd];
    MPNativeAd *mp_nativeAd = [[MPNativeAd alloc] initWithAdAdapter:adapter];
    [self.delegate nativeCustomEvent:self didLoadAd:mp_nativeAd];
}

@end
