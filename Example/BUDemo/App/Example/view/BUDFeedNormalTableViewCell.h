//
//  BUDFeedNormalTableViewCell.h
//  BUDemo
//
//  Created by iCuiCui on 2018/10/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUDFeedNormalModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BUDFeedNormalTableViewCell : UITableViewCell
@property (nonatomic, strong) BUDFeedNormalModel *model;
@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong, nullable) UILabel *titleLabel;
@property (nonatomic, strong, nullable) UILabel *inconLable;
@property (nonatomic, strong, nullable) UILabel *sourceLable;
@property (nonatomic, strong, nullable) UIImageView *closeIncon;
- (void)refreshUIWithModel:(BUDFeedNormalModel *_Nonnull)model;
@end

@interface BUDFeedNormalTitleTableViewCell : BUDFeedNormalTableViewCell

@end

@interface BUDFeedNormalTitleImgTableViewCell : BUDFeedNormalTableViewCell
@property (nonatomic, strong, nullable) UIImageView *img;
@end

@interface BUDFeedNormalBigImgTableViewCell : BUDFeedNormalTableViewCell
@property (nonatomic, strong, nullable) UIImageView *bigImg;
@end

@interface BUDFeedNormalthreeImgsableViewCell : BUDFeedNormalTableViewCell
@property (nonatomic, strong, nullable) UIImageView *img1;
@property (nonatomic, strong, nullable) UIImageView *img2;
@property (nonatomic, strong, nullable) UIImageView *img3;
@end
NS_ASSUME_NONNULL_END
