//
//  BUMDCustomDrawAdHelper.m
//  BUMDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDCustomDrawAdHelper.h"
#import "BUMDCustomDrawData.h"

@interface BUMDCustomDrawAdHelper ()

@property (nonatomic, strong) BUMDCustomDrawData *data;

@property (nonatomic, strong) UILabel *adTitleLabel;

@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation BUMDCustomDrawAdHelper

- (instancetype)initWithAdData:(BUMDCustomDrawData *)data{
    if (self = [super init]) {
        _data = data;
        _adTitleLabel = [[UILabel alloc] init];
        _adImageView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - BUMMediatedNativeAdViewCreator
- (UILabel *)titleLabel {
    return self.adTitleLabel;
}

#pragma mark - BUMMediatedNativeAdData
- (NSString *)AdTitle {
    return self.data.title;
}

- (NSString *)AdDescription {
    return self.data.subtitle;
}

- (BUMImage *)adLogo {
    BUMImage *img = [[BUMImage alloc] init];
    img.width = 30;
    img.height = 30;
    img.image = self.data.logoView;
    return img;
}

- (BUMImage *)sdkLogo {
    return self.adLogo;
}

- (BUMMediatedNativeAdMode)imageMode {
    return BUMMediatedNativeAdModeLargeImage;
}
@end
