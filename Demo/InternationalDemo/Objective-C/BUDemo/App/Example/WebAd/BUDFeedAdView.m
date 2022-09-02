//
// Created by bytedance on 2020/9/23.
// Copyright (c) 2020 makaiwen. All rights reserved.
//

#if __has_include(<BUWebAd/BUWebAd.h>)
#import "BUDFeedAdView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <BUAdSDK/BUMaterialMeta.h>
#import <BUWebAd/BUWebAd.h>
//#import <BUWebAd/BUWebAdViewHandler.h>
//#import "BUWebAdViewHandler.h"

static CGFloat const margin = 15;
static CGSize const logoSize = { 15, 15 };
static UIEdgeInsets const padding = { 10, 15, 10, 15 };

@interface BUDFeedAdView ()

@end

@class BUDFeedAdLeftView, BUDFeedAdLargeView, BUDFeedAdGroupView, BUDFeedAdSquareImgView, BUDFeedAdVideoView;

@implementation BUDFeedAdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    self.iv1 = [[UIImageView alloc] init];
    self.iv1.userInteractionEnabled = YES;
    [self addSubview:self.iv1];

    self.adTitleLabel = [UILabel new];
    self.adTitleLabel.numberOfLines = 0;
    self.adTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.adTitleLabel];

    self.adDescriptionLabel = [UILabel new];
    self.adDescriptionLabel.numberOfLines = 0;
    self.adDescriptionLabel.textColor = [UIColor colorWithWhite:0.333 alpha:1];
    self.adDescriptionLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.adDescriptionLabel];

    // Add custom button
    [self addSubview:self.customBtn];

    self.relatedView = [[BUNativeAdRelatedView alloc] init];
}

- (void)layoutUI {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)loadAd:(BUNativeAd *)ad {
    self.nativeAd = ad;
    [self.relatedView refreshData:ad];
    [self.iv1 addSubview:self.relatedView.logoImageView];
    [self addSubview:self.relatedView.dislikeButton];
    [self addSubview:self.relatedView.adLabel];
}

- (UIButton *)customBtn {
    if (!_customBtn) {
        _customBtn = [[UIButton alloc] init];
        [_customBtn setTitle:@"click" forState:UIControlStateNormal];
        [_customBtn setTitleColor:[UIColor colorWithRed:0.278 green:0.561 blue:0.824 alpha:1] forState:UIControlStateNormal];
        _customBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _customBtn;
}

#pragma mark - getter && setter
+ (NSAttributedString *)titleAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    NSMutableParagraphStyle *titleStrStyle = [[NSMutableParagraphStyle alloc] init];
    titleStrStyle.lineSpacing = 5;
    titleStrStyle.alignment = NSTextAlignmentJustified;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:17.f];
    attribute[NSParagraphStyleAttributeName] = titleStrStyle;
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

+ (NSAttributedString *)subtitleAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    attribute[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

@end

@interface BUDFeedAdLeftView : BUDFeedAdView
@end

@implementation BUDFeedAdLeftView

- (void)loadAd:(BUNativeAd *)model {
    [super loadAd:model];

    BUImage *image = model.data.imageAry.firstObject;

    [self.iv1 sd_setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];

    NSAttributedString *attributedText = [self.class titleAttributeText:model.data.AdTitle];
    self.adTitleLabel.attributedText = attributedText;

    self.adDescriptionLabel.attributedText = [self.class subtitleAttributeText:model.data.AdDescription];

    [self layoutUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    BUNativeAd *model = self.nativeAd;

    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = imageWidth * (image.height / image.width);
    CGFloat imageX = width - margin - imageWidth;
    self.iv1.frame = CGRectMake(imageX, y, imageWidth, imageHeight);

    self.relatedView.logoImageView.frame = CGRectMake(imageWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);

    CGFloat maxTitleWidth =  contentWidth - imageWidth - margin;
    NSAttributedString *attributedText = self.adTitleLabel.attributedText;
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(maxTitleWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y, maxTitleWidth, MIN(titleSize.height, imageHeight));

    y += imageHeight;
    y += 5;

    CGFloat originInfoX = padding.left;
    [self.relatedView.adLabel sizeToFit];
    self.relatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.relatedView.adLabel.frame.size.width + 10, 14);
    originInfoX += 24;
    originInfoX += 5;

    CGFloat dislikeX = width - 20 - padding.right;
    self.relatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);

    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX, y, maxInfoWidth, 20);
}

