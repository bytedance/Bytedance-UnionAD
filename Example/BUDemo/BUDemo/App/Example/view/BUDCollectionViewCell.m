//
//  BUDCollectionViewCell.m
//  BUDemo
//
//  Created by 李盛 on 2019/3/1.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+LocalizedString.h"

@interface BUDCollectionViewCell ()

@property (nonatomic, strong) UIView *customview;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UILabel *adLabel;

@end


@implementation BUDCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    CGFloat margin = 5;
    CGFloat cusViewWidth = self.bounds.size.width - margin*2;
    CGFloat cusViewHeight = self.bounds.size.height - margin*2;
    CGFloat leftMargin = cusViewWidth/20;
    _relatedView = [[BUNativeAdRelatedView alloc] init];
    // Custom view test
    _customview = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, cusViewWidth, cusViewHeight)];
    _customview.backgroundColor = [UIColor grayColor];
    [self addSubview:_customview];
    
    CGFloat swidth = CGRectGetWidth(_customview.frame);
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, leftMargin, swidth - leftMargin * 2, 30)];
    _infoLabel.backgroundColor = [UIColor magentaColor];
    _infoLabel.text = [NSString localizedStringForKey:Testads];
    _infoLabel.adjustsFontSizeToFitWidth = YES;
    [_customview addSubview:_infoLabel];
    
    CGFloat buttonWidth = ceilf((swidth-4 * leftMargin)/3);
    _actionButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_infoLabel.frame), CGRectGetMaxY(_infoLabel.frame)+5, buttonWidth, 30)];
    [_actionButton setTitle:[NSString localizedStringForKey:CustomBtn] forState:UIControlStateNormal];
    _actionButton.userInteractionEnabled = YES;
    _actionButton.backgroundColor = [UIColor orangeColor];
    _actionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_customview addSubview:_actionButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_actionButton.frame)+5, CGRectGetMaxY(_infoLabel.frame)+5, 100, 30)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.text = [NSString localizedStringForKey:AdsTitle];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [_customview addSubview:_titleLabel];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor redColor];
    [_customview addSubview:_imageView];
    
    // add video view
    [_customview addSubview:self.relatedView.videoAdView];
    // add logo view
    self.relatedView.logoImageView.frame = CGRectZero;
    [_customview addSubview:self.relatedView.logoImageView];
    // add dislike view
    self.relatedView.dislikeButton.frame = CGRectMake(CGRectGetMaxX(_infoLabel.frame) - 20 +4, CGRectGetMaxY(_infoLabel.frame)+5, 20, 20);
    [_customview addSubview:self.relatedView.dislikeButton];
    // add ad lable
    self.relatedView.adLabel.frame = CGRectZero;
    [_customview addSubview:self.relatedView.adLabel];
}

- (void)setNativeAd:(BUNativeAd *)nativeAd {
    self.infoLabel.text = nativeAd.data.AdDescription;
    self.titleLabel.text = nativeAd.data.AdTitle;
    self.imageView.hidden = YES;
    BUMaterialMeta *adMeta = nativeAd.data;
    CGFloat contentWidth = CGRectGetWidth(_customview.frame) - 50;
    BUImage *image = adMeta.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    CGRect rect = CGRectMake(25, CGRectGetMaxY(_actionButton.frame) + 5, contentWidth, imageHeight);
    self.relatedView.logoImageView.frame = CGRectMake(CGRectGetMaxX(rect) - 15 , CGRectGetMaxY(rect) - 15, 15, 15);
    self.relatedView.adLabel.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 14, 26, 14);
    [self.relatedView refreshData:nativeAd];
    // imageMode decides whether to show video or not
    if (adMeta.imageMode == BUFeedVideoAdModeImage) {
        self.imageView.hidden = YES;
        self.relatedView.videoAdView.hidden = NO;
        self.relatedView.videoAdView.frame = rect;
    } else {
        self.imageView.hidden = NO;
        self.relatedView.videoAdView.hidden = YES;
        if (adMeta.imageAry.count > 0) {
            if (image.imageURL.length > 0) {
                self.imageView.frame = rect;
                [self.imageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
            }
        }
    }
    
    // Register UIView with the native ad; the whole UIView will be clickable.
    [nativeAd registerContainer:self.customview withClickableViews:@[self.infoLabel, self.actionButton]];
}

@end
