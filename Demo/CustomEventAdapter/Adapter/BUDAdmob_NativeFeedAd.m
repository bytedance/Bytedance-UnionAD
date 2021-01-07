//
//  BUDAdmob_NativeFeedAd.m
//  AdmobAdapterDemo
//
//  Created by Gu Chan on 2020/07/06.
//  Copyright © 2020 GuChan. All rights reserved.
//

#import "BUDAdmob_NativeFeedAd.h"

static NSString *const BUDNativeAdTranslateKey = @"bu_nativeAd";

@interface BUDAdmob_NativeFeedAd ()

@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property(nonatomic, copy) NSArray<GADNativeAdImage *> *mappedImages;
@property(nonatomic, strong) GADNativeAdImage *mappedIcon;

@end

@implementation BUDAdmob_NativeFeedAd

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd disableImageLoading:(BOOL)disableImageLoading {
    self = [super init];
    if (self) {
        self.nativeAd = nativeAd;
        if (nativeAd && nativeAd.data) {
            BUMaterialMeta *data = nativeAd.data;
            // video view
            if (
                data.imageMode == BUFeedVideoAdModeImage ||
                data.imageMode == BUFeedVideoAdModePortrait ||
                data.imageMode == BUFeedADModeSquareVideo
                ){
                self.relatedView = [[BUNativeAdRelatedView alloc] init];
                self.relatedView.videoAdView.hidden = NO;
                [self.relatedView refreshData:nativeAd];
            }
            // main image of the ad
            if (data.imageAry && data.imageAry.count && data.imageAry[0].imageURL != nil){
                GADNativeAdImage *adImage = [[GADNativeAdImage alloc]initWithURL:[NSURL URLWithString:data.imageAry[0].imageURL] scale:[UIScreen mainScreen].scale];
                self.mappedImages = @[adImage];
            }
            
            // icon image of the ad
            if (data.icon && data.icon.imageURL != nil){
                GADNativeAdImage *iconImage = [[GADNativeAdImage alloc] initWithURL:[NSURL URLWithString:self.nativeAd.data.icon.imageURL] scale:[UIScreen mainScreen].scale];
                self.mappedIcon = iconImage;
            }
        }
    }
    return self;
}

- (UIImage *)loadImage:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData: data];
    return image;
}


#pragma mark - getter methods
- (BOOL)hasVideoContent {

    if (
        self.nativeAd && self.nativeAd.data &&
        (self.nativeAd.data.imageMode == BUFeedVideoAdModeImage ||
        self.nativeAd.data.imageMode == BUFeedVideoAdModePortrait ||
        self.nativeAd.data.imageMode == BUFeedADModeSquareVideo)
        ){
        return YES;
    }
    return NO;
}

- (nullable UIView *)mediaView {
    if (self.relatedView) {
        UIImageView *logoView = self.relatedView.logoADImageView;
        logoView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.relatedView.videoAdView addSubview:logoView];
        [self.relatedView.videoAdView bringSubviewToFront:logoView];
        [self.relatedView.videoAdView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[logoView(40)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logoView)]];
        [self.relatedView.videoAdView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[logoView(15)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logoView)]];
        return self.relatedView.videoAdView;
    }
    return nil;
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
    if (self.nativeAd && self.nativeAd.data) {
        return [[NSDecimalNumber alloc] initWithInteger:self.nativeAd.data.score];
    }
    return nil;
}

- (NSString *)advertiser {
    if (self.nativeAd && self.nativeAd.data) {
        return self.nativeAd.data.source;
    }
    return nil;
}

- (GADNativeAdImage *)icon {
    
    return self.mappedIcon;
}

- (NSArray *)images {
    return self.mappedImages;
}

- (NSDictionary *)extraAssets {
    if (self.nativeAd) {
        return @{BUDNativeAdTranslateKey:self.nativeAd};
    }
    return nil;
}

- (NSString *)price {
    return nil;
}

- (NSString *)store {
    return nil;
}

- (CGFloat)mediaContentAspectRatio {
    if (self.nativeAd &&
        self.nativeAd.data &&
        self.nativeAd.data.imageAry &&
        self.nativeAd.data.imageAry.count &&
        self.nativeAd.data.imageAry[0].height
        ) {
        return self.nativeAd.data.imageAry[0].width / (self.nativeAd.data.imageAry[0].height + 1e-4);
    }
    return 0.0f;
}


- (nullable UIView *)adChoicesView {
    return nil;
}


- (void)didRenderInView:(nonnull UIView *)view
    clickableAssetViews:
(nonnull NSDictionary<GADUnifiedNativeAssetIdentifier, UIView *> *)clickableAssetViews
 nonclickableAssetViews:
(nonnull NSDictionary<GADUnifiedNativeAssetIdentifier, UIView *> *)nonclickableAssetViews
         viewController:(nonnull UIViewController *)viewController {
    if (self.nativeAd && view) {
        [self.nativeAd registerContainer:view withClickableViews:@[view]];
    }
}


@end
