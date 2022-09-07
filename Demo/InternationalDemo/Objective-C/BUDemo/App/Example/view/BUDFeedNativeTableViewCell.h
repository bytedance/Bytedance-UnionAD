//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>

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
