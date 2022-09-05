//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#if __has_include(<BUWebAd/BUWebAd.h>)
#import "BUDNativeBannerView.h"
#import <BUWebAd/BUWebAd.h>
#import <SDWebImage/UIImageView+WebCache.h>

static CGSize const logoSize = { 58, 22.5 };

@interface BUDNativeBannerView ()

@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIImageView *adLogo;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BUNativeAd *ad;
@end

@implementation BUDNativeBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildView];
    }
    return self;
}

- (void)buildView {
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    
    self.closeButton = self.relatedView.dislikeButton;
    [self addSubview:self.closeButton];
    
    self.adLogo = self.relatedView.logoADImageView;
    self.adLogo.frame = CGRectMake(0, 0, logoSize.width, logoSize.height);
    [self addSubview:self.adLogo];
    
    UILabel *titleLable = [UILabel new];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:titleLable];
    self.titleLabel = titleLable;
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    self.ad = model;
    [self.relatedView refreshData:model];
    BUMaterialMeta *materialMeta = model.data;
    BUImage *adImage = materialMeta.imageAry.firstObject;
    
    if (adImage.imageURL.length) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
    }
    [model registerContainer:self.imageView withClickableViews:nil];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    BUSize *imgSize = self.ad.adslot.imgSize;
    CGSize imageSize = {imgSize.width, imgSize.height};
    if (imageSize.height) {
        imageSize = CGSizeMake(imageSize.width * size.height / imageSize.height, size.height);
    }
    self.imageView.frame = (CGRect){CGPointZero, imageSize};
    
    self.closeButton.frame = CGRectOffset(self.closeButton.bounds, size.width - self.closeButton.frame.size.width, 0);
    self.adLogo.frame = CGRectOffset(self.adLogo.bounds, size.width - self.adLogo.frame.size.width, size.height - self.adLogo.frame.size.height);
    
}

@end
#endif
