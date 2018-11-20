//
//  BUDFeedAdCell.h
//  BUDemo
//
//  Created by carlliu on 2017/7/27.
//  Copyright © 2017年 bytedance. All rights reserved.
//


#import "BUDActionAreaView.h"
#import <Foundation/Foundation.h>
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>


@protocol BUDFeedCellProtocol <NSObject>

@property (nonatomic, strong) UIButton *customBtn; // 自定义按钮
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView; // 添加相关的展示控件

- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model;
+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width;
@end


@interface BUDFeedAdBaseTableViewCell : UITableViewCell <BUDFeedCellProtocol>
@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong, nullable) UIImageView *iv1;
@property (nonatomic, strong, nullable) UILabel *adTitleLabel;
@property (nonatomic, strong, nullable) UILabel *adDescriptionLabel;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) UIButton *customBtn; // 自定义按钮
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;

- (void)buildupView;
@end

@interface BUDFeedAdLeftTableViewCell : BUDFeedAdBaseTableViewCell
@end

@interface BUDFeedAdLargeTableViewCell : BUDFeedAdBaseTableViewCell
@end

@interface BUDFeedVideoAdTableViewCell : BUDFeedAdBaseTableViewCell
/**
 创意按钮，视频广告使用，需要主动添加到 View，并注册该 view 用于响应用户点击
 */
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@property (nonatomic, strong) UIView *bgView;
@end

@interface BUDFeedAdGroupTableViewCell : BUDFeedAdBaseTableViewCell
@property (nonatomic, strong, nullable) UIImageView *iv2;
@property (nonatomic, strong, nullable) UIImageView *iv3;
@property (nonatomic, strong, nullable) BUDActionAreaView *actionView;
@end
