//
//  BUDAdmob_BannerCustomEventAdapter.m
//  BUADVADemo
//
//  Created by bytedance on 2020/9/28.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_BannerCustomEventAdapter.h"
#import <BUAdSDK/BUAdSDK.h>
#import <GoogleMobileAds/GADCustomEventBanner.h>

@interface BUDAdmob_BannerCustomEventAdapter ()<GADCustomEventBanner, BUNativeExpressBannerViewDelegate>
@property (strong, nonatomic) BUNativeExpressBannerView *nativeExpressBannerView;
@end

@implementation BUDAdmob_BannerCustomEventAdapter

@synthesize delegate;
NSString *const BANNER_PANGLE_PLACEMENT_ID = @"placementID";

#pragma mark - GADBannerView
- (void)requestBannerAd:(GADAdSize)adSize parameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    
    NSString *placementID = [self processParams:serverParameter size:adSize.size];
    if (placementID != nil){
        [self getTemplateBannerAd:placementID adSize:adSize];
    } else {
        NSLog(@"no pangle placement ID for requesting.");
        [self.delegate customEventBanner:self didFailAd:[NSError errorWithDomain:@"error placementID" code:-1 userInfo:nil]];
    }
}

- (void)getTemplateBannerAd:(NSString *)placementID adSize:(GADAdSize)adSize {
    NSLog(@"placementID=%@",placementID);
    NSLog(@"request ad size width = %f",adSize.size.width);
    NSLog(@"request ad size height = %f",adSize.size.height);
    
    ///If this method is not available in your SDK version, use the annotated method below
    self.nativeExpressBannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:placementID rootViewController:self.delegate.viewControllerForPresentingModalView adSize:CGSizeMake(adSize.size.width, adSize.size.height)];
//    self.nativeExpressBannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:placementID rootViewController:self.delegate.viewControllerForPresentingModalView adSize:CGSizeMake(adSize.size.width, adSize.size.height) IsSupportDeepLink:YES];
    
    self.nativeExpressBannerView.frame = CGRectMake(0, 0, adSize.size.width, adSize.size.height);
    self.nativeExpressBannerView.delegate = self;
    [self.nativeExpressBannerView loadAdData];
}

#pragma mark BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"nativeExpressBannerAdViewDidLoad");
    
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    NSLog(@"nativeExpressAdFailToLoad with error %@", error.description);
    [self.delegate customEventBanner:self didFailAd:error];
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"nativeExpressBannerAdViewRenderSuccess");
    [self.delegate customEventBanner:self didReceiveAd:bannerAdView];
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    NSLog(@"nativeExpressBannerAdViewRenderFail");
    [self.delegate customEventBanner:self didFailAd:error];
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"nativeExpressBannerAdViewWillBecomVisible");
    [self.delegate customEventBannerWillPresentModal:self];
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"nativeExpressBannerAdViewDidClick");
    [self.delegate customEventBannerWasClicked:self];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    NSLog(@"nativeExpressBannerAdView dislikeWithReason");
    [self.delegate customEventBannerDidDismissModal:self];
}

#pragma mark - private method
- (NSString *)processParams:(NSString *)param size:(CGSize)size {
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
    NSString *placementID = json[BANNER_PANGLE_PLACEMENT_ID];
    return placementID;
}
@end
