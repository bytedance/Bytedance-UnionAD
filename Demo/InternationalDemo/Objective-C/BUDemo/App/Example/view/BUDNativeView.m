//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <PAGAdSDK/PAGLNativeAdRelatedView.h>
#import <PAGAdSDK/PAGLMaterialMeta.h>
#import <PAGAdSDK/PAGMediaView.h>
#import <PAGAdSDK/PAGLNativeAd.h>

#import "BUDNativeView.h"

@interface BUDNativeView ()

@property (nonatomic, strong) PAGLNativeAdRelatedView *relatedView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation BUDNativeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.lightGrayColor;
        
        self.relatedView = PAGLNativeAdRelatedView.new;
        [self addSubview:self.relatedView.mediaView];
        [self addSubview:self.relatedView.dislikeButton];
        [self addSubview:self.relatedView.logoADImageView];
        
        self.titleLabel = UILabel.new;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = UIColor.blackColor;
        [self addSubview:self.titleLabel];
        
        self.detailLabel = UILabel.new;
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        self.detailLabel.textColor = UIColor.blackColor;
        [self addSubview:self.detailLabel];
        
        [self addSubview:self.relatedView.adChoicesView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    self.relatedView.mediaView.frame = CGRectMake(0, 50, CGRectGetWidth(self.bounds) , CGRectGetHeight(self.bounds) - 100);
    self.relatedView.dislikeButton.frame = CGRectMake(0, 0, 44, 44);
    CGSize logoSize = CGSizeMake(20, 10);
    CGSize adChoiceSize = CGSizeMake(14, 14);
    self.relatedView.logoADImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - logoSize.height, logoSize.width, logoSize.height);
    self.relatedView.adChoicesView.frame = CGRectMake(CGRectGetWidth(self.bounds) - adChoiceSize.width, CGRectGetHeight(self.bounds) - adChoiceSize.height, adChoiceSize.width, adChoiceSize.height);
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 20);
    self.detailLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 40, CGRectGetWidth(self.bounds), 40);
}

- (void)refreshWithNativeAd:(PAGLNativeAd *)nativeAd {
    self.titleLabel.text = nativeAd.data.AdTitle;
    self.detailLabel.text = nativeAd.data.AdDescription;
    [self.relatedView refreshWithNativeAd:nativeAd];
}

@end
