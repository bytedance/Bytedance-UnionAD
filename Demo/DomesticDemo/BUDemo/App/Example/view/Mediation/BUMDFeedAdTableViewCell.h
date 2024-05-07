//
//  BUMDFeedAdTableViewCell.h
//  BUDemo
//
//  Created by ByteDance on 2022/10/23.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUNativeAd;
@class BUMDFeedAdBaseTableViewCell;

NS_ASSUME_NONNULL_BEGIN

typedef void (^CellClose)(NSInteger index, BUMDFeedAdBaseTableViewCell *cell);

@protocol BUMDFeedCellProtocol <NSObject>

@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong, nullable) BUNativeAd *nativeAdView;

- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model;
+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width;

@property (nonatomic, copy) CellClose cellClose;

@end

@interface BUMDFeedAdBaseTableViewCell : UITableViewCell <BUMDFeedCellProtocol>

@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong) UIButton *customBtn;

- (void)buildupView;

@end

@interface BUMDFeedAdLeftTableViewCell : BUMDFeedAdBaseTableViewCell
@end

@interface BUMDFeedAdLargeTableViewCell : BUMDFeedAdBaseTableViewCell
@end

@interface BUMDFeedVideoAdTableViewCell : BUMDFeedAdBaseTableViewCell
/**
 Creative button which is usede by video ad, need to actively add to the view, and register the view for user click.
 */
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@property (nonatomic, strong) UIView *bgView;

@end

@interface BUMDFeedAdGroupTableViewCell : BUMDFeedAdBaseTableViewCell

@property (nonatomic, strong, nullable) UIImageView *iv2;
@property (nonatomic, strong, nullable) UIImageView *iv3;

@end

NS_ASSUME_NONNULL_END

