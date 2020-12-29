//
//  BUDFeedAdCell.m
//  BUDemo
//
//  Created by carlliu on 2017/7/27.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDFeedAdTableViewCell.h"

#import "UIImageView+AFNetworking.h"
#import "BUDFeedStyleHelper.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDConfigModel.h"

static CGFloat const margin = 15;
static CGSize const logoSize = {15, 15};
static UIEdgeInsets const padding = {10, 15, 10, 15};

@implementation BUDFeedAdBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, swidth-margin*2, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);
    [self.contentView addSubview:self.separatorLine];
    
    self.iv1 = [[UIImageView alloc] init];
    self.iv1.userInteractionEnabled = YES;
    [self.contentView addSubview:self.iv1];
    
    self.adTitleLabel = [UILabel new];
    self.adTitleLabel.numberOfLines = 0;
    self.adTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.adTitleLabel];
    
    self.adDescriptionLabel = [UILabel new];
    self.adDescriptionLabel.numberOfLines = 0;
    self.adDescriptionLabel.textColor = BUD_RGB(0x55, 0x55, 0x55);
    self.adDescriptionLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.adDescriptionLabel];
    
    // Add custom button
    [self.contentView addSubview:self.customBtn];
    
    self.nativeAdRelatedView = [[BUNativeAdRelatedView alloc] init];
    
    [self addAccessibilityIdentifier];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    return 0;
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    self.nativeAd = model;
    [self.iv1 addSubview:self.nativeAdRelatedView.logoImageView];
    [self.contentView addSubview:self.nativeAdRelatedView.dislikeButton];
    [self.contentView addSubview:self.nativeAdRelatedView.adLabel];
    [self.nativeAdRelatedView refreshData:model];

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

#pragma mark addAccessibilityIdentifier
- (void)addAccessibilityIdentifier {
    self.adTitleLabel.accessibilityIdentifier = @"feed_title";
    self.adDescriptionLabel.accessibilityIdentifier = @"feed_des";
    self.nativeAdRelatedView.dislikeButton.accessibilityIdentifier = @"dislike";
    self.customBtn.accessibilityIdentifier = @"feed_button";
    self.iv1.accessibilityIdentifier = @"feed_view";
}

@end

@implementation BUDFeedAdLeftTableViewCell

- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = imageWidth * (image.height / image.width);
    CGFloat imageX = width - margin - imageWidth;
    self.iv1.frame = CGRectMake(imageX, y, imageWidth, imageHeight);
    [self.iv1 setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(imageWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);
    
    CGFloat maxTitleWidth =  contentWidth - imageWidth - margin;
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(maxTitleWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , maxTitleWidth, MIN(titleSize.height, imageHeight));
    self.adTitleLabel.attributedText = attributedText;
    
    y += imageHeight;
    y += 5;
    
    CGFloat originInfoX = padding.left;
    [self.nativeAdRelatedView.adLabel sizeToFit];
    self.nativeAdRelatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.nativeAdRelatedView.adLabel.frame.size.width + 10, 14);
    originInfoX += 24;
    originInfoX += 5;
    
    CGFloat dislikeX = width - 20 - padding.right;
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdDescription];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat contentWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    return padding.top + imageHeight + 10 + 20 + padding.bottom;
}

@end

@implementation BUDFeedAdLargeTableViewCell

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    self.iv1.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    [self.iv1 setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(contentWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);
    
    y += imageHeight;
    y += 10;
    
    CGFloat originInfoX = padding.left;
    [self.nativeAdRelatedView.adLabel sizeToFit];
    self.nativeAdRelatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.nativeAdRelatedView.adLabel.frame.size.width + 10, 14);
    originInfoX += 24;
    originInfoX += 10;
    
    CGFloat dislikeX = width - 20 - padding.right;
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10 - 100;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdDescription];
    
    CGFloat customBtnWidth = 100;
    self.customBtn.frame = CGRectMake(dislikeX - customBtnWidth, y, customBtnWidth, 20);
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    return padding.top + titleSize.height + 5+ imageHeight + 10 + 20 + padding.bottom;
}


