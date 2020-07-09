//
//  PangleNativeBannerView.h
//  BUADDemo
//
//  Created by bytedance on 2020/4/24.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAd.h>

NS_ASSUME_NONNULL_BEGIN
static CGFloat const bottomHeight = 30;

@interface PangleNativeBannerView : UIView
@property (nonatomic, strong) BUNativeAd *nativeAd;
- (instancetype)initWithSize:(CGSize)size;
- (void)refreshUIWithAd:(BUNativeAd *_Nonnull)nativeAd;
@end
NS_ASSUME_NONNULL_END
