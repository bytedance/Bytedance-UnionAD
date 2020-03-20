//
//  BUDAdmob_FeedNativeCustomEventAdapter.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BU_NativeAdCustomEventAdaptor_Back.h"
#import <BUAdSDK/BUNativeAdsManager.h>
#import <BUAdSDK/BUAdSlot.h>
#import "BUDSlotID.h"
#import "BUDMacros.h"
#import "BUDAdmob_nativeAdModel.h"
#import <GoogleMobileAds/GADCustomEventNativeAd.h>
#import <GoogleMobileAds/GADMultipleAdsAdLoaderOptions.h>

@interface BU_NativeAdCustomEventAdaptor_Back ()
@property (nonatomic, strong, getter=getNativeAd)BUNativeAdsManager *adManager;
@end

@implementation BU_NativeAdCustomEventAdaptor_Back

@synthesize delegate;

- (BUNativeAdsManager *)getNativeAd {
    if (_adManager == nil) {
        BUAdSlot *slot = [[BUAdSlot alloc] init];
        slot.ID = native_feed_ID;
        slot.AdType = BUAdSlotAdTypeFeed;
        slot.position = BUAdSlotPositionTop;
        slot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
        slot.isSupportDeepLink = YES;
        _adManager = [[BUNativeAdsManager alloc] initWithSlot:slot];
        _adManager.delegate = self;
    }
    return _adManager;
}

#pragma mark - GADCustomEventNativeAd
- (void)requestNativeAdWithParameter:(NSString *)serverParameter request:(GADCustomEventRequest *)request adTypes:(NSArray *)adTypes options:(NSArray *)options rootViewController:(UIViewController *)rootViewController {
    NSInteger count = 1;
    for (id obj in options) {
        if ([obj isKindOfClass:[GADMultipleAdsAdLoaderOptions class]]) {
            count = ((GADMultipleAdsAdLoaderOptions *)obj).numberOfAds;
        }
    }
    [self.adManager loadAdDataWithCount:count];
}

- (BOOL)handlesUserClicks {
    return NO;
}

- (BOOL)handlesUserImpressions {
    return NO;
}

#pragma mark - BUNativeAdsManagerDelegate
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    BUD_Log(@"%s",__func__);
    for (BUNativeAd * nativeAd in nativeAdDataArray) {
        BUDAdmob_nativeAdModel *model = [[BUDAdmob_nativeAdModel alloc] initWithBUNativeAd:nativeAd];
        [self.delegate customEventNativeAd:self didReceiveMediatedUnifiedNativeAd:model];
    }
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    [self.delegate customEventNativeAd:self didFailToLoadWithError:error];
}

@end