@end

@interface BUDFeedAdLargeView : BUDFeedAdView

@end

@implementation BUDFeedAdLargeView

- (void)loadAd:(BUNativeAd *)model {
    [super loadAd:model];

    NSAttributedString *attributedText = [self.class titleAttributeText:model.data.AdTitle];
    self.adTitleLabel.attributedText = attributedText;

    BUImage *image = model.data.imageAry.firstObject;
    [self.iv1 sd_setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];

    self.adDescriptionLabel.attributedText = [self.class subtitleAttributeText:model.data.AdDescription];
    [self layoutUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BUNativeAd *model = self.nativeAd;

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = self.adTitleLabel.attributedText;
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);

    y += titleSize.height;
    y += 5;

    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    self.iv1.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    self.relatedView.logoImageView.frame = CGRectMake(contentWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);

    y += imageHeight;
    y += 10;

    CGFloat originInfoX = padding.left;
    [self.relatedView.adLabel sizeToFit];
    self.relatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.relatedView.adLabel.frame.size.width + 10, 14);
    originInfoX += 24;
    originInfoX += 10;

    CGFloat dislikeX = width - 20 - padding.right;
    self.relatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);

    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10 - 100;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX, y, maxInfoWidth, 20);

    CGFloat customBtnWidth = 100;
    self.customBtn.frame = CGRectMake(dislikeX - customBtnWidth, y, customBtnWidth, 20);
}

@end

//方图

@interface BUDFeedAdSquareImgView : BUDFeedAdView
@end
@implementation BUDFeedAdSquareImgView

- (void)loadAd:(BUNativeAd *)model {
    [super loadAd:model];

    NSAttributedString *attributedText = [self.class titleAttributeText:model.data.AdTitle];
    self.adTitleLabel.attributedText = attributedText;

    BUImage *image = model.data.imageAry.firstObject;
    [self.iv1 sd_setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];

    self.adDescriptionLabel.attributedText = [self.class subtitleAttributeText:model.data.AdDescription];
    [self layoutUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = self.adTitleLabel.attributedText;
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);

    y += titleSize.height;
    y += 5;

    const CGFloat imageHeight = contentWidth;
    self.iv1.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    self.relatedView.logoImageView.frame = CGRectMake(contentWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);

    y += imageHeight;
    y += 10;

    CGFloat originInfoX = padding.left;
    self.relatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);
    originInfoX += 24;
    originInfoX += 10;

    CGFloat dislikeX = width - 20 - padding.right;
    self.relatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);

    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10 - 100;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX, y, maxInfoWidth, 20);

    CGFloat customBtnWidth = 100;
    self.customBtn.frame = CGRectMake(dislikeX - customBtnWidth, y, customBtnWidth, 20);
}

@end

@interface BUDFeedAdGroupView : BUDFeedAdView
@property (nonatomic, strong, nullable) UIImageView *iv2;
@property (nonatomic, strong, nullable) UIImageView *iv3;
@end

@implementation BUDFeedAdGroupView

- (void)buildupView {
    [super buildupView];
    self.iv1 = [UIImageView new];
    [self addSubview:self.iv1];

    self.iv2 = [UIImageView new];
    [self addSubview:self.iv2];

    self.iv3 = [UIImageView new];
    [self addSubview:self.iv3];
    [self.iv3 addSubview:self.relatedView.logoImageView];
}

