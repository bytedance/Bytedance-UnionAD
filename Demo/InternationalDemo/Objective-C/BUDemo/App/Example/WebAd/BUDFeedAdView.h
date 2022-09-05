//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"
@class BUNativeAd;
@class BUNativeAdRelatedView;

@interface BUDFeedAdView : UIView

@property (nonatomic, strong, nullable) UIImageView *iv1;
@property (nonatomic, strong, nullable) UILabel *adTitleLabel;
@property (nonatomic, strong, nullable) UILabel *adDescriptionLabel;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;

- (void)loadAd:(BUNativeAd *)ad;

@end

@interface BUDFeedAdView (Builder)
+ (__kindof BUDFeedAdView *)adViewWithFrame:(CGRect)frame Ad:(BUNativeAd *)ad;
@end
#pragma clang diagnostic pop
