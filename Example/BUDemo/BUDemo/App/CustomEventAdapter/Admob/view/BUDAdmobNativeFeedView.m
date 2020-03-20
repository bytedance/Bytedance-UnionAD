//
//  BUDAdmobNativeFeedView.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/17.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmobNativeFeedView.h"
#import <GoogleMobileAds/GADUnifiedNativeAd.h>
#import <GoogleMobileAds/GADUnifiedNativeAdAssetIdentifiers.h>
#import "BUDFeedAdTableViewCell.h"

#import "UIImageView+AFNetworking.h"
#import "BUDFeedStyleHelper.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDAdmobDislikeReasonChoiceView.h"

static CGFloat const margin = 15;
static UIEdgeInsets const padding = {10, 15, 10, 15};

@interface BUDAdmobNativeFeedView () <BUDAdmobDislikeReasonChoiceDelegate>

@end

@implementation BUDAdmobNativeFeedView
- (instancetype)initWithGADModel:(GADUnifiedNativeAd *)nativeAd {
    self = [super init];
    if (self) {
        self.gadView = [[GADUnifiedNativeAdView alloc] init];
        // This is must
        self.gadView.nativeAd = nativeAd;
        [self buildupView];
        [self refreshUIWithModel];
    }
    return self;
}

+ (CGFloat)cellHeightWithModel:(GADUnifiedNativeAd *_Nonnull)model width:(CGFloat)width {
    GADNativeAdImage *image = model.images.firstObject;
    CGFloat scale ;
    if (image.image) {
        scale = image.image.size.width / (image.image.size.height + 1e-4);
    } else {
        scale = image.scale;
    }
    const CGFloat contentWidth = (width - padding.left - padding.right);
    const CGFloat imageHeight = contentWidth / (scale + 1e-4);
    return padding.top + 15 + margin + imageHeight + margin + 15 + padding.bottom;
}

- (UIImage *)urlToImage:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    return  image;
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

