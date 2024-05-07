//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDAdmob_NativeFeedCustomEventAdapter.h"
#import <GoogleMobileAds/GADCustomEventNativeAd.h>
#import <GoogleMobileAds/GADMultipleAdsAdLoaderOptions.h>
#import <PAGAdSDK/PAGLNativeAd.h>
#import <PAGAdSDK/PAGLNativeAdDelegate.h>
#import <PAGAdSDK/PAGLNativeAdRelatedView.h>
#import <PAGAdSDK/PAGNativeRequest.h>
#import "BUDAdmobTool.h"
#import <PAGAdSDK/PAGLMaterialMeta.h>
#import <PAGAdSDK/PAGLImage.h>


@interface BUDAdmob_NativeFeedCustomEventAdapter ()<GADMediationNativeAd,PAGLNativeAdDelegate>

@property (nonatomic, strong) PAGLNativeAd *nativeAd;
@property (nonatomic, strong) PAGLNativeAdRelatedView *relatedView;
//@property (nonatomic, strong) BUDNativeView *nativeView;
@property (nonatomic, assign) BOOL disableImageLoading;
@property (nonatomic, weak) UIViewController *root;
@property (nonatomic, weak, nullable) id<GADMediationNativeAdEventDelegate> delegate;


@end


@implementation BUDAdmob_NativeFeedCustomEventAdapter

NSString *const FEED_PLACEMENT_ID = @"placementid";

- (void)loadNativeAdForAdConfiguration:(GADMediationNativeAdConfiguration *)adConfiguration completionHandler:(GADMediationNativeLoadCompletionHandler)completionHandler {
    NSDictionary<NSString *, id> *credentials = adConfiguration.credentials.settings;
    NSString *placementID = credentials[@"parameter"];
    
    if (placementID != nil){
        [BUDAdmobTool setExtData];
        __weak typeof(self) weakSelf = self;
        __weak typeof(PAGLNativeAdRelatedView) *weakView = [self getRelatedView];
        [PAGLNativeAd loadAdWithSlotID:placementID
                               request:[PAGNativeRequest request]
                     completionHandler:^(PAGLNativeAd * _Nullable nativeAd, NSError * _Nullable error) {

            if (!weakSelf) {
                return;
            }
            __strong typeof(weakSelf) self = weakSelf;

            if (error) {
                NSLog(@"native ad load fail : %@", error);
                return;
            }
            self.nativeAd = nativeAd;
            
            [weakView refreshWithNativeAd:nativeAd];
            nativeAd.rootViewController = adConfiguration.topViewController;
            nativeAd.delegate = self;
            self.delegate = completionHandler(self, nil);
        }];
    } else {
        NSLog(@"no placement ID for requesting.");
        [self.delegate didFailToPresentWithError:[NSError errorWithDomain:@"error placementID" code:-1 userInfo:nil]];
        [self _logWithSEL:_cmd msg:@"called didFailToPresentWithError:code:userInfo:"];
    }
}

- (NSArray<GADNativeAdImage *> *)images {
    return nil;
}

- (GADNativeAdImage *)icon {
    if (self.nativeAd.data.icon && self.nativeAd.data.icon.imageURL){
        GADNativeAdImage *icon = [self imageWithUrlString:self.nativeAd.data.icon.imageURL];
        return icon;
    }
    return nil;
}

- (GADNativeAdImage *)imageWithUrlString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData: data];
    return [[GADNativeAdImage alloc] initWithImage:image];
}

- (PAGLNativeAdRelatedView *)getRelatedView {
    if (!_relatedView) {
        _relatedView = [[PAGLNativeAdRelatedView alloc] init];
    }
    return _relatedView;
}

- (UIView *)mediaView {
    return (UIView *)[self getRelatedView].mediaView;
}

- (BOOL)handlesUserClicks {
    return NO;
}

- (BOOL)handlesUserImpressions {
    return NO;
}

- (BOOL)hasVideoContent {
    return YES;
}

- (NSString *)headline {
    if (self.nativeAd && self.nativeAd.data) {
        return self.nativeAd.data.AdTitle;
    }
    return nil;
}

- (NSString *)body {
    if (self.nativeAd && self.nativeAd.data) {
        return self.nativeAd.data.AdDescription;
    }
    return nil;
}


- (NSString *)callToAction {
    if (self.nativeAd && self.nativeAd.data) {
        return self.nativeAd.data.buttonText;
    }
    return nil;
}

- (NSDecimalNumber *)starRating {
    return nil;
}

- (NSString *)price {
    return nil;
}

- (NSString *)store {
    return nil;
}

- (UIView *)adChoicesView {
    return self.relatedView.logoADImageView;
}

- (NSString *)advertiser {
    if (self.nativeAd && self.nativeAd.data) {
        return self.nativeAd.data.AdTitle;
    }
    return nil;
}

- (NSDictionary *)extraAssets {
    return nil;
}

- (void)didRenderInView:(nonnull UIView *)view
    clickableAssetViews:(nonnull NSDictionary<GADNativeAssetIdentifier, UIView *> *)clickableAssetViews
 nonclickableAssetViews:(nonnull NSDictionary<GADNativeAssetIdentifier, UIView *> *)nonclickableAssetViews
         viewController:(nonnull UIViewController *)viewController {
    if (self.nativeAd && view) {
        [self.nativeAd registerContainer:view withClickableViews:clickableAssetViews.allValues];
    }
}

- (void)adDidShow:(id<PAGAdProtocol>)ad {
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
    [self _logWithSEL:_cmd msg:@"called willPresentFullScreenView: and reportImpression:"];
}

- (void)adDidClick:(id<PAGAdProtocol>)ad {
    [self.delegate reportClick];
    [self _logWithSEL:_cmd msg:@"called reportClick:"];
}

- (void)adDidDismiss:(id<PAGAdProtocol>)ad {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    NSLog(@"BUDAdmob_NativeFeedCustomEventAdapter | %@ | %@", NSStringFromSelector(sel), msg);
}

@end
