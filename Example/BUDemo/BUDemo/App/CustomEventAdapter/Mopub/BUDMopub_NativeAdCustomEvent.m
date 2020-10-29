//
//  BUDMopub_NativeAdCustomEvent.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDMopub_NativeAdCustomEvent.h"
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
        slot.AdType = BUAdSlotAdTypeFeed;
        slot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
        
        _nativeAd = [[BUNativeAd alloc] initWithSlot:slot];
        _nativeAd.delegate = self;
    }
    return _nativeAd;
}

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *adPlacementId = [info objectForKey:@"ad_placement_id"];
    if ([adPlacementId isKindOfClass:[NSString class]] && adPlacementId.length) {
        self.nativeAd.adslot.ID = adPlacementId;
    }
    [self.nativeAd loadAdData];
}

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    [self.nativeAd loadAdData];
}

#pragma mark - BUNativeAdDelegate

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *)error {
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    BUDMopub_nativeAdAdapter *adapter = [[BUDMopub_nativeAdAdapter alloc] initWithBUNativeAd:nativeAd];
    MPNativeAd *mp_nativeAd = [[MPNativeAd alloc] initWithAdAdapter:adapter];
    [self.delegate nativeCustomEvent:self didLoadAd:mp_nativeAd];
}

@end
