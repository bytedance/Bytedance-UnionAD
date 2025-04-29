//
//  BUDFeedAdCell.h
//  BUDemo
//
//  Created by carlliu on 2017/7/27.
//  Copyright © 2017年 bytedance. All rights reserved.
//


#import "BUDActionAreaView.h"
#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class BUDFeedAdBaseTableViewCell;
@protocol BUDFeedCustomDislikeDelgate <NSObject>

- (void)feedCustomDislike:(BUDFeedAdBaseTableViewCell *)cell withNativeAd:(BUNativeAd *)nativeAd didSlected:(BUDislikeWords *)dislikeWord;

@end

@protocol BUDFeedCellProtocol <NSObject>

@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;

- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model;
+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width;

@property (nonatomic, weak) id<BUDFeedCustomDislikeDelgate> delegate;
@end


@interface BUDFeedAdBaseTableViewCell : UITableViewCell <BUDFeedCellProtocol>
@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong, nullable) UIImageView *iv1;
@property (nonatomic, strong, nullable) UILabel *adTitleLabel;
@property (nonatomic, strong, nullable) UILabel *infoLabel;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;
@property (nonatomic, strong) UIButton *customDislikeBtn;

@property (nonatomic, weak) id<BUDFeedCustomDislikeDelgate> delegate;

- (void)buildupView;
@end

@interface BUDFeedAdLeftTableViewCell : BUDFeedAdBaseTableViewCell
@end

@interface BUDFeedAdLargeTableViewCell : BUDFeedAdBaseTableViewCell
@end

//方图
@interface BUDFeedAdSquareImgTableViewCell : BUDFeedAdBaseTableViewCell
@end

//方视频
@interface BUDFeedSquareVideoAdTableViewCell : BUDFeedAdBaseTableViewCell
/**
 Creative button which is usede by video ad, need to actively add to the view, and register the view for user click.
 */
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@property (nonatomic, strong) UIView *bgView;
@end

@interface BUDFeedVideoAdTableViewCell : BUDFeedAdBaseTableViewCell
/**
 Creative button which is usede by video ad, need to actively add to the view, and register the view for user click.
 */
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@property (nonatomic, strong) UIView *bgView;
@end

@interface BUDFeedAdGroupTableViewCell : BUDFeedAdBaseTableViewCell
@property (nonatomic, strong, nullable) UIImageView *iv2;
@property (nonatomic, strong, nullable) UIImageView *iv3;
@property (nonatomic, strong, nullable) BUDActionAreaView *actionView;
@end
NS_ASSUME_NONNULL_END
