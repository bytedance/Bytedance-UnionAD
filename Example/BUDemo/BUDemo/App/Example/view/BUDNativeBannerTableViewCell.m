//
//  BUDNativeBannerTableViewCell.m
//  BUDemo
//
//  Created by iCuiCui on 2018/11/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeBannerTableViewCell.h"
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "UIImageView+AFNetworking.h"
#import "BUDMacros.h"

static CGSize const logoSize = {58, 18.5};
static CGFloat const margin = 5;

@interface BUDNativeBannerTableViewCell ()
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong, nullable) UIScrollView *horizontalScrollView;
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
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    self.horizontalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.width*0.56)];
    self.horizontalScrollView.pagingEnabled = YES;
    [self addSubview:self.horizontalScrollView];
}

-(void)refreshUIWithModel:(BUNativeAd *)model {
    self.nativeAd = model;
    [self.relatedView refreshData:model];
    
    for (UIView *view in self.horizontalScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    BUMaterialMeta *materialMeta = model.data;
    CGFloat x = 0.0;
    for (int i = 0; i < materialMeta.imageAry.count; i++) {
        BUImage *adImage = [materialMeta.imageAry objectAtIndex:i];
        CGFloat contentWidth = CGRectGetWidth(self.horizontalScrollView.bounds);
        CGFloat imageViewHeight = contentWidth*0.56;
        
        UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, contentWidth, imageViewHeight)];
        adImageView.contentMode =  UIViewContentModeScaleAspectFill;
        adImageView.clipsToBounds = YES;
        if (adImage.imageURL.length) {
            [adImageView setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
        }
        [self.horizontalScrollView addSubview:adImageView];
        
        CAGradientLayer* gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[
                                 (id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,
                                 (id)[[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor];
        gradientLayer.frame = CGRectMake(0, imageViewHeight -60, contentWidth, 60);
        [adImageView.layer addSublayer:gradientLayer];
        
        NSString * titleString = [NSString stringWithFormat:@"【左右滑动】第%d张广告，共%lu张",i+1,(unsigned long)materialMeta.imageAry.count];
        UILabel *titleLable = [UILabel new];
        titleLable.frame = CGRectMake(10, imageViewHeight-10-20, contentWidth-100, 20);
        titleLable.textColor = BUD_RGB(0xff, 0xff, 0xff);
        titleLable.font = [UIFont boldSystemFontOfSize:18];
        titleLable.text = titleString;
        [adImageView addSubview:titleLable];
        
        UIImageView *logoADImageView = [[UIImageView alloc] initWithImage:self.relatedView.logoADImageView.image];
        CGFloat logoIconX = CGRectGetWidth(adImageView.bounds) - logoSize.width - margin;
        CGFloat logoIconY = imageViewHeight - logoSize.height - margin;
        logoADImageView.frame = CGRectMake(logoIconX, logoIconY, logoSize.width, logoSize.height);
        logoADImageView.hidden = NO;
        [adImageView addSubview:logoADImageView];
        
        [self.nativeAd registerContainer:adImageView withClickableViews:nil];
        
        x += contentWidth;
        //addAccessibilityIdentifierForQA
        adImageView.accessibilityIdentifier = @"banner_view";
        logoADImageView.accessibilityIdentifier = @"banner_logo";
    }
    self.horizontalScrollView.contentSize = CGSizeMake(x, [UIScreen mainScreen].bounds.size.width*0.56);
}
@end