@end

//方图
@implementation BUDFeedAdSquareImgTableViewCell

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth;
    self.iv1.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    [self.iv1 setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(contentWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);
    
    y += imageHeight;
    y += 10;
    
    CGFloat originInfoX = padding.left;
    self.nativeAdRelatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);
    originInfoX += 24;
    originInfoX += 10;
    
    CGFloat dislikeX = width - 20 - padding.right;
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10 - 100;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdDescription];
    
    CGFloat customBtnWidth = 100;
    self.customBtn.frame = CGRectMake(dislikeX - customBtnWidth, y, customBtnWidth, 20);
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;

    return padding.top + titleSize.height + 5+ contentWidth + 10 + 20 + padding.bottom;
}


@end

@implementation BUDFeedAdGroupTableViewCell

- (void)buildupView {
    [super buildupView];
    self.iv1 = [UIImageView new];
    [self addSubview:self.iv1];
    
    self.iv2 = [UIImageView new];
    [self addSubview:self.iv2];
    self.iv3 = [UIImageView new];
    [self addSubview:self.iv3];
    [self.iv3 addSubview:self.nativeAdRelatedView.logoImageView];
    
//    self.actionView = [BUDActionAreaView new];
    
    [self addSubview:self.actionView];
}

- (void)registerViewForInteraction:(UIView *)view {
    if (self.nativeAd.data.interactionType) {
        [self.nativeAd registerContainer:self.contentView withClickableViews:@[self.actionView.actionButton]];
    } else {
        [self.nativeAd registerContainer:self.contentView withClickableViews:nil];
    }
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    CGFloat imageWidth = (contentWidth - 5 * 2) / 3;
    BUImage *image = model.data.imageAry[0];
    const CGFloat imageHeight = imageWidth * (image.height / image.width);
    
    CGFloat originX = padding.left;
    self.iv1.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    [self.iv1 setImageWithURL:[NSURL URLWithString: model.data.imageAry[0].imageURL] placeholderImage:nil];
    originX += (imageWidth + 5);
    self.iv2.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    [self.iv2 setImageWithURL:[NSURL URLWithString: model.data.imageAry[1].imageURL] placeholderImage:nil];
    originX += (imageWidth + 5);
    self.iv3.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    [self.iv3 setImageWithURL:[NSURL URLWithString: model.data.imageAry[2].imageURL] placeholderImage:nil];
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(imageWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);
    
    y += imageHeight;
    y += 10;
    
    // action
//    if (model.data.interactionType == BUInteractionTypeDownload) {
//        [self.actionView configWitModel:model.data];
//        self.actionView.frame = CGRectMake(padding.left, y, contentWidth, 28);
//        y += 28;
//        y += 5;
//    }
    // info
    CGFloat originInfoX = padding.left;
    [self.nativeAdRelatedView.adLabel sizeToFit];
    self.nativeAdRelatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.nativeAdRelatedView.adLabel.frame.size.width + 10, 14);
    originInfoX += 24;
    originInfoX += 15;
    
    CGFloat dislikeX = width - 20 - padding.right;
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdDescription];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat height = padding.top;
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat contentWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    height += 17 + 15+ imageHeight + 5 + 20;
    height += padding.bottom;
//    if (model.data.interactionType == BUInteractionTypeDownload) {
//        height += 28 +5;
//    }
    return height;
}

@end

//方视频
@implementation BUDFeedSquareVideoAdTableViewCell

