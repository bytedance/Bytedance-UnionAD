//
//  BUDMopubNativeAdView.h
//  BUDemo
//
//  Created by liudonghui on 2020/1/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mopub-ios-sdk/MPNativeAdRendering.h>
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDMopubNativeAdView : UIView <MPNativeAdRendering>
/// propertyof mopub need
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *mainTextLabel;
@property (strong, nonatomic) UILabel *callToActionLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UIImageView *privacyInformationIconImageView;
@property (strong, nonatomic) UIView *videoView; // only for video ads

/// property for bytedance
@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;
@property (nonatomic, strong) BUNativeAd *nativeAd;

+ (CGFloat)cellHeightWithModel:(MPNativeAd *_Nonnull)model width:(CGFloat)width;
- (void)layoutCustomAssetsWithProperties:(NSDictionary *)customProperties imageLoader:(MPNativeAdRenderingImageLoader *)imageLoader;
@end

NS_ASSUME_NONNULL_END
