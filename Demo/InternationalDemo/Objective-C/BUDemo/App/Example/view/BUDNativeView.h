//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PAGLNativeAd;

@interface BUDNativeView : UIView

- (void)refreshWithNativeAd:(PAGLNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
