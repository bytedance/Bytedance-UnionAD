//
//  BUDNativeBannerTableViewCell.m
//  BUDemo
//
//  Created by iCuiCui on 2018/11/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeBannerTableViewCell.h"
#import <BUAdSDK/BUAdSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>
//#import "UIImageView+WebCache.h"
#import "BUDMacros.h"
#import "UIView+Draw.h"
#import "BUDCustomDislikeViewController.h"

static CGSize const logoSize = {58, 22.5};

@implementation BUDBannerModel

- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd {
    self = [super init];
    if (self) {
        self.nativeAd = nativeAd;
        BUImage *adImage = nativeAd.data.imageAry.firstObject;
        CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width;
        self.imgeViewHeight = contentWidth * adImage.height/ adImage.width;
    }
    return self;
}

@end

@interface BUDNativeBannerTableViewCell () <BUDCustomDislikeDelegate>
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong, nullable) UIScrollView *horizontalScrollView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic,strong) UIImageView *adLogo;
@end

@implementation BUDNativeBannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    
    self.horizontalScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.horizontalScrollView.pagingEnabled = YES;
    [self.contentView addSubview:self.horizontalScrollView];
    
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    // 根据需求选择自定义或SDK的反馈面板
    if ([self validCustomDislike]) {
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton setImage:[UIImage imageNamed:@"feedClose"] forState:UIControlStateNormal];
        [self.closeButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        self.closeButton.frame = CGRectMake(0, 0, 20.0, 20.0);
        [self.closeButton addTarget:self action:@selector(customDislikeAction) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.closeButton = self.relatedView.dislikeButton;
    }
    [self.contentView addSubview:self.closeButton];
    
    self.adLogo = self.relatedView.logoADImageView;
    [self.contentView addSubview:self.adLogo];
    
    [self addAccessibilityIdentifier];
}

- (void)customDislikeAction {
    BUDCustomDislikeViewController *dislikeVC = [[BUDCustomDislikeViewController alloc] initWithNativeAd:self.bannerModel.nativeAd];
    dislikeVC.delegate = self;
    [self.bannerModel.nativeAd.rootViewController presentViewController:dislikeVC animated:YES completion:nil];
}

-(void)refreshUIWithModel:(BUDBannerModel *)model {
    self.bannerModel = model;
    [self.relatedView refreshData:model.nativeAd];
    
    for (UIView *view in self.horizontalScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat contentWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.horizontalScrollView.frame = CGRectMake(0, 0, contentWidth, model.imgeViewHeight);
    
    BUMaterialMeta *materialMeta = model.nativeAd.data;
    CGFloat x = 0.0;
    for (int i = 0; i < materialMeta.imageAry.count; i++) {
        BUImage *adImage = [materialMeta.imageAry objectAtIndex:i];

        UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, contentWidth, model.imgeViewHeight)];
        adImageView.contentMode =  UIViewContentModeScaleAspectFill;
        adImageView.clipsToBounds = YES;
        if (adImage.imageURL.length) {
            [adImageView sd_setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
            
        }
        [self.horizontalScrollView addSubview:adImageView];
        
        CAGradientLayer* gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[
                                 (id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,
                                 (id)[[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor];
        gradientLayer.frame = CGRectMake(0, model.imgeViewHeight -60, contentWidth, 60);
        [adImageView.layer addSublayer:gradientLayer];
        
        NSString * titleString = [NSString stringWithFormat:@"Total Page:%ld, Current page:%ld", (long)materialMeta.imageAry.count, (long)(i + 1)];

        UILabel *titleLable = [UILabel new];
        titleLable.frame = CGRectMake(10, model.imgeViewHeight-10-20, contentWidth-100, 20);
        titleLable.textColor = BUD_RGB(0xff, 0xff, 0xff);
        titleLable.font = [UIFont boldSystemFontOfSize:18];
        titleLable.text = titleString;
        [adImageView addSubview:titleLable];
        
        [self.bannerModel.nativeAd registerContainer:adImageView withClickableViews:nil];
        
        x += contentWidth;
        adImageView.accessibilityIdentifier = @"banner_view";
    }
    self.horizontalScrollView.contentSize = CGSizeMake(x, model.imgeViewHeight);
    self.closeButton.frame = CGRectMake(self.width-self.closeButton.width-5, self.horizontalScrollView.height +(self.closeButton.width)/2, self.closeButton.width, self.closeButton.height);
    self.adLogo.frame = CGRectMake(self.closeButton.left-logoSize.width - 10, self.horizontalScrollView.height +(logoSize.height)/2, logoSize.width, logoSize.height);
}

#pragma mark - BUDCustomDislikeDelegate
- (void)customDislike:(BUDCustomDislikeViewController *)controller withNativeAd:(BUNativeAd *)nativeAd didSelected:(BUDislikeWords *)dislikeWorkd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomDislike:withNativeAd:didSlected:)]) {
        [self.delegate bannerCustomDislike:self withNativeAd:nativeAd didSlected:dislikeWorkd];
    }
}

#pragma mark addAccessibilityIdentifier
- (void)addAccessibilityIdentifier {
    self.closeButton.accessibilityIdentifier = @"banner_close";
    self.adLogo.accessibilityIdentifier = @"banner_logo";
}

- (BOOL)validCustomDislike {
    // 是否自定义dislike面板
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"kCustomDislikeIsOn"];
}
@end
