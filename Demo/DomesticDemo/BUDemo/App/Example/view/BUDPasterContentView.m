//
//  BUDPasterContentView.m
//  BUDemo
//
//  Created by bytedance on 2020/10/28.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDPasterContentView.h"
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "BUDVideoView.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDFeedStyleHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BUDPasterContentView ()
// 自定义播放器
@property(nonatomic, strong) BUDVideoView *buCustomVideoView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *customBtn;

@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, strong) UILabel *adTitleLabel;

@property (nonatomic, strong) UILabel *adDescriptionLabel;
// SDK播放器
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;

@property (nonatomic, strong) BUNativeAd *nativeAd;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *creativeButton;

@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, assign) BOOL isCustomPlayer;
@end

static CGFloat const margin = 15;
static CGSize const logoSize = {15, 15};
static UIEdgeInsets const padding = {10, 15, 10, 15};
@implementation BUDPasterContentView

- (instancetype)initWithPasterContentWith:(BOOL)isCustomPlayer {
    if (self = [super init]) {
        self.isCustomPlayer = isCustomPlayer;
        [self setup];
    }
    return self;
}

- (void)addAccessibilityIdentifier {
    self.adTitleLabel.accessibilityIdentifier = @"feed_title";
    self.adDescriptionLabel.accessibilityIdentifier = @"feed_des";
    self.nativeAdRelatedView.dislikeButton.accessibilityIdentifier = @"dislike";
    self.customBtn.accessibilityIdentifier = @"feed_button";
}

- (void)setup {
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

    if (self.isCustomPlayer) {
        // 创建播放器视图
        BUDVideoView *videoView = [[BUDVideoView alloc] init];
        [self addSubview:videoView];
        self.buCustomVideoView = videoView;
    } else {    
        // 创建播放器视图
        [self addSubview:self.nativeAdRelatedView.videoAdView];
    }
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [self addSubview:imgV];
    self.adImageView = imgV;
}


- (void)refreshUIWithModel:(BUNativeAd *)model {
    self.nativeAd = model;
    [self addSubview:self.nativeAdRelatedView.dislikeButton];
    [self addSubview:self.nativeAdRelatedView.adLabel];
    [self.nativeAdRelatedView refreshData:model];

    if (self.isCustomPlayer) {
        NSString *url = model.data.videoUrl;
        [self.buCustomVideoView loadURL:[NSURL URLWithString:url]];
    } else {
        self.nativeAdRelatedView.videoAdView.materialMeta = model.data;
    }
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
    if (self.isCustomPlayer) {
        [self customPlayerLayoutWithY:y andWidth:contentWidth];
    } else {
        [self panglePlayerLayoutWithY:y andWidth:contentWidth];
    }
    
    const CGFloat imageHeight = contentWidth * (9.0 / 16.0);
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(padding.left + contentWidth - logoSize.width, y + imageHeight - logoSize.height, logoSize.width, logoSize.height);
    [self bringSubviewToFront:self.nativeAdRelatedView.logoImageView];
    
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

- (void)customPlayerLayoutWithY:(CGFloat )y andWidth:(CGFloat)contentWidth {
    // 广告展位图
    const CGFloat imageHeight = contentWidth * (9.0 / 16.0);
    if ([self isVideoAd]) { // video
        self.buCustomVideoView.hidden = NO;
        self.adImageView.hidden = YES;
        self.buCustomVideoView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    } else if ([self isImageAd]){ // image
        self.buCustomVideoView.hidden = YES;
        self.adImageView.hidden = NO;
        NSURL *url = [NSURL URLWithString:self.nativeAd.data.imageAry.firstObject.imageURL];
        [self.adImageView sd_setImageWithURL:url];
        self.adImageView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    }
}

- (void)panglePlayerLayoutWithY:(CGFloat)y andWidth:(CGFloat)contentWidth {
    // 广告展位图
    const CGFloat imageHeight = contentWidth * (9.0 / 16.0);
    if ([self isVideoAd]) {
        self.nativeAdRelatedView.videoAdView.hidden = NO;
        self.adImageView.hidden = YES;
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    } else if ([self isImageAd]) {
        self.nativeAdRelatedView.videoAdView.hidden = YES;
        self.adImageView.hidden = NO;
        NSURL *url = [NSURL URLWithString:self.nativeAd.data.imageAry.firstObject.imageURL];
        [self.adImageView sd_setImageWithURL:url];
        self.adImageView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    }
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
        _customBtn.hidden = YES;
    }
    return _customBtn;
}

- (id<BUVideoAdReportor>)videoAdReportor {
    return self.nativeAdRelatedView.videoAdReportor;
}

- (UIButton *)creativeBtn {
    return self.creativeButton;
}


- (BUDVideoView *)customVideoView {
    return self.buCustomVideoView;
}

- (BUVideoAdView *)pangleVideoView {
    if (self.nativeAdRelatedView) {
        return self.nativeAdRelatedView.videoAdView;
    }
    return nil;
}

- (BOOL)isVideoAd {
    BUNativeAd *ad = self.nativeAd;
    return ad.data.imageMode == BUFeedVideoAdModeImage || ad.data.imageMode == BUFeedVideoAdModePortrait || ad.data.imageMode == BUFeedADModeSquareVideo;
}

- (BOOL)isImageAd {
    BUNativeAd *ad = self.nativeAd;
    return ad.data.imageMode == BUFeedADModeGroupImage || ad.data.imageMode == BUFeedADModeLargeImage || ad.data.imageMode == BUFeedADModeSmallImage || ad.data.imageMode == BUFeedADModeSquareImage || ad.data.imageMode == BUFeedADModeImagePortrait;
}

- (NSTimeInterval)pasterViewTimerInterval {
    NSTimeInterval interval = 5.0;
    if ([self isVideoAd]) {
        interval = self.nativeAd.data.videoDuration;
    } else if ([self isImageAd]) {
        interval = self.nativeAd.data.imageAry.firstObject.duration;
    }
    // 时长为0时，默认5.0s
    return interval ?: 5.0;
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

@interface BUTimerWeakProxy ()
@property (nonatomic, weak) id timerTarget;
@end

@implementation BUTimerWeakProxy

- (instancetype)initTimerProxyWithTarget:(id)target {
    self.timerTarget = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initTimerProxyWithTarget:target];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([self.timerTarget respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.timerTarget];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (self.timerTarget) {
       return [self.timerTarget methodSignatureForSelector:sel];
    }
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