- (void)registerViewForInteraction:(UIView *)view {
    if (self.nativeAd.data.interactionType) {
        [self.nativeAd registerContainer:self withClickableViews:nil];
    } else {
        [self.nativeAd registerContainer:self withClickableViews:nil];
    }
}

- (void)loadAd:(BUNativeAd *)model {
    [super loadAd:model];

    NSAttributedString *attributedText = [self.class titleAttributeText:model.data.AdTitle];
    self.adTitleLabel.attributedText = attributedText;

    [self.iv1 sd_setImageWithURL:[NSURL URLWithString:model.data.imageAry[0].imageURL] placeholderImage:nil];
    [self.iv2 sd_setImageWithURL:[NSURL URLWithString:model.data.imageAry[1].imageURL] placeholderImage:nil];
    [self.iv3 sd_setImageWithURL:[NSURL URLWithString:model.data.imageAry[2].imageURL] placeholderImage:nil];

    self.adDescriptionLabel.attributedText = [self.class subtitleAttributeText:model.data.AdDescription];
    [self layoutUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    BUNativeAd *model = self.nativeAd;

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = self.adTitleLabel.attributedText;
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);

    y += titleSize.height;
    y += 5;

    CGFloat imageWidth = (contentWidth - 5 * 2) / 3;
    BUImage *image = model.data.imageAry[0];
    const CGFloat imageHeight = imageWidth * (image.height / image.width);

    CGFloat originX = padding.left;
    self.iv1.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    originX += (imageWidth + 5);
    self.iv2.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    originX += (imageWidth + 5);
    self.iv3.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    self.relatedView.logoImageView.frame = CGRectMake(imageWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);

    y += imageHeight;
    y += 10;

    // info
    CGFloat originInfoX = padding.left;
    [self.relatedView.adLabel sizeToFit];
    self.relatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.relatedView.adLabel.frame.size.width + 10, 14);
    originInfoX += 24;
    originInfoX += 15;

    CGFloat dislikeX = width - 20 - padding.right;
    self.relatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);

    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX, y, maxInfoWidth, 20);
}

@end

//方视频

@interface BUDFeedAdSquareVideoView : BUDFeedAdView
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation BUDFeedAdSquareVideoView

- (void)buildupView {
    [super buildupView];
    // Video ad did not use iv1, temporarily hidden...
    self.iv1.hidden = YES;

    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1];
    [self insertSubview:self.bgView atIndex:0];
}

- (void)loadAd:(BUNativeAd *)model {
    [super loadAd:model];

    if (!self.relatedView.videoAdView.superview) {
        [self addSubview:self.relatedView.videoAdView];
        [self addSubview:self.relatedView.logoImageView];
    }

    if (self.creativeButton && !self.creativeButton.superview) {
        [self addSubview:self.creativeButton];
    }

    NSAttributedString *attributedText = [self.class titleAttributeText:model.data.AdTitle];
    self.adTitleLabel.attributedText = attributedText;

    // 广告展位图

    // creativeButton
    [self.creativeButton setTitle:self.nativeAd.data.buttonText forState:UIControlStateNormal];

    // source
    self.adDescriptionLabel.text = model.data.AdDescription;
    [self layoutUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BUNativeAd *model = self.nativeAd;

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = self.adTitleLabel.attributedText;
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);

    y += titleSize.height;
    y += 5;

    // 广告展位图
//    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth;

    self.relatedView.videoAdView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    self.relatedView.logoImageView.frame = CGRectMake(CGRectGetMaxX(self.relatedView.videoAdView.frame) - logoSize.width, CGRectGetMaxY(self.relatedView.videoAdView.frame) - logoSize.height, logoSize.width, logoSize.height);
    y += imageHeight;

    self.bgView.frame = CGRectMake(padding.left, y, contentWidth, self.creativeButton.frame.size.height + 20);

    y += 10;

    // creativeButton
    [self.creativeButton sizeToFit];
    CGSize buttonSize = self.creativeButton.frame.size;
    self.creativeButton.frame = CGRectMake(contentWidth - buttonSize.width + 10, y, buttonSize.width, buttonSize.height);

    // source
    CGFloat maxInfoWidth = width - 2 * margin - buttonSize.width - 10 - 15;
    self.adDescriptionLabel.frame = CGRectMake(padding.left + 5, y + 2, maxInfoWidth, 20);
//    self.adDescriptionLabel.attributedText = [self.class subtitleAttributeText:model.data.AdDescription];
    self.adDescriptionLabel.text = model.data.AdDescription;
    y += buttonSize.height;

    y += 15;
    CGFloat originInfoX = padding.left;
    self.relatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);

    CGFloat dislikeX = width - 20 - padding.right;
    self.relatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
}

