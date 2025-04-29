//
//  BUMDFeedAdTableViewCell.m
//  BUDemo
//
//  Created by ByteDance on 2022/10/23.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDFeedAdTableViewCell.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "BUDFeedStyleHelper.h"

static CGFloat const margin = 15;
static CGSize const logoSize = { 15, 15 };
static UIEdgeInsets const padding = { 10, 15, 10, 15 };

@implementation BUMDFeedAdBaseTableViewCell

@synthesize cellClose;
@synthesize nativeAdView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;

    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, swidth - margin * 2, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);

    [self.nativeAdView.mediation.canvasView addSubview:self.separatorLine];

    self.nativeAdView.mediation.canvasView.imageView.userInteractionEnabled = YES;

    self.nativeAdView.mediation.canvasView.titleLabel.numberOfLines = 0;
    self.nativeAdView.mediation.canvasView.titleLabel.textAlignment = NSTextAlignmentLeft;

    self.nativeAdView.mediation.canvasView.descLabel.numberOfLines = 0;
    self.nativeAdView.mediation.canvasView.descLabel.textColor = BUD_RGB(0x55, 0x55, 0x55);
    self.nativeAdView.mediation.canvasView.descLabel.font = [UIFont systemFontOfSize:14];

    // Add custom button
    [self.nativeAdView.mediation.canvasView addSubview:self.customBtn];

    [self.contentView addSubview:self.nativeAdView.mediation.canvasView];

    [self addAccessibilityIdentifier];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    return 0;
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [self.nativeAdView.mediation.canvasView removeFromSuperview];
    self.nativeAdView = model;

    //dislikeBtn关闭事件需要自定义
    [self.nativeAdView.mediation.canvasView.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    self.nativeAdView.mediation.canvasView.dislikeBtn.userInteractionEnabled = YES;
    self.nativeAdView.mediation.canvasView.dislikeBtn.tag = self.tag;
    [self.nativeAdView.mediation.canvasView.dislikeBtn addTarget:self action:@selector(closeCell:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeCell:(UIButton *)btn {
    !self.cellClose ? : self.cellClose(btn.tag, self);
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

#pragma <---Utils--->
- (UILabel *)otherInfoLblWithFrame:(CGRect)frame data:(BUMaterialMeta *)data {
    UILabel *otherInfoLbl = [[UILabel alloc] initWithFrame:frame];
    NSString *price = @"";
    NSString *score = @"";
    NSString *source = @"";
    // 返回不为空表示物料可用
    if (data.mediation.appPrice.length > 0) {
        price = data.mediation.appPrice;
    }
    if (data.score > 0) {
        score = [NSString stringWithFormat:@"评分:%ld", data.score];
    }
    if (self.nativeAdView.data.source.length > 0) {
        source = [NSString stringWithFormat:@"source:%@", data.source];
    }
    otherInfoLbl.text = [NSString stringWithFormat:@"%@ %@ %@",
                         price,
                         score,
                         source];
    otherInfoLbl.font = [UIFont systemFontOfSize:10.f];
    
    return otherInfoLbl;
}

#pragma mark addAccessibilityIdentifier
- (void)addAccessibilityIdentifier {
    self.customBtn.accessibilityIdentifier = @"feed_button";
}

@end

@implementation BUMDFeedAdLeftTableViewCell

- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model {
    [super refreshUIWithModel:model];

    self.nativeAdView.mediation.canvasView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = imageWidth * (image.height / image.width);
    CGFloat imageX = width - margin - imageWidth;
    self.nativeAdView.mediation.canvasView.imageView.frame = CGRectMake(imageX, y, imageWidth, imageHeight);
    [self.nativeAdView.mediation.canvasView.imageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];

    CGFloat maxTitleWidth =  contentWidth - imageWidth - margin;
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(maxTitleWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.nativeAdView.mediation.canvasView.titleLabel.frame = CGRectMake(padding.left, y, maxTitleWidth, MIN(titleSize.height, imageHeight));
    self.nativeAdView.mediation.canvasView.titleLabel.attributedText = attributedText;

    y += imageHeight;
    y += 5;

    // 广告标识
    if (model.data.mediation.adLogo.imageURL) {
        UIImageView *adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(width-20, y, 20, 20)];
        [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
    }

    CGFloat dislikeX = width - 24 - padding.right;
    // 物料信息不包含关闭按钮需要自己实现
    if (!self.nativeAdView.mediation.canvasView.dislikeBtn) {
        [self.nativeAdView.mediation.canvasView.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    }
    self.nativeAdView.mediation.canvasView.dislikeBtn.frame = CGRectMake(dislikeX, y, 24, 20);

    if (self.nativeAdView.mediation.canvasView.hasSupportActionBtn) {
        CGFloat customBtnWidth = 100;
        self.nativeAdView.mediation.canvasView.callToActionBtn.frame = CGRectMake(dislikeX - customBtnWidth - 5, y, customBtnWidth, 20);
        NSString *btnTxt = @"Click";
        if (self.nativeAdView.data.buttonText.length > 0) {
            btnTxt = self.nativeAdView.data.buttonText;
        }
        [self.nativeAdView.mediation.canvasView.callToActionBtn setTitle:btnTxt forState:UIControlStateNormal];
        self.nativeAdView.mediation.canvasView.callToActionBtn.backgroundColor = [UIColor redColor];
    }

    // sdk标识
    UIImageView *adLogoV;
    if (model.data.mediation.adLogo) {
        adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(padding.left, y, 0, 0)];
        // 优先使用image
        if (model.data.mediation.adLogo.mediation.image) {
            [adLogoV setImage:model.data.mediation.adLogo.mediation.image];
        } else if (model.data.mediation.adLogo.imageURL) {
            // image不存在使用url
            [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        }
        
        if (adLogoV.image) {
            CGFloat width = 20;
            CGFloat height = 20;
            if (model.data.mediation.adLogo.width && model.data.mediation.adLogo.height) {
                height = width * model.data.mediation.adLogo.height/model.data.mediation.adLogo.width;
            }
            adLogoV.frame = CGRectMake(CGRectGetMinX(adLogoV.frame), CGRectGetMinY(adLogoV.frame),width, height);
            [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
        }
    }
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10 - 100;
    CGFloat originY = y;
    if (adLogoV) {
        originY = CGRectGetMinY(adLogoV.frame);
    }
    self.nativeAdView.mediation.canvasView.descLabel.frame = CGRectMake(padding.left, originY, maxInfoWidth, 20);
    self.nativeAdView.mediation.canvasView.descLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdSource];

    // 注册点击事件
    [self.nativeAdView registerContainer:model.mediation.canvasView withClickableViews:@[
         self.nativeAdView.mediation.canvasView.titleLabel,
         self.nativeAdView.mediation.canvasView.descLabel,
         self.nativeAdView.mediation.canvasView.imageView,
         self.nativeAdView.mediation.canvasView.mediaView,
         self.nativeAdView.mediation.canvasView.callToActionBtn
    ]];

    [self.contentView addSubview:self.nativeAdView.mediation.canvasView];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat contentWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    CGFloat height = padding.top + imageHeight + 10 + 20 + padding.bottom;

    return height;
}

@end

@implementation BUMDFeedAdLargeTableViewCell

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];

    self.nativeAdView.mediation.canvasView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.nativeAdView.mediation.canvasView.titleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);
    self.nativeAdView.mediation.canvasView.titleLabel.attributedText = attributedText;

    // 广告标识
    if (model.data.mediation.adLogo.imageURL) {
        UIImageView *adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(width-20, y, 20, 20)];
        [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
    }
    
    y += titleSize.height;
    y += 5;

    BUImage *image = model.data.imageAry.firstObject;
    CGFloat imageHeight = self.nativeAdView.mediation.canvasView.imageView.frame.size.height ? : 300;
    if (image) {
        imageHeight = contentWidth * (image.height / image.width);
        [self.nativeAdView.mediation.canvasView.imageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:image.mediation.image];
    }
    
    self.nativeAdView.mediation.canvasView.imageView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    self.nativeAdView.mediation.canvasView.iconImageView.frame = CGRectMake(contentWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);
//    if (self.nativeAdView.imageView && !self.nativeAdView.imageView.superview) {
//        [self.nativeAdView addSubview:self.nativeAdView.imageView];
//    }

    y += imageHeight;
    y += 10;

    CGFloat originInfoX = padding.left;
    CGFloat dislikeX = width - 24 - padding.right;
    // 物料信息不包含关闭按钮需要自己实现
    [self.nativeAdView.mediation.canvasView.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    self.nativeAdView.mediation.canvasView.dislikeBtn.frame = CGRectMake(dislikeX, y, 24, 20);

    // sdk标识
    UIImageView *adLogoV;
    if (model.data.mediation.adLogo) {
        adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(padding.left, y, 0, 0)];
        // 优先使用image
        if (model.data.mediation.adLogo.mediation.image) {
            [adLogoV setImage:model.data.mediation.adLogo.mediation.image];
        } else if (model.data.mediation.adLogo.imageURL) {
            // image不存在使用url
            [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        }
        
        if (adLogoV.image) {
            CGFloat width = 20;
            CGFloat height = 20;
            if (model.data.mediation.adLogo.width && model.data.mediation.adLogo.height) {
                height = width * model.data.mediation.adLogo.height/model.data.mediation.adLogo.width;
            }
            adLogoV.frame = CGRectMake(CGRectGetMinX(adLogoV.frame), CGRectGetMinY(adLogoV.frame),width, height);
            [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
        }
    }
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10 - 100;
    CGFloat originY = y;
    if (adLogoV) {
        originY = CGRectGetMinY(adLogoV.frame);
    }
    self.nativeAdView.mediation.canvasView.descLabel.frame = CGRectMake(originInfoX+30, originY, maxInfoWidth, 20);
    self.nativeAdView.mediation.canvasView.descLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdSource];

    if (self.nativeAdView.mediation.canvasView.hasSupportActionBtn) {
        CGFloat customBtnWidth = 100;
        self.nativeAdView.mediation.canvasView.callToActionBtn.frame = CGRectMake(dislikeX - customBtnWidth - 5, y, customBtnWidth, 20);
        NSString *btnTxt = @"Click";
        if (self.nativeAdView.data.buttonText.length > 0) {
            btnTxt = self.nativeAdView.data.buttonText;
        }
        [self.nativeAdView.mediation.canvasView.callToActionBtn setTitle:btnTxt forState:UIControlStateNormal];
        self.nativeAdView.mediation.canvasView.callToActionBtn.backgroundColor = [UIColor redColor];
    }

    //物料里的price，score，source等信息;开发者可根据原始信息自定义表现形式
    CGRect frame = CGRectMake(padding.left, CGRectGetMaxY(self.nativeAdView.mediation.canvasView.descLabel.frame)-5, 260, 20);
    UILabel *otherInfoLbl = [self otherInfoLblWithFrame:frame data:self.nativeAdView.data];
    [self.nativeAdView.mediation.canvasView addSubview:otherInfoLbl];
    
    // 注册点击事件，注意对视图进行判空
    [self.nativeAdView registerContainer:self.nativeAdView.mediation.canvasView withClickableViews:@[
         self.nativeAdView.mediation.canvasView.titleLabel,
         self.nativeAdView.mediation.canvasView.descLabel,
         self.nativeAdView.mediation.canvasView.imageView,
         self.nativeAdView.mediation.canvasView.callToActionBtn
    ]];

    [self.contentView addSubview:self.nativeAdView.mediation.canvasView];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;

    BUImage *image = model.data.imageAry.firstObject;
    CGFloat imageHeight = 300;
    if (image.width != 0) {
        imageHeight = contentWidth * (image.height / image.width);
    }
    
    return padding.top + titleSize.height + 5 + imageHeight + 10 + 20 + padding.bottom;
}

@end

@implementation BUMDFeedAdGroupTableViewCell

- (void)buildupView {
    [super buildupView];

    self.iv2 = [UIImageView new];
    self.iv3 = [UIImageView new];
}

- (void)registerViewForInteraction:(UIView *)view {
//    [self.nativeAdView registerClickableViews:nil];
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];

    self.nativeAdView.mediation.canvasView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.nativeAdView.mediation.canvasView.titleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);
    self.nativeAdView.mediation.canvasView.titleLabel.attributedText = attributedText;

    // 广告标识
    if (model.data.mediation.adLogo.imageURL) {
        UIImageView *adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(width-20, y, 20, 20)];
        [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
    }
        
    y += titleSize.height;
    y += 5;

    CGFloat imageWidth = (contentWidth - 5 * 2) / 3;
    BUImage *image = model.data.imageAry[0];
    const CGFloat imageHeight = imageWidth * (image.height / image.width);

    CGFloat originX = padding.left;
    self.nativeAdView.mediation.canvasView.imageView.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    [self.nativeAdView.mediation.canvasView.imageView setImageWithURL:[NSURL URLWithString:model.data.imageAry[0].imageURL] placeholderImage:nil];

    if (model.data.imageAry.count > 1) {
        originX += (imageWidth + 5);
        self.iv2.frame = CGRectMake(originX, y, imageWidth, imageHeight);
        [self.iv2 setImageWithURL:[NSURL URLWithString:model.data.imageAry[1].imageURL] placeholderImage:nil];
    }

    if (model.data.imageAry.count > 2) {
        originX += (imageWidth + 5);
        self.iv3.frame = CGRectMake(originX, y, imageWidth, imageHeight);
        [self.iv3 setImageWithURL:[NSURL URLWithString:model.data.imageAry[2].imageURL] placeholderImage:nil];
    }

    self.nativeAdView.mediation.canvasView.iconImageView.frame = CGRectMake(imageWidth - logoSize.width, imageHeight - logoSize.height, logoSize.width, logoSize.height);

    [self.nativeAdView.mediation.canvasView addSubview:self.iv2];
    [self.nativeAdView.mediation.canvasView addSubview:self.iv3];

    y += imageHeight;
    y += 10;

    // info
    CGFloat originInfoX = padding.left;
    CGFloat dislikeX = width - 24 - padding.right;
    // 物料信息不包含关闭按钮需要自己实现
    if (!self.nativeAdView.mediation.canvasView.dislikeBtn) {
        [self.nativeAdView.mediation.canvasView.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    }
    self.nativeAdView.mediation.canvasView.dislikeBtn.frame = CGRectMake(dislikeX, y, 24, 20);

    if (self.nativeAdView.mediation.canvasView.hasSupportActionBtn) {
        CGFloat customBtnWidth = 100;
        self.nativeAdView.mediation.canvasView.callToActionBtn.frame = CGRectMake(dislikeX - customBtnWidth - 5, y, customBtnWidth, 20);
        NSString *btnTxt = @"Click";
        if (self.nativeAdView.data.buttonText.length > 0) {
            btnTxt = self.nativeAdView.data.buttonText;
        }
        [self.nativeAdView.mediation.canvasView.callToActionBtn setTitle:btnTxt forState:UIControlStateNormal];
        self.nativeAdView.mediation.canvasView.callToActionBtn.backgroundColor = [UIColor redColor];
    }

    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    // sdk标识
    UIImageView *adLogoV;
    if (model.data.mediation.adLogo) {
        adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(padding.left, y, 30, 20)];
        // 优先使用image
        if (model.data.mediation.adLogo.mediation.image) {
            [adLogoV setImage:model.data.mediation.adLogo.mediation.image];
        } else if (model.data.mediation.adLogo.imageURL) {
            // image不存在使用url
            [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        }
        if (adLogoV.image) {
            CGFloat width = 20;
            CGFloat height = 20;
            if (model.data.mediation.adLogo.width && model.data.mediation.adLogo.height) {
                height = width * model.data.mediation.adLogo.height/model.data.mediation.adLogo.width;
            }
            adLogoV.frame = CGRectMake(CGRectGetMinX(adLogoV.frame), CGRectGetMinY(adLogoV.frame),width, height);
            [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
        }
    }
    
    CGFloat originY = y;
    if (adLogoV) {
        originY = CGRectGetMinY(adLogoV.frame);
    }
    self.nativeAdView.mediation.canvasView.descLabel.frame = CGRectMake(originInfoX+30, originY, maxInfoWidth, 20);
    self.nativeAdView.mediation.canvasView.descLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdSource];

    //物料里的price，score，source等信息;开发者可根据原始信息自定义表现形式
    CGRect frame = CGRectMake(padding.left, CGRectGetMaxY(self.nativeAdView.mediation.canvasView.descLabel.frame)-5, 260, 20);
    UILabel *otherInfoLbl = [self otherInfoLblWithFrame:frame data:self.nativeAdView.data];
    [self.nativeAdView.mediation.canvasView addSubview:otherInfoLbl];
    
    // 注册点击事件
    NSMutableArray *clickableViews = [NSMutableArray array];
    if (self.nativeAdView.mediation.canvasView.titleLabel) [clickableViews addObject:self.nativeAdView.mediation.canvasView.titleLabel];
    if (self.nativeAdView.mediation.canvasView.descLabel) [clickableViews addObject:self.nativeAdView.mediation.canvasView.descLabel];
    if (self.nativeAdView.mediation.canvasView.imageView) [clickableViews addObject:self.nativeAdView.mediation.canvasView.imageView];
    if (self.nativeAdView.mediation.canvasView.mediaView) [clickableViews addObject:self.nativeAdView.mediation.canvasView.mediaView];
    if (self.nativeAdView.mediation.canvasView.callToActionBtn) [clickableViews addObject:self.nativeAdView.mediation.canvasView.callToActionBtn];
    if (self.iv2) [clickableViews addObject:self.iv2];
    if (self.iv3) [clickableViews addObject:self.iv3];
    [self.nativeAdView registerContainer:self.nativeAdView.mediation.canvasView withClickableViews:[clickableViews copy]];
    CGFloat height = CGRectGetMaxY(self.nativeAdView.mediation.canvasView.callToActionBtn.frame);
    if (height > 150) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height);
    } else {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), 150);
    }

    [self.contentView addSubview:self.nativeAdView.mediation.canvasView];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat height = padding.top;
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat contentWidth = (width - 2 * margin) / 3;
    CGFloat imageHeight = 300;
    if (image.width != 0) {
        imageHeight = contentWidth * (image.height / image.width);
    }
    height += 17 + 15 + imageHeight + 5 + 20;
    height += padding.bottom;
