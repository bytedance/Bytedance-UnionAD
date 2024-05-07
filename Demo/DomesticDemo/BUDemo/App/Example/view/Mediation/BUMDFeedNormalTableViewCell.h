//
//  BUMDFeedNormalTableViewCell.h
//  BUDemo
//
//  Created by ByteDance on 2022/10/23.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMDFeedNormalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUMDFeedNormalTableViewCell : UITableViewCell
@property (nonatomic, strong) BUMDFeedNormalModel *model;
@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong, nullable) UILabel *titleLabel;
@property (nonatomic, strong, nullable) UILabel *inconLable;
@property (nonatomic, strong, nullable) UILabel *sourceLable;
@property (nonatomic, strong, nullable) UIImageView *closeIncon;
- (void)refreshUIWithModel:(BUMDFeedNormalModel *_Nonnull)model;
@end

@interface BUMDFeedNormalTitleTableViewCell : BUMDFeedNormalTableViewCell

@end

@interface BUMDFeedNormalTitleImgTableViewCell : BUMDFeedNormalTableViewCell
@property (nonatomic, strong, nullable) UIImageView *img;
@end

@interface BUMDFeedNormalBigImgTableViewCell : BUMDFeedNormalTableViewCell
@property (nonatomic, strong, nullable) UIImageView *bigImg;
@end

@interface BUMDFeedNormalthreeImgsableViewCell : BUMDFeedNormalTableViewCell
@property (nonatomic, strong, nullable) UIImageView *img1;
@property (nonatomic, strong, nullable) UIImageView *img2;
@property (nonatomic, strong, nullable) UIImageView *img3;
@end

NS_ASSUME_NONNULL_END

