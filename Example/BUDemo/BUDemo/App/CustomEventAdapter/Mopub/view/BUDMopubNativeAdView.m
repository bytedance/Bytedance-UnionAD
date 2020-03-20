//
//  BUDMopubNativeAdView.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDMopubNativeAdView.h"
#import "BUDMacros.h"
#import <mopub-ios-sdk/MPNativeAdRenderingImageLoader.h>
#import <mopub-ios-sdk/MPNativeAdConstants.h>

static CGFloat const margin = 15;
static UIEdgeInsets const padding = {10, 15, 10, 15};

@implementation BUDMopubNativeAdView

// calculate the view height by MPNativeAd
+ (CGFloat)cellHeightWithModel:(MPNativeAd *_Nonnull)model width:(CGFloat)width {
    NSURL *url = [NSURL URLWithString:[model.properties objectForKey:kAdMainImageKey]];
    UIImage *image = [self urlToImage:url];
    CGFloat scale = image.size.width / (image.size.height + 1e-4);
    CGFloat imageHeight = (width - padding.left - padding.right) / (scale + 1e-4);
    return padding.top + 15 + margin +  + imageHeight + margin + 12 + padding.bottom;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

// This is for resize the image to target size
- (UIImage *)resizeImage:(UIImage *)image withTragetSize:(CGSize)targetSize {
    CGRect rect = CGRectMake(0, 0, targetSize.width, targetSize.height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/// This is layout view for mopub Ad
- (void)buildupSubviewsForMopub {
    // init
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - padding.left - padding.right;
    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, width, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);
        
    // set frame
    CGFloat y = padding.top , x = padding.left;
    self.titleLabel.frame = CGRectMake(padding.left, y, 200, 15);
    y = y + 15 + margin;
    
    CGFloat imageWidth = width;
    CGFloat imageScale = self.mainImageView.image.size.width / (self.mainImageView.image.size.height + 1e-4);
    CGFloat imageHeight =  imageWidth / (imageScale + 1e-4);
    CGFloat imageX = (width - imageWidth) / 2  + padding.left;
    if (self.videoView) {
        self.videoView.frame = CGRectMake(imageX, y, imageWidth, imageHeight);
        y = y + imageHeight + margin;
    } else {
        self.mainImageView.frame = CGRectMake(imageX, y, imageWidth , imageHeight);
        self.mainImageView.image = [self resizeImage:self.mainImageView.image withTragetSize:CGSizeMake(imageWidth, imageHeight)];
        y = y + imageHeight + margin;
    }
    
    self.mainTextLabel.frame = CGRectMake(x, y, 150, 15);
    self.mainTextLabel.textColor = [UIColor grayColor];
    [self.mainTextLabel setFont:[UIFont systemFontOfSize:12]];
    x = x + 150 + margin;
    
    self.callToActionLabel.frame = CGRectMake(x, y, 100, 15);
    [self.callToActionLabel setTextColor:[UIColor blueColor]];
    [self.callToActionLabel setFont:[UIFont systemFontOfSize:12]];
    x = x + 100 + margin;
    
    self.iconImageView.frame = CGRectMake(x, y, 20, 20);
    x = x + margin + 20;
    
    self.privacyInformationIconImageView.frame = CGRectMake(x, y, 20, 20);
    
    self.frame = CGRectMake(0, 0, width, y + padding.bottom + 12);
    
    // add view
    [self addSubview:self.separatorLine];
    [self addSubview:self.mainImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.mainTextLabel];
    [self addSubview:self.callToActionLabel];
    [self addSubview:self.privacyInformationIconImageView];
    [self addSubview:self.iconImageView];
    [self addSubview:self.videoView];
}

/// This is layout view for Bytedance Union Ad. You can layout by self.nativeAd
- (void)buildupSubviewsForBU {
    // init
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - padding.left - padding.right;
    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, width, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);
    
    self.nativeAdRelatedView = [[BUNativeAdRelatedView alloc] init];
    
    // set frame
    CGFloat y = padding.top;
    self.titleLabel.frame = CGRectMake(padding.left, y, 200, 15);
    y = y + 15 + margin;
    // calculate the size of main image
    CGFloat imageWidth = width - padding.left - padding.right;
    CGFloat imageScale = self.mainImageView.image.size.width / (self.mainImageView.image.size.height + 1e-4);
    CGFloat imageHeight =  imageWidth / (imageScale + 1e-4);
    CGFloat imageX = (width - imageWidth) / 2  + padding.left;
    
    if (self.nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
        //CGFloat videoWidth = self.nativeAd.data.
        id <BUVideoAdViewDelegate> temp = self.nativeAd.delegate;
        self.nativeAdRelatedView.videoAdView.delegate = temp;
        self.nativeAdRelatedView.videoAdView.rootViewController = self.nativeAd.rootViewController;
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(imageX, y, imageWidth, imageHeight);
        y = y + imageHeight + margin;
    } else if (self.nativeAd.data.imageMode != BUFeedVideoAdModeImage) {
        self.mainImageView.frame = CGRectMake(imageX, y, imageWidth , imageHeight);
        self.mainImageView.image = [self resizeImage:self.mainImageView.image withTragetSize:CGSizeMake(imageWidth, imageHeight)];
        y = y + imageHeight + margin;
    }
    // put the logo of ByteDance Union in the mainImage or VideoView
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(width - padding.right - 15, y - margin - 30, 20, 20);
    [self.nativeAdRelatedView.logoADImageView setTintColor:[UIColor blueColor]];
    
    // put the line in bottom
    CGFloat x = padding.left;
    self.nativeAdRelatedView.logoADImageView.frame = CGRectMake(x, y, 40, 15);
    x = x + 40 + margin;
    
    self.mainTextLabel.frame = CGRectMake(x, y, 150, 15);
    self.mainTextLabel.textColor = [UIColor grayColor];
    [self.mainTextLabel setFont:[UIFont systemFontOfSize:12]];
    x = x + 150 + margin;
    
    self.callToActionLabel.frame = CGRectMake(x, y, 100, 15);
    [self.callToActionLabel setTextColor:[UIColor blueColor]];
    [self.callToActionLabel setFont:[UIFont systemFontOfSize:12]];

    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(width - padding.right,y , 20, 20);
    [self.nativeAdRelatedView refreshData:self.nativeAd]; // this operation is required

    self.frame = CGRectMake(0, 0, width + padding.left + padding.right, y + 12 + padding.bottom);
    // add view
    [self addSubview:self.separatorLine];
    [self addSubview:self.mainImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.mainTextLabel];
    [self addSubview:self.callToActionLabel];
    [self addSubview:self.nativeAdRelatedView.dislikeButton];
    [self addSubview:self.nativeAdRelatedView.videoAdView];
    [self addSubview:self.nativeAdRelatedView.logoImageView];
    [self addSubview:self.nativeAdRelatedView.logoADImageView];
    // register click
    if (self.videoView) {
        [self.nativeAd registerContainer:self withClickableViews:@[self.mainImageView,self.mainTextLabel,self.callToActionLabel,self.videoView]];
    } else {
        [self.nativeAd registerContainer:self withClickableViews:@[self.mainImageView,self.mainTextLabel,self.callToActionLabel]];
    }
}

// This is to load image by url
+ (UIImage *)urlToImage:(NSURL *)url {
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    return image;
}

#pragma mark - MPNativeAdRendering
- (void)layoutCustomAssetsWithProperties:(NSDictionary *)customProperties imageLoader:(MPNativeAdRenderingImageLoader *)imageLoader {
    if (!self.mainImageView) {
        self.mainImageView = [[UIImageView alloc] init];
    }
    if (self.iconImageView) {
        self.iconImageView = [[UIImageView alloc] init];
    }
    [imageLoader  loadImageForURL:[NSURL URLWithString:[customProperties objectForKey:kAdMainImageKey]] intoImageView:self.mainImageView];
    [imageLoader loadImageForURL:[NSURL URLWithString:[customProperties objectForKey:kAdIconImageKey]] intoImageView:self.iconImageView];
    self.mainImageView.image = [BUDMopubNativeAdView urlToImage:[NSURL URLWithString:[customProperties objectForKey:kAdMainImageKey]]];
    self.iconImageView.image = [BUDMopubNativeAdView urlToImage:[NSURL URLWithString:[customProperties objectForKey:kAdIconImageKey]]];
    
    // take different layout for different ad!!!
    if ([customProperties objectForKey:@"bu_nativeAd"] == nil) {
        // set property by customProperties
        [self buildupSubviewsForMopub];
    } else {
        self.nativeAd = [customProperties objectForKey:@"bu_nativeAd"];
        [self buildupSubviewsForBU];
    }
}

- (UILabel *)nativeMainTextLabel
{
    if (self.mainTextLabel == nil) {
        self.mainTextLabel = [[UILabel alloc] init];
    }
    return self.mainTextLabel;
}

- (UILabel *)nativeTitleTextLabel
{
    if (self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] init];
    }
    return self.titleLabel;
}

- (UILabel *)nativeCallToActionTextLabel
{
    if (self.callToActionLabel == nil) {
        self.callToActionLabel = [[UILabel alloc] init];
    }
    return self.callToActionLabel;
}

- (UIImageView *)nativeIconImageView
{
    if (self.iconImageView == nil) {
        self.iconImageView = [[UIImageView alloc] init];
    }
    return self.iconImageView;
}

- (UIImageView *)nativeMainImageView
{
    if (self.mainImageView == nil) {
        self.mainImageView = [[UIImageView alloc] init];
    }
    return self.mainImageView;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    if (self.privacyInformationIconImageView == nil) {
        self.privacyInformationIconImageView = [[UIImageView alloc] init];
    }
    return self.privacyInformationIconImageView;
}

// This method only applies for video.
- (UIView *)nativeVideoView
{
    if (self.videoView == nil) {
        self.videoView = [[UIView alloc] init];
    }
    return self.videoView;
}
@end