- (void)buildupView {
    [super buildupView];
    // Video ad did not use iv1, temporarily hidden...
    self.iv1.hidden = YES;
    
    self.bgView = [UIView new];
    self.bgView.backgroundColor = BUD_RGB(0xf5, 0xf5, 0xf5);
    [self.contentView insertSubview:self.bgView atIndex:0];
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];
    
    if (!self.nativeAdRelatedView.videoAdView.superview) {
        [self.contentView addSubview:self.nativeAdRelatedView.videoAdView];
        [self.contentView addSubview:self.nativeAdRelatedView.logoImageView];
    }
    
    if (self.creativeButton && !self.creativeButton.superview) {
        [self.contentView addSubview:self.creativeButton];
    }
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    // 广告展位图
//    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth;
    
    self.nativeAdRelatedView.videoAdView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(CGRectGetMaxX(self.nativeAdRelatedView.videoAdView.frame) - logoSize.width, CGRectGetMaxY(self.nativeAdRelatedView.videoAdView.frame) - logoSize.height, logoSize.width, logoSize.height);
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
    self.adDescriptionLabel.frame = CGRectMake(padding.left + 5 , y+2 , maxInfoWidth, 20);
//    self.adDescriptionLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdDescription];
    self.adDescriptionLabel.text = model.data.AdDescription;
    y += buttonSize.height;
    
    y += 15;
    CGFloat originInfoX = padding.left;
    self.nativeAdRelatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);
    
    CGFloat dislikeX = width - 20 - padding.right;
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
//    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth;
    return padding.top + titleSize.height + 10+ imageHeight + 15 + 20 + padding.bottom + 28;
}

- (UIButton *)creativeButton
{
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

@end

@interface BUDFeedVideoAdTableViewCell ()

@end

@implementation BUDFeedVideoAdTableViewCell

- (void)buildupView {
    [super buildupView];
    // Video ad did not use iv1, temporarily hidden...
    self.iv1.hidden = YES;
    
    self.bgView = [UIView new];
    self.bgView.backgroundColor = BUD_RGB(0xf5, 0xf5, 0xf5);
    [self.contentView insertSubview:self.bgView atIndex:0];
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];
    
    if (!self.nativeAdRelatedView.videoAdView.superview) {
        [self.contentView addSubview:self.nativeAdRelatedView.videoAdView];
        [self.contentView addSubview:self.nativeAdRelatedView.logoImageView];
    }
    
    if (self.creativeButton && !self.creativeButton.superview) {
        [self.contentView addSubview:self.creativeButton];
    }
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    // 广告展位图
    // 对齐安卓，使用视频分辨率确定视频宽高比例
    CGFloat resloution = (model.data.videoResolutionHeight * 1.0) / (model.data.videoResolutionWidth * 1.0);
    const CGFloat imageHeight = contentWidth * resloution;
    
    self.nativeAdRelatedView.videoAdView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(CGRectGetMaxX(self.nativeAdRelatedView.videoAdView.frame) - logoSize.width, CGRectGetMaxY(self.nativeAdRelatedView.videoAdView.frame) - logoSize.height, logoSize.width, logoSize.height);
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
    self.adDescriptionLabel.frame = CGRectMake(padding.left + 5 , y+2 , maxInfoWidth, 20);
//    self.adDescriptionLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdDescription];
    self.adDescriptionLabel.text = model.data.AdDescription;
    y += buttonSize.height;
    
    y += 15;
    CGFloat originInfoX = padding.left;
    [self.nativeAdRelatedView.adLabel sizeToFit];
    self.nativeAdRelatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.nativeAdRelatedView.adLabel.frame.size.width + 10, 14);
    CGFloat dislikeX = width - 20 - padding.right;
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    // 对齐安卓，使用视频分辨率确定视频宽高比例
    CGFloat resloution = (model.data.videoResolutionHeight * 1.0) / (model.data.videoResolutionWidth * 1.0);
    const CGFloat imageHeight = contentWidth * resloution;
    return padding.top + titleSize.height + 10+ imageHeight + 15 + 20 + padding.bottom + 28;
}

- (UIButton *)creativeButton
{
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

@end
