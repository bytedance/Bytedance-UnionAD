//
//  PangleNativeAdView.h
//  BUDemo
//
//  Created by wangyanlin on 2020/5/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mopub-ios-sdk/MPNativeAdRendering.h>

NS_ASSUME_NONNULL_BEGIN

@interface PangleNativeAdView : UIView <MPNativeAdRendering>
/// propertyof mopub need
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *mainTextLabel;
@property (strong, nonatomic) UILabel *callToActionLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UIImageView *privacyInformationIconImageView;
@property (strong, nonatomic) UIView *videoView; // only for video ads

@end

NS_ASSUME_NONNULL_END
