//
//  BUDNativeView.h
//  PAGAdSDK
//
//  Created by bytedance on 2022/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PAGLNativeAd;

@interface BUDNativeView : UIView

- (void)refreshWithNativeAd:(PAGLNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