- (UIButton *)creativeButton
{
    if (!_creativeButton) {
        _creativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creativeButton setTitle:@"Download" forState:UIControlStateNormal];
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

@interface BUDFeedAdVideoView : BUDFeedAdView
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation BUDFeedAdVideoView

- (void)buildupView {
    [super buildupView];
    // Video ad did not use iv1, temporarily hidden...
    self.iv1.hidden = YES;

    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1];
    [self insertSubview:self.bgView atIndex:0];
}

- (void)loadAd:(BUNativeAd *)model {
    [super loadAd:model];

    if (!self.relatedView.videoAdView.superview) {
        [self addSubview:self.relatedView.videoAdView];
        [self addSubview:self.relatedView.logoImageView];
    }

    if (self.creativeButton && !self.creativeButton.superview) {
        [self addSubview:self.creativeButton];
    }

    NSAttributedString *attributedText = [self.class titleAttributeText:model.data.AdTitle];
    self.adTitleLabel.attributedText = attributedText;

    // creativeButton
    [self.creativeButton setTitle:self.nativeAd.data.buttonText forState:UIControlStateNormal];

    // source
    self.adDescriptionLabel.text = model.data.AdDescription;
    [self layoutUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BUNativeAd *model = self.nativeAd;

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = self.adTitleLabel.attributedText;
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);

    y += titleSize.height;
    y += 5;

    // 广告展位图
    // 对齐安卓，使用视频分辨率确定视频宽高比例
    CGFloat resloution = (model.data.videoResolutionHeight * 1.0) / (model.data.videoResolutionWidth * 1.0);
    CGFloat imageHeight = contentWidth * resloution;
    CGFloat videoWidth = contentWidth;
    if (imageHeight > self.bounds.size.height - 30) {
        imageHeight = self.bounds.size.height - 30;
        videoWidth = imageHeight / resloution;
    }
    self.relatedView.videoAdView.frame = CGRectMake(padding.left, y, videoWidth, imageHeight);
    self.relatedView.logoImageView.frame = CGRectMake(CGRectGetMaxX(self.relatedView.videoAdView.frame) - logoSize.width, CGRectGetMaxY(self.relatedView.videoAdView.frame) - logoSize.height, logoSize.width, logoSize.height);
    y += imageHeight;

    self.bgView.frame = CGRectMake(padding.left, y, contentWidth, self.creativeButton.frame.size.height + 20);

    y += 10;

    // creativeButton
    [self.creativeButton sizeToFit];
    CGSize buttonSize = self.creativeButton.frame.size;
    self.creativeButton.frame = CGRectMake(contentWidth - buttonSize.width + 10, y, buttonSize.width, buttonSize.height);

    // source
    CGFloat maxInfoWidth = width - 2 * margin - buttonSize.width - 10 - 15;
    self.adDescriptionLabel.frame = CGRectMake(padding.left + 5, y + 2, maxInfoWidth, 20);
//    self.adDescriptionLabel.attributedText = [self.class subtitleAttributeText:model.data.AdDescription];
    y += buttonSize.height;

    y += 15;
    CGFloat originInfoX = padding.left;
    [self.relatedView.adLabel sizeToFit];
    self.relatedView.adLabel.frame = CGRectMake(originInfoX, y + 3, self.relatedView.adLabel.frame.size.width + 10, 14);
    CGFloat dislikeX = width - 20 - padding.right;
    self.relatedView.dislikeButton.frame = CGRectMake(dislikeX, y, 20, 20);
}

