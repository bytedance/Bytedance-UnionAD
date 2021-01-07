//
//  BUDFeedNativeTableViewCell.h
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/8/3.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAd.h>

@interface BUDFeedNativeTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *customview;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *urlButton;
@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) BUNativeAd *nativeAd;

@end