//    if (model.data.interactionType == BUInteractionTypeDownload) {
//        height += 28 +5;
//    }
    return height;
}

@end

@interface BUMDFeedVideoAdTableViewCell ()

@end

@implementation BUMDFeedVideoAdTableViewCell

- (void)buildupView {
    [super buildupView];
    // Video ad did not use iv1, temporarily hidden...

    self.bgView = [UIView new];
    self.bgView.backgroundColor = BUD_RGB(0xf5, 0xf5, 0xf5);
    [self.contentView insertSubview:self.bgView atIndex:0];
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];

    self.nativeAdView.mediation.canvasView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesFontLeading context:0].size;
    self.nativeAdView.mediation.canvasView.titleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);
    self.nativeAdView.mediation.canvasView.titleLabel.attributedText = attributedText;

    // 广告标识
    if (model.data.mediation.adLogo.imageURL) {
        UIImageView *adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(width-20, y, 20, 20)];
        [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
    }
    
    y += titleSize.height;
    y += 5;

    // 广告占位图
    BUImage *image = model.data.imageAry.firstObject;
    
    CGFloat imageHeight = CGRectGetHeight(self.nativeAdView.mediation.canvasView.frame);
    if (image.width > 0) {
        imageHeight = contentWidth * (image.height / image.width);
    }
    
    self.nativeAdView.mediation.canvasView.mediaView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    // !!!mediaView布局后h必须调用该方法
    [self.nativeAdView.mediation reSizeMediaView];

    y += imageHeight;

    if (self.nativeAdView.mediation.canvasView.hasSupportActionBtn) {
        // creativeButton
        NSString *btnTxt = @"Click";
        if (self.nativeAdView.data.buttonText.length > 0) {
            btnTxt = self.nativeAdView.data.buttonText;
        }
        [self.nativeAdView.mediation.canvasView.callToActionBtn setTitle:btnTxt forState:UIControlStateNormal];
        [self.nativeAdView.mediation.canvasView.callToActionBtn sizeToFit];
    }

    CGSize buttonSize = self.nativeAdView.mediation.canvasView.callToActionBtn.frame.size;

    // source
    CGFloat maxInfoWidth = width - 2 * margin - buttonSize.width - 10 - 15;

    // sdk标识
    UIImageView *adLogoV;
    if (model.data.mediation.adLogo) {
        adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(padding.left, y, 30, 20)];
        // 优先使用image
        if (model.data.mediation.adLogo.mediation.image) {
            [adLogoV setImage:model.data.mediation.adLogo.mediation.image];
        } else if (model.data.mediation.adLogo.imageURL) {
            // image不存在使用url
            [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        }
        if (adLogoV.image) {
            CGFloat width = 20;
            CGFloat height = 20;
            if (model.data.mediation.adLogo.width && model.data.mediation.adLogo.height) {
                height = width * model.data.mediation.adLogo.height/model.data.mediation.adLogo.width;
            }
            adLogoV.frame = CGRectMake(CGRectGetMinX(adLogoV.frame), CGRectGetMinY(adLogoV.frame),width, height);
            [self.nativeAdView.mediation.canvasView addSubview:adLogoV];
        }
    }
    
    CGFloat originY = y;
    if (adLogoV) {
        originY = CGRectGetMinY(adLogoV.frame);
    }
    self.nativeAdView.mediation.canvasView.descLabel.frame = CGRectMake(padding.left + 5 + CGRectGetWidth(adLogoV.frame), originY, maxInfoWidth, 20);
    self.nativeAdView.mediation.canvasView.descLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdSource];
    self.nativeAdView.mediation.canvasView.descLabel.text = model.data.AdSource;
    
    //物料里的price，score，source等信息;开发者可根据原始信息自定义表现形式
    CGRect frame = CGRectMake(padding.left, CGRectGetMaxY(self.nativeAdView.mediation.canvasView.descLabel.frame)-5, 260, 20);
    UILabel *otherInfoLbl = [self otherInfoLblWithFrame:frame data:self.nativeAdView.data];
    [self.nativeAdView.mediation.canvasView addSubview:otherInfoLbl];
    
    CGFloat dislikeX = width - 24 - padding.right;

    // 物料信息不包含关闭按钮需要自己实现
    if (!self.nativeAdView.mediation.canvasView.dislikeBtn) {
        [self.nativeAdView.mediation.canvasView.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    }
    
    if (y >= CGRectGetHeight(self.nativeAdView.mediation.canvasView.frame)) {
        y -= (y-CGRectGetHeight(self.nativeAdView.mediation.canvasView.frame)+20);
    }
    self.nativeAdView.mediation.canvasView.dislikeBtn.frame = CGRectMake(dislikeX, y, 24, 20);

    if (self.nativeAdView.mediation.canvasView.hasSupportActionBtn) {
        self.nativeAdView.mediation.canvasView.callToActionBtn.frame = CGRectMake(CGRectGetMinX(self.nativeAdView.mediation.canvasView.dislikeBtn.frame) - buttonSize.width - 10, y, buttonSize.width, buttonSize.height);
        self.nativeAdView.mediation.canvasView.callToActionBtn.backgroundColor = [UIColor redColor];
    }

    // 注册点击事件
    [self.nativeAdView registerContainer:self.nativeAdView.mediation.canvasView withClickableViews:@[
         self.nativeAdView.mediation.canvasView.titleLabel,
         self.nativeAdView.mediation.canvasView.descLabel,
         self.nativeAdView.mediation.canvasView.imageView,
         self.nativeAdView.mediation.canvasView.mediaView,
         self.nativeAdView.mediation.canvasView.callToActionBtn,
         otherInfoLbl,
    ]];

    [self.contentView addSubview:self.nativeAdView.mediation.canvasView];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];

    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;

    BUImage *image = model.data.imageAry.firstObject;
    CGFloat imageHeight = 0;
    if (image.width > 0) {
        imageHeight = contentWidth * (image.height / image.width);
    }
    
    return padding.top + titleSize.height + 10 + imageHeight + 15 + 20 + padding.bottom;
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

