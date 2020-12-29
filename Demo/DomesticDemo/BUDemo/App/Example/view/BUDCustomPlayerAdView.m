//
//  BUDCustomPlayerAdView.m
//  BUDemo
//
//  Created by bytedance on 2020/8/18.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "BUDCustomPlayerAdView.h"
#import "BUDVideoView.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDFeedStyleHelper.h"

static CGFloat const margin = 15;
static CGSize const logoSize = {15, 15};
static UIEdgeInsets const padding = {10, 15, 10, 15};

@interface BUDCustomPlayerAdView ()

@property(nonatomic, strong) BUDVideoView *videoView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIButton *customBtn;

@property(nonatomic, strong) UIView *separatorLine;

@property(nonatomic, strong) UILabel *adTitleLabel;

@property(nonatomic, strong) UILabel *adDescriptionLabel;

@property(nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;

@property(nonatomic, strong) BUNativeAd *nativeAd;

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UIButton *creativeButton;

@end

@implementation BUDCustomPlayerAdView

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self buildUpView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUpView];
    }
    return self;
}

- (void)buildUpView {
    CGFloat sWidth = [[UIScreen mainScreen] bounds].size.width;

    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, sWidth - margin * 2, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);
    [self addSubview:self.separatorLine];

    self.adTitleLabel = [UILabel new];
    self.adTitleLabel.numberOfLines = 0;
    self.adTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.adTitleLabel];

    self.adDescriptionLabel = [UILabel new];
    self.adDescriptionLabel.numberOfLines = 0;
    self.adDescriptionLabel.textColor = BUD_RGB(0x55, 0x55, 0x55);
    self.adDescriptionLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.adDescriptionLabel];

    // Add custom button
    [self addSubview:self.customBtn];
    self.nativeAdRelatedView = [[BUNativeAdRelatedView alloc] init];
    [self addAccessibilityIdentifier];

    self.bgView = [UIView new];
    self.bgView.backgroundColor = BUD_RGB(0xf5, 0xf5, 0xf5);
    [self insertSubview:self.bgView atIndex:0];

    // 创建播放器视图
    BUDVideoView *videoView = [[BUDVideoView alloc] init];
    [self addSubview:videoView];
    self.videoView = videoView;
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    self.nativeAd = model;
    [self addSubview:self.nativeAdRelatedView.dislikeButton];
    [self addSubview:self.nativeAdRelatedView.adLabel];
    [self.nativeAdRelatedView refreshData:model];

    NSString *url = model.data.videoUrl;
    [self.videoView loadURL:[NSURL URLWithString:url]];
    [self addSubview:self.nativeAdRelatedView.logoImageView];

    if (self.creativeButton && !self.creativeButton.superview) {
        [self addSubview:self.creativeButton];
    }

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;

    y += titleSize.height;
    y += 5;

    // 广告展位图
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);

    self.videoView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(CGRectGetMaxX(self.videoView.frame) - logoSize.width, CGRectGetMaxY(self.videoView.frame) - logoSize.height, logoSize.width, logoSize.height);
    y += imageHeight;

    self.bgView.frame = CGRectMake(padding.left, y, contentWidth, self.creativeButton.frame.size.height + 20);

    y += 10;

    // creativeButton
    [self.creativeButton setTitle:self.nativeAd.data.buttonText forState:UIControlStateNormal];
    [self.creativeButton sizeToFit];
    CGSize buttonSize = self.creativeButton.frame.size;
    self.creativeButton.frame = CGRectMake(contentWidth - buttonSize.width + 10, y, buttonSize.width, buttonSize.height);

    // source
    CGFloat maxInfoWidth = width - 2 * margin - buttonSize.width - 10 - 15;
    self.adDescriptionLabel.frame = CGRectMake(padding.left + 5, y + 2, maxInfoWidth, 20);
    self.adDescriptionLabel.text = model.data.AdDescription;
    y += buttonSize.height;

    y += 15;
    CGFloat originInfoX = padding.left;
    [self.nativeAdRelatedView.adLabel sizeToFit];
    self.nativeAdRelatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.nativeAdRelatedView.adLabel.frame.size.width + 10, 14);
    CGFloat dislikeX = width - 24 - padding.right;
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 24, 20);
}


#pragma mark addAccessibilityIdentifier

- (void)addAccessibilityIdentifier {
    self.adTitleLabel.accessibilityIdentifier = @"feed_title";
    self.adDescriptionLabel.accessibilityIdentifier = @"feed_des";
    self.nativeAdRelatedView.dislikeButton.accessibilityIdentifier = @"dislike";
    self.customBtn.accessibilityIdentifier = @"feed_button";
}

#pragma mark - override

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = self.frame.size.width;
    CGFloat height = [[self class] heightWithModel:self.nativeAd width:width];
    return CGSizeMake(width, height);
}

#pragma mark - getter & setter

- (UIButton *)creativeButton {
    if (!_creativeButton) {
        _creativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creativeButton setTitle:[NSString localizedStringForKey:ClickDownload] forState:UIControlStateNormal];
        [_creativeButton setContentEdgeInsets:UIEdgeInsetsMake(4.0, 8.0, 4.0, 8.0)];
        [_creativeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.565 blue:0.843 alpha:1] forState:UIControlStateNormal];
        _creativeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_creativeButton sizeToFit];
        _creativeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _creativeButton.clipsToBounds = YES;
        [_creativeButton.layer setBorderColor:[UIColor colorWithRed:0.165 green:0.565 blue:0.843 alpha:1].CGColor];
        [_creativeButton.layer setBorderWidth:1];
        [_creativeButton.layer setCornerRadius:6];
        [_creativeButton.layer setShadowRadius:3];
        _creativeButton.accessibilityIdentifier = @"feed_button";
    }
    return _creativeButton;
}

- (UIButton *)customBtn {
    if (!_customBtn) {
        _customBtn = [[UIButton alloc] init];
        [_customBtn setTitle:[NSString localizedStringForKey:CustomClick] forState:UIControlStateNormal];
        [_customBtn setTitleColor:BUD_RGB(0x47, 0x8f, 0xd2) forState:UIControlStateNormal];
        _customBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _customBtn;
}

- (id<BUVideoAdReportor>)videoAdReportor {
    return self.nativeAdRelatedView.videoAdReportor;
}

#pragma mark - private

+ (CGFloat)heightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    return padding.top + titleSize.height + 10 + imageHeight + 15 + 20 + padding.bottom + 28;
}

@end
