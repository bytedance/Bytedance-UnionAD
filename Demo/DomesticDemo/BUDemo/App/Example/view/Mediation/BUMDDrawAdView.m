//
//  BUMDDrawAdView.m
//  BUMDemo
//
//  Created by ByteDance on 2022/10/30.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDDrawAdView.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDFeedStyleHelper.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

static CGFloat const margin = 15;
static CGSize const logoSize = { 15, 15 };
static UIEdgeInsets const padding = { 10, 15, 10, 15 };

@implementation BUMDDrawAdView
@synthesize cellClose;
- (void)buildupView {
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, swidth - margin * 2, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);

    [self.drawAdView.mediation.canvasView addSubview:self.separatorLine];

    self.drawAdView.mediation.canvasView.imageView.userInteractionEnabled = YES;

    self.drawAdView.mediation.canvasView.titleLabel.numberOfLines = 0;
    self.drawAdView.mediation.canvasView.titleLabel.textAlignment = NSTextAlignmentLeft;

    self.drawAdView.mediation.canvasView.descLabel.numberOfLines = 0;
    self.drawAdView.mediation.canvasView.descLabel.textColor = BUD_RGB(0x55, 0x55, 0x55);
    self.drawAdView.mediation.canvasView.descLabel.font = [UIFont systemFontOfSize:14];

    // Add custom button
    [self.drawAdView.mediation.canvasView addSubview:self.customBtn];

    [self addSubview:self.drawAdView.mediation.canvasView];

    [self addAccessibilityIdentifier];
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    return 0;
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [self.drawAdView.mediation.canvasView removeFromSuperview];
    self.drawAdView = model;

    //dislikeBtn关闭事件需要自定义
    [self.drawAdView.mediation.canvasView.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    self.drawAdView.mediation.canvasView.dislikeBtn.userInteractionEnabled = YES;
    self.drawAdView.mediation.canvasView.dislikeBtn.tag = self.tag;
    [self.drawAdView.mediation.canvasView.dislikeBtn addTarget:self action:@selector(closeCell:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeCell:(UIButton *)btn {
    !self.cellClose ? : self.cellClose(btn.tag);
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
    if (self.drawAdView.data.source.length > 0) {
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

@interface BUMDDrawVideoAdView ()

@end

@implementation BUMDDrawVideoAdView
- (void)buildupView {
    [super buildupView];
    // Video ad did not use iv1, temporarily hidden...

    self.bgView = [UIView new];
    self.bgView.backgroundColor = BUD_RGB(0xf5, 0xf5, 0xf5);
    [self insertSubview:self.bgView atIndex:0];
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    [super refreshUIWithModel:model];

    self.drawAdView.mediation.canvasView.frame = self.bounds;//CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;

    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesFontLeading context:0].size;
    self.drawAdView.mediation.canvasView.titleLabel.frame = CGRectMake(padding.left, y, contentWidth, titleSize.height);
    self.drawAdView.mediation.canvasView.titleLabel.attributedText = attributedText;

    // 广告标识
    if (model.data.mediation.adLogo.imageURL) {
        UIImageView *adLogoV = [[UIImageView alloc] initWithFrame:CGRectMake(width-20, y, 20, 20)];
        [adLogoV setImageWithURL:[NSURL URLWithString:model.data.mediation.adLogo.imageURL]];
        [self.drawAdView.mediation.canvasView addSubview:adLogoV];
    }
    
    y += titleSize.height;
    y += 5;

    // 广告占位图
    BUImage *image = model.data.imageAry.firstObject;
    
    CGFloat imageHeight = CGRectGetHeight(self.drawAdView.mediation.canvasView.frame);
    if (image.width > 0) {
        imageHeight = contentWidth * (image.height / image.width);
        if (!self.drawAdView.mediation.canvasView.mediaView) {
            [self.drawAdView.mediation.canvasView.imageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:image.mediation.image];
            self.drawAdView.mediation.canvasView.imageView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
        }
    }
    
    self.drawAdView.mediation.canvasView.mediaView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    // !!!mediaView布局后h必须调用该方法
    [self.drawAdView.mediation reSizeMediaView];
  
    y += imageHeight;

    if (self.drawAdView.mediation.canvasView.hasSupportActionBtn) {
        // creativeButton
        NSString *btnTxt = @"Click";
        if (self.drawAdView.data.buttonText.length > 0) {
            btnTxt = self.drawAdView.data.buttonText;
        }
        [self.drawAdView.mediation.canvasView.callToActionBtn setTitle:btnTxt forState:UIControlStateNormal];
        [self.drawAdView.mediation.canvasView.callToActionBtn sizeToFit];
    }

    CGSize buttonSize = self.drawAdView.mediation.canvasView.callToActionBtn.frame.size;

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
            [self.drawAdView.mediation.canvasView addSubview:adLogoV];
        }
    }
    
    CGFloat originY = y;
    if (adLogoV) {
        originY = CGRectGetMinY(adLogoV.frame);
    }
    self.drawAdView.mediation.canvasView.descLabel.frame = CGRectMake(padding.left + 5 + CGRectGetWidth(adLogoV.frame), originY, maxInfoWidth, 20);
    self.drawAdView.mediation.canvasView.descLabel.attributedText = [BUDFeedStyleHelper subtitleAttributeText:model.data.AdSource];
    self.drawAdView.mediation.canvasView.descLabel.text = model.data.AdSource;
    
    //物料里的price，score，source等信息;开发者可根据原始信息自定义表现形式
    CGRect frame = CGRectMake(padding.left, CGRectGetMaxY(self.drawAdView.mediation.canvasView.descLabel.frame)-5, 260, 20);
    UILabel *otherInfoLbl = [self otherInfoLblWithFrame:frame data:self.drawAdView.data];
    [self.drawAdView.mediation.canvasView addSubview:otherInfoLbl];
    
    CGFloat dislikeX = width - 24 - padding.right;

    // 物料信息不包含关闭按钮需要自己实现
    if (!self.drawAdView.mediation.canvasView.dislikeBtn) {
        [self.drawAdView.mediation.canvasView.dislikeBtn setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
    }
    
    if (y >= CGRectGetHeight(self.drawAdView.mediation.canvasView.frame)) {
        y -= (y-CGRectGetHeight(self.drawAdView.mediation.canvasView.frame)+20);
    }
    self.drawAdView.mediation.canvasView.dislikeBtn.frame = CGRectMake(dislikeX, y, 24, 24);

    if (self.drawAdView.mediation.canvasView.hasSupportActionBtn) {
        self.drawAdView.mediation.canvasView.callToActionBtn.frame = CGRectMake(CGRectGetMinX(self.drawAdView.mediation.canvasView.dislikeBtn.frame) - buttonSize.width - 10, y + 50, buttonSize.width, buttonSize.height);
        self.drawAdView.mediation.canvasView.callToActionBtn.backgroundColor = [UIColor redColor];
    }

    NSMutableArray *viewArray = [NSMutableArray array];
    [viewArray addObject:self];
    if (self.drawAdView.mediation.canvasView.titleLabel) {
        [viewArray addObject:self.drawAdView.mediation.canvasView.titleLabel];
    }
    if (self.drawAdView.mediation.canvasView.descLabel) {
        [viewArray addObject:self.drawAdView.mediation.canvasView.descLabel];
    }
    if (self.drawAdView.mediation.canvasView.imageView) {
        [viewArray addObject:self.drawAdView.mediation.canvasView.imageView];
    }
    if (self.drawAdView.mediation.canvasView.mediaView) {
        [viewArray addObject:self.drawAdView.mediation.canvasView.mediaView];
    }
    if (self.drawAdView.mediation.canvasView.callToActionBtn) {
        [viewArray addObject:self.drawAdView.mediation.canvasView.callToActionBtn];
    }
    if (otherInfoLbl) {
        [viewArray addObject:otherInfoLbl];
    }
    // 注册点击事件
    [self.drawAdView registerContainer:self.drawAdView.mediation.canvasView withClickableViews:viewArray];
    [self addSubview:self.drawAdView.mediation.canvasView];
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

