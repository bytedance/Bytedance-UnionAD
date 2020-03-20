//
//  BUDAdmob_nativeAdModel.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/5.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_nativeAdModel.h"
#import <BUAdSDK/BUNativeAd.h>
#import "BUDMacros.h"

@interface BUDAdmob_nativeAdModel ()
@end

@implementation BUDAdmob_nativeAdModel

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd {
    self = [super init];
    if (self) {
        self.nativeAd = nativeAd;
    }
    return self;
}

- (GADNativeAdImage *)buImageToGADImage:(BUImage *)buImage {
    NSURL *url = [NSURL URLWithString:buImage.imageURL];
    GADNativeAdImage *gadImage = [[GADNativeAdImage alloc] initWithURL:url scale: buImage.width / (buImage.height + 1e-4)];
    return gadImage;
}

#pragma mark - getter methods
- (NSString *)headline {
    return self.nativeAd.data.AdTitle;
}

- (NSString *)body {
    return self.nativeAd.data.AdDescription;
}

- (NSString *)callToAction {
    return self.nativeAd.data.buttonText;
}

- (NSDecimalNumber *)starRating {
    return [[NSDecimalNumber alloc] initWithInteger:self.nativeAd.data.score];
}

- (NSString *)advertiser {
    return self.nativeAd.data.source;
}

- (GADNativeAdImage *)icon {
    return [self buImageToGADImage:self.nativeAd.data.icon];
}

- (NSArray *)images {
     NSMutableArray *imgTemp = [[NSMutableArray alloc] initWithCapacity:self.nativeAd.data.imageAry.count];
    for (BUImage *img in self.nativeAd.data.imageAry) {
        [imgTemp addObject:[self buImageToGADImage:img]];
    }
    return [imgTemp copy];
}

- (NSDictionary *)extraAssets {
    return @{BUDNativeAdTranslateKey:self.nativeAd};
}

- (NSString *)price {
    return @"Unknown";
}

- (NSString *)store {
    return @"Unknown";
}

@end
