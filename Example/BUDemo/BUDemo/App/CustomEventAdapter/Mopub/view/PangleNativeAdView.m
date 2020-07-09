//
//  PangleNativeAdView.m
//  BUDemo
//
//  Created by wangyanlin on 2020/5/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "PangleNativeAdView.h"

@implementation PangleNativeAdView

- (instancetype)init{
    if (self = [super init]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    /// propertyof mopub need
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 20)];
    self.titleLabel.textColor = [UIColor greenColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.titleLabel];
    
    self.mainTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame) + 10, 200, 20)];
    self.mainTextLabel.textColor = [UIColor blackColor];
    [self addSubview:self.mainTextLabel];

    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + CGRectGetMaxX(self.mainTextLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10, 20, 20)];
    [self addSubview:self.iconImageView];
    
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.iconImageView.frame) + 10, 300, 300)];
    [self addSubview:self.mainImageView];

    self.privacyInformationIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 50, CGRectGetMaxY(self.videoView.frame) + 10, 50, 20)];
    [self addSubview:self.privacyInformationIconImageView];

    self.videoView = [[UIView alloc] initWithFrame:self.mainImageView.frame]; // only for video ads
    [self addSubview:self.videoView];
    
    self.callToActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.videoView.frame) + 10, 200, 20)];
    self.callToActionLabel.textColor = [UIColor blueColor];
    [self addSubview:self.callToActionLabel];

}


- (UILabel *)nativeMainTextLabel
{
    return self.mainTextLabel;
}

- (UILabel *)nativeTitleTextLabel
{
    return self.titleLabel;
}

- (UILabel *)nativeCallToActionTextLabel
{
    return self.callToActionLabel;
}

- (UIImageView *)nativeIconImageView
{
    return self.iconImageView;
}

- (UIImageView *)nativeMainImageView
{
    return self.mainImageView;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    return self.privacyInformationIconImageView;
}

- (UIView *)nativeVideoView
{
    return self.videoView;
}

@end