- (void)buildupView {
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, swidth - padding.left - padding.right, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);
    [self addSubview:self.separatorLine];
    
    self.iconView = [UIImageView new];
    
    self.headlineView = [UILabel new];
    self.headlineView.textAlignment = NSTextAlignmentLeft;
    
    self.bodyView = [UILabel new];
    self.bodyView.numberOfLines = 0;
    self.bodyView.textColor = BUD_RGB(0x55, 0x55, 0x55);
    self.bodyView.font = [UIFont systemFontOfSize:14];
    
    self.callToActionView = [UILabel new];
    self.callToActionView.numberOfLines = 0;
    self.callToActionView.textColor = [UIColor blueColor];
    self.callToActionView.font = [UIFont systemFontOfSize:14];
    
    // for admob
    self.mediaView = [GADMediaView new];
    self.mediaView.mediaContent = self.gadView.nativeAd.mediaContent;
    self.dislikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"BUAdSDK.bundle/bu_dislike@2x" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [self.dislikeButton setImage:image forState:UIControlStateNormal];
    [self.dislikeButton addTarget:self action:@selector(dislikeButtonHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    // for bytedance union
    self.nativeAdRelatedView = [BUNativeAdRelatedView new];
    self.mainImageViewForBU = [UIImageView new];
}

-(void)dislikeButtonHandle:(UIButton *) button{
    CGPoint position = CGPointMake(button.frame.origin.x, button.frame.origin.y);
    BUDAdmobDislikeReasonChoiceView *dislikeChoiceView = [[BUDAdmobDislikeReasonChoiceView alloc] initWithPosition:position andReasons:self.gadView.nativeAd.muteThisAdReasons];
    //set view delegate
    dislikeChoiceView.delegate = self;
    [self addSubview:dislikeChoiceView];
}

- (void)refreshUIWithModel{
    GADUnifiedNativeAd *model = self.gadView.nativeAd;
    if ([model.extraAssets objectForKey:BUDNativeAdTranslateKey]) {
        [self refreshBaseUIWithModelForBU];
    } else {
        [self refreshBaseUIWithModelForAdmob];
    }
}

- (void)refreshBaseUIWithModelForAdmob {
    GADUnifiedNativeAd *model = self.gadView.nativeAd;
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top ,  x = padding.left;
    
    // set view content
    self.headlineView.text = model.headline;
    self.bodyView.text = model.body;
    self.callToActionView.text = model.callToAction;
    self.iconView.image = [self urlToImage:model.icon.imageURL];
    
    // set view frame
    self.headlineView.frame = CGRectMake(x, y, 200, 15);
    y = y +15 + margin;
    
    GADNativeAdImage *image = model.images.firstObject;
    CGFloat scale ;
    if (image.image) {
        scale = image.image.size.width / (image.image.size.height + 1e-4);
    } else {
        scale = image.scale;
    }
    CGFloat contentHeight = contentWidth / (scale + 1e-4);
    self.mediaView.frame = CGRectMake(x, y, contentWidth, contentHeight);
    y = y + contentHeight + margin;
    
    self.bodyView.frame = CGRectMake(x, y, 100, 15);
    x = x + 100 + margin;
    
    self.callToActionView.frame = CGRectMake(x, y , 150, 15);
    x = x + 70 + margin;
    
    self.dislikeButton.frame = CGRectMake(contentWidth -15, y, 30, 20);
    self.iconView.frame = CGRectMake(contentWidth - 15 - margin - 15, y, 15, 15);
    
    // lock the view and gadView
    [self.gadView addSubview:self.headlineView];
    [self.gadView addSubview:self.callToActionView];
    [self.gadView addSubview:self.bodyView];
    [self.gadView addSubview:self.mediaView];
    [self.gadView addSubview:self.iconView];
    self.gadView.bodyView = self.bodyView;
    self.gadView.headlineView = self.headlineView;
    self.gadView.callToActionView = self.callToActionView;
    self.gadView.mediaView = self.mediaView;
    self.gadView.iconView = self.iconView;
    
    self.gadView.userInteractionEnabled = NO;
    self.gadView.frame = CGRectMake(0, 0, width, y + 15 +padding.bottom);
    // add view
    [self addSubview:self.gadView];
    if (self.gadView.nativeAd.customMuteThisAdAvailable) { // if support custom dislike, add the dislike button to self
        [self addSubview:self.dislikeButton];
    }
    self.frame = self.gadView.frame;
    
    // register clickable view
    [model registerAdView:self clickableAssetViews:@{GADUnifiedNativeHeadlineAsset:self.headlineView,GADUnifiedNativeCallToActionAsset:self.callToActionView,GADUnifiedNativeBodyAsset:self.bodyView} nonclickableAssetViews:@{GADUnifiedNativeIconAsset:self.iconView}];
}

- (void)refreshBaseUIWithModelForBU {
    GADUnifiedNativeAd *model = self.gadView.nativeAd;

    BUNativeAd *bu_nativeAd = (BUNativeAd *)[model.extraAssets objectForKey:BUDNativeAdTranslateKey];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat contentWidth = width - padding.left - padding.right;
    CGFloat y = padding.top, x = padding.left;
    
    // set view content
    self.headlineView.text = model.headline;
    self.bodyView.text = model.body;
    self.callToActionView.text = model.callToAction;
    self.iconView.image = [self urlToImage:model.icon.imageURL];
    self.mainImageViewForBU.image = [self urlToImage:model.images.firstObject.imageURL];
    
    // set view frame
    self.headlineView.frame = CGRectMake(x, y, 200, 15);
    y = y +15 + margin;
    
    GADNativeAdImage *image = model.images.firstObject;
    CGFloat scale ;
    if (image.image) {
        scale = image.image.size.width / (image.image.size.height + 1e-4);
    } else {
        scale = image.scale;
    }
    CGFloat contentHeight = contentWidth / (scale + 1e-4);
    if (bu_nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(x, y, contentWidth, contentHeight);
    } else {
        self.mainImageViewForBU.frame = CGRectMake(x, y, contentWidth, contentHeight);
        self.mainImageViewForBU.image = [self resizeImage:self.mainImageViewForBU.image withTragetSize:CGSizeMake(contentWidth, contentHeight)];
    }
    self.nativeAdRelatedView.logoImageView.frame = CGRectMake(contentWidth - 30, y + contentHeight - 30, 20, 20);  // put the ByteDance Union logo to image

    y = y + contentHeight + margin;
     
    self.nativeAdRelatedView.logoADImageView.frame = CGRectMake(x, y, 30, 15);
    x = x + 30 + margin;
    
    self.bodyView.frame = CGRectMake(x, y, 100, 15);
    x = x + 100 + margin;
     
    self.callToActionView.frame = CGRectMake(x, y , 100, 15);
    x = x + 100 + margin;
    
    self.nativeAdRelatedView.dislikeButton.frame = CGRectMake(contentWidth - 20, y, 20, 20);
    self.iconView.frame = CGRectMake(contentWidth - 20 - margin - 15, y, 15, 15);

    // this must
    self.frame = CGRectMake(0, 0, width, y + 25 + padding.bottom);
 
    // add view to contentview
    [self addSubview:self.headlineView];
    [self addSubview:self.callToActionView];
    [self addSubview:self.iconView];
    [self addSubview:self.bodyView];
    if (bu_nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
        [self addSubview:self.nativeAdRelatedView.videoAdView];
    } else {
        [self addSubview:self.mainImageViewForBU];
    }
    [self addSubview:self.nativeAdRelatedView.logoADImageView];
    [self addSubview:self.nativeAdRelatedView.dislikeButton];
    [self addSubview:self.nativeAdRelatedView.logoImageView];
    [self addSubview:self.nativeAdRelatedView.logoImageView];
    
    // register clickable view
    if (bu_nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
        [bu_nativeAd registerContainer:self withClickableViews:@[self.headlineView,self.callToActionView,self.bodyView,self.nativeAdRelatedView.videoAdView]];
    } else {
        [bu_nativeAd registerContainer:self withClickableViews:@[self.headlineView,self.callToActionView,self.bodyView,self.mainImageViewForBU]];
    }
    //
    [self.nativeAdRelatedView refreshData:bu_nativeAd];
}

# pragma mark - BUDAdmobDislikeReasonChoiceDelegate

- (void)muteNativeAd:(UIView *)view withDislikeReason:(GADMuteThisAdReason *)reason {
    [self.gadView.nativeAd muteThisAdWithReason:reason];
}
@end