- (UIButton *)creativeButton
{
    if (!_creativeButton) {
        _creativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creativeButton setTitle:@"Download" forState:UIControlStateNormal];
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

@implementation BUDFeedAdView (Builder)

+ (__kindof BUDFeedAdView *)adViewWithFrame:(CGRect)frame Ad:(BUNativeAd *)ad {
    BUDFeedAdView *view = nil;
    BOOL isVideo = NO;
    if (ad.data.imageMode == BUFeedADModeSmallImage) {
        view = [[BUDFeedAdLeftView alloc] initWithFrame:frame];
    } else if (ad.data.imageMode == BUFeedADModeLargeImage || ad.data.imageMode == BUFeedADModeImagePortrait) {
        view = [[BUDFeedAdLargeView alloc] initWithFrame:frame];
    } else if (ad.data.imageMode == BUFeedADModeGroupImage) {
        view = [[BUDFeedAdGroupView alloc] initWithFrame:frame];
    } else if (ad.data.imageMode == BUFeedVideoAdModeImage || ad.data.imageMode ==  BUFeedVideoAdModePortrait) {
        view = [[BUDFeedAdVideoView alloc] initWithFrame:frame];
        isVideo = YES;
    } else if (ad.data.imageMode == BUFeedADModeSquareImage) {
        view = [[BUDFeedAdSquareImgView alloc] initWithFrame:frame];
    } else if (ad.data.imageMode == BUFeedADModeSquareVideo) {
        view = [[BUDFeedAdSquareVideoView alloc] initWithFrame:frame];
        isVideo = YES;
    }
    [view loadAd:ad];
    BUInteractionType type = ad.data.interactionType;
    if (isVideo) {
        if (ad.data.imageMode == BUFeedVideoAdModeImage || ad.data.imageMode ==  BUFeedVideoAdModePortrait) {
            BUDFeedAdVideoView *videoView = (BUDFeedAdVideoView *)view;
//            videoView.nativeAdRelatedView.videoAdView.delegate = self;
            [ad registerContainer:videoView withClickableViews:@[videoView.creativeButton]];
        } else if (ad.data.imageMode == BUFeedADModeSquareVideo) {
            BUDFeedAdSquareVideoView *videoView = (BUDFeedAdSquareVideoView *)view;
//            videoView.relativeView.videoAdView.delegate = self;
            [ad registerContainer:videoView withClickableViews:@[videoView.creativeButton]];
        }
    } else {
        if (type == BUInteractionTypeDownload) {
            [view.customBtn setTitle:@"Download" forState:UIControlStateNormal];
            [ad registerContainer:view withClickableViews:@[view.customBtn]];
        } else if (type == BUInteractionTypePhone) {
            [view.customBtn setTitle:@"Phone Call" forState:UIControlStateNormal];
            [ad registerContainer:view withClickableViews:@[view.customBtn]];
        } else if (type == BUInteractionTypeURL) {
            [view.customBtn setTitle:@"External pull up" forState:UIControlStateNormal];
            [ad registerContainer:view withClickableViews:@[view.customBtn]];
        } else if (type == BUInteractionTypePage) {
            [view.customBtn setTitle:@"Internal pull up" forState:UIControlStateNormal];
            [ad registerContainer:view withClickableViews:@[view.customBtn]];
        } else {
            [view.customBtn setTitle:@"No Click" forState:UIControlStateNormal];
        }
    }
    return view;
}

@end
#endif
