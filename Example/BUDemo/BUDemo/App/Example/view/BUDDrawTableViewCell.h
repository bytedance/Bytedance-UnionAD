//
//  BUDDrawAdTableViewCell.h
//  BUDemo
//
//  Created by iCuiCui on 2018/9/20.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>
NS_ASSUME_NONNULL_BEGIN
@protocol BUDDrawCellProtocol <NSObject>
+ (CGFloat)cellHeight;
@end

@interface BUDDrawBaseTableViewCell : UITableViewCell<BUDDrawCellProtocol>
@property (nonatomic, strong, nullable) UILabel *titleLabel;
@property (nonatomic, strong, nullable) UILabel *descriptionLabel;
@property (nonatomic, strong, nullable) UIImageView *headImg;
@end

@interface BUDDrawNormalTableViewCell : BUDDrawBaseTableViewCell<BUDDrawCellProtocol>
@property (nonatomic, assign) NSInteger videoId;
- (void)refreshUIAtIndex:(NSUInteger)index;
@end

@interface BUDDrawAdTableViewCell : BUDDrawBaseTableViewCell<BUDDrawCellProtocol>
@property (nonatomic, strong) UIButton *creativeButton;
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;
- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model;
@end
NS_ASSUME_NONNULL_END
