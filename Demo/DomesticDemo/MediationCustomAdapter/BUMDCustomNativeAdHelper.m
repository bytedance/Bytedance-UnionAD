//
//  BUMDCustomNativeAdHelper.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomNativeAdHelper.h"
#import "BUMDCustomNativeData.h"

@interface BUMDCustomNativeAdHelper ()

@property (nonatomic, strong) BUMDCustomNativeData *data;

@property (nonatomic, strong) UILabel *adTitleLabel;

@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation BUMDCustomNativeAdHelper

- (instancetype)initWithAdData:(BUMDCustomNativeData *)data {
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

- (NSArray<BUMImage *> *)imageList {
    UIImage *image = [UIImage imageNamed:self.data.imageName];
    BUMImage *img = [[BUMImage alloc] init];
    img.width = self.data.imageSize.width;
    img.height = self.data.imageSize.height;
    img.image = image;
    return @[img];
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
