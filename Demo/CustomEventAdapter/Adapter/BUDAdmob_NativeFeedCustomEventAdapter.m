//
//  BUDAdmob_NativeFeedCustomEventAdapter.m
//  AdmobAdapterDemo
//
//  Created by Gu Chan on 2020/07/03.
//  Copyright © 2020 GuChan. All rights reserved.
//

#import "BUDAdmob_NativeFeedCustomEventAdapter.h"
#import <BUAdSDK/BUAdSDK.h>
#import <GoogleMobileAds/GADCustomEventNativeAd.h>
#import <GoogleMobileAds/GADMultipleAdsAdLoaderOptions.h>
#import "BUDAdmob_NativeFeedAd.h"


@interface BUDAdmob_NativeFeedCustomEventAdapter ()<GADCustomEventNativeAd,BUNativeAdsManagerDelegate,BUNativeAdDelegate>

@property (nonatomic, strong, getter=getNativeAd)BUNativeAdsManager *adManager;
@property (nonatomic, assign) BOOL disableImageLoading;
@property (nonatomic, weak) UIViewController *root;

@end



@implementation BUDAdmob_NativeFeedCustomEventAdapter

@synthesize delegate;

NSString *const FEED_PANGLE_PLACEMENT_ID = @"placementID";


/// request ad with placementID  adn count
- (void)getNativeAd:(NSString *)placementID count:(NSInteger)count {
    if (self.adManager == nil) {
        BUAdSlot *slot = [[BUAdSlot alloc] init];
        //slot.ID = @"945292641" for video
        slot.ID = placementID;
        slot.AdType = BUAdSlotAdTypeFeed;
        slot.position = BUAdSlotPositionTop;
        slot.imgSize = [BUSize sizeBy:BUProposalSize_Banner600_400];
        self.adManager = [[BUNativeAdsManager alloc] initWithSlot:slot];
        self.adManager.delegate = self;
    }
    [self.adManager loadAdDataWithCount:count];
}

#pragma mark - GADCustomEventNativeAd
- (void)requestNativeAdWithParameter:(NSString *)serverParameter
                             request:(GADCustomEventRequest *)request
                             adTypes:(NSArray *)adTypes
                             options:(NSArray *)options
                  rootViewController:(UIViewController *)rootViewController {
    NSInteger count = 1;
    _root = rootViewController;
    for (id obj in options) {
        
        if ([obj isKindOfClass:[GADNativeAdImageAdLoaderOptions class]]) {
            _disableImageLoading = ((GADNativeAdImageAdLoaderOptions *)obj).disableImageLoading;
        }
        //Ad loader options for requesting multiple ads. Requesting multiple ads in a single request is currently only available for native app install ads and native content ads
        if ([obj isKindOfClass:[GADMultipleAdsAdLoaderOptions class]]) {
            count = ((GADMultipleAdsAdLoaderOptions *)obj).numberOfAds;
        }
    }
    NSString *placementID = [self processParams:serverParameter];
    NSLog(@"placementID=%@",placementID);
    if (placementID != nil){
        [self getNativeAd:placementID count:count];
    } else {
        NSLog(@"no pangle placement ID for requesting.");
        [self.delegate customEventNativeAd:self didFailToLoadWithError:[NSError errorWithDomain:@"error placementID" code:-1 userInfo:nil]];
    }
}

- (BOOL)handlesUserClicks {
    return NO;
}

- (BOOL)handlesUserImpressions {
    return NO;
}

#pragma mark - BUNativeAdsManagerDelegate
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {

    for (BUNativeAd * nativeAd in nativeAdDataArray) {
        nativeAd.rootViewController = _root;
//        nativeAd.delegate = self;
        BUDAdmob_NativeFeedAd *ad = [[BUDAdmob_NativeFeedAd alloc] initWithBUNativeAd:nativeAd disableImageLoading:_disableImageLoading];
        [self.delegate customEventNativeAd:self didReceiveMediatedUnifiedNativeAd:ad];
    }
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    NSLog(@"nativeAdsManager with error %@", error.description);
    [self.delegate customEventNativeAd:self didFailToLoadWithError:error];
}


- (NSString *)processParams:(NSString *)param {
    if (!param) {
        return nil;
    }
    NSError *jsonReadingError;
    NSData *data = [param dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&jsonReadingError];
    if (jsonReadingError) {
        NSLog(@"jsonReadingError. data=[%@], error=[%@]", json, jsonReadingError);
        return nil;
    }
    
    if (![NSJSONSerialization isValidJSONObject:json]) {
        NSLog(@"This is NOT JSON data.[%@]", json);
        return nil;
    }
    NSString *placementID = json[FEED_PANGLE_PLACEMENT_ID];
    return placementID;
}

//
///**
// This method is called when native ad material loaded successfully.
// */
//- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
//    NSLog(@"%s",__FUNCTION__);
//}
//
///**
// This method is called when native ad materia failed to load.
// @param error : the reason of error
// */
//- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
//    NSLog(@"%s",__FUNCTION__);
//}
//
///**
// This method is called when native ad slot has been shown.
// */
//- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
//    NSLog(@"%s",__FUNCTION__);
//}
//
///**
// This method is called when another controller has been closed.
// @param interactionType : open appstore in app or open the webpage or view video ad details page.
// */
//- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
//    NSLog(@"%s",__FUNCTION__);
//}
//
///**
// This method is called when native ad is clicked.
// */
//- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
//    NSLog(@"%s",__FUNCTION__);
//}
//
///**
// This method is called when the user clicked dislike reasons.
// Only used for dislikeButton in BUNativeAdRelatedView.h
// @param filterWords : reasons for dislike
// */
//- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterWords {
//    NSLog(@"%s",__FUNCTION__);
//}

@end
