//
//  BUDNativeBannerView.h
//  BUWebAd_Example
//
//  Created by bytedance on 2020/10/15.
//  Copyright © 2020 makaiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BUNativeAd;

@interface BUDNativeBannerView : UIView

- (void)refreshUIWithModel:(BUNativeAd *)model;

@end

NS_ASSUME_NONNULL_END
