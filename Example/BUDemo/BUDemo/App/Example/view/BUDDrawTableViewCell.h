//
//  BUDDrawAdTableViewCell.h
//  BUDemo
//
//  Created by 崔亚楠 on 2018/9/20.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>

@protocol BUDDrawCellProtocol <NSObject>
+ (CGFloat)cellHeight;
@end

@interface BUDDrawBaseTableViewCell : UITableViewCell<BUDDrawCellProtocol>
@property (nonatomic, strong, nullable) UILabel *titleLabel;
@property (nonatomic, strong, nullable) UILabel *descriptionLabel;
@end

@interface BUDDrawNormalTableViewCell : BUDDrawBaseTableViewCell<BUDDrawCellProtocol>
@property (nonatomic, assign) NSInteger videoId;
- (void)refreshUIAtIndex:(NSUInteger)index;
- (void)autoPlay;
- (void)pause;
@end

@interface BUDDrawAdTableViewCell : BUDDrawBaseTableViewCell<BUDDrawCellProtocol>
@property (nonatomic, strong) UIButton *creativeButton; //创意按钮
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;//相关的展示控件
- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model;
@end
