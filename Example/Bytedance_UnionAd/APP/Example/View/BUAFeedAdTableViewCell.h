//
//  BUAFeedAdCell.h
//  BUAemo
//
//  Created by carlliu on 2017/7/27.
//  Copyright © 2017年 bytedance. All rights reserved.
//


#import "BUAActionAreaView.h"
#import <Foundation/Foundation.h>
#import <WMAdSDK/WMTableViewCell.h>
#import <WMAdSDK/WMVideoAdView.h>


@protocol BUAFeedCellProtocol <NSObject>
- (void)refreshUIWithModel:(id _Nonnull)model;
+ (CGFloat)cellHeightWithModel:(id _Nonnull)model width:(CGFloat)width;
@end


@interface BUAFeedAdBaseTableViewCell : WMTableViewCell <BUAFeedCellProtocol>
@property (nonatomic, strong, nullable) UIImageView *iv1;
@property (nonatomic, strong, nullable) UILabel *adTitleLabel;
@property (nonatomic, strong, nullable) UILabel *adDescriptionLabel;
- (void)buildupView;
@end

@interface BUAFeedAdLeftTableViewCell : BUAFeedAdBaseTableViewCell
@end

@interface BUAFeedAdLargeTableViewCell : BUAFeedAdBaseTableViewCell
@end

@interface BUAFeedVideoAdTableViewCell : BUAFeedAdBaseTableViewCell
/**
 WMPlayer View
 */
@property (nonatomic, strong, nullable) WMVideoAdView *videoAdView;
/**
 创意按钮，视频广告使用，需要主动添加到 View，并注册该 view 用于响应用户点击
 */
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@end

@interface BUAFeedAdGroupTableViewCell : BUAFeedAdBaseTableViewCell
@property (nonatomic, strong, nullable) UIImageView *iv2;
@property (nonatomic, strong, nullable) UIImageView *iv3;
@property (nonatomic, strong, nullable) BUAActionAreaView *actionView;
@end
