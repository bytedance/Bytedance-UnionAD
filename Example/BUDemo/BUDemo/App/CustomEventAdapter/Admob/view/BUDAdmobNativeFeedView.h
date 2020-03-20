//
//  BUDAdmobNativeFeedView.h
//  BUDemo
//
//  Created by liudonghui on 2020/1/17.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GADUnifiedNativeAd.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDAdmobNativeFeedView: UIView


// for both admob and BU Ad
@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong) UILabel *headlineView;
@property (nonatomic, strong) UILabel *bodyView;
@property (nonatomic, strong) UILabel *callToActionView;
@property (nonatomic ,strong) UIImageView *iconView;

// only for admob
@property (nonatomic, strong) GADUnifiedNativeAdView *gadView;
@property (nonatomic, strong) GADMediaView *mediaView;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) UIPickerView *dislikeReasonChoiceView;


/// for ByteDance Union content,  dislike button and register click
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;
@property (nonatomic, strong) UIImageView *mainImageViewForBU;

- (instancetype)initWithGADModel:(GADUnifiedNativeAd *)nativeAd;
- (void)buildupView;
+ (CGFloat)cellHeightWithModel:(GADUnifiedNativeAd *_Nonnull)model width:(CGFloat)width;

@end
NS_ASSUME_NONNULL_END
