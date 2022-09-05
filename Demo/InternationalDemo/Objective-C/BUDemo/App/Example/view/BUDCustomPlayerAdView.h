//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>

@class BUDVideoView;

NS_ASSUME_NONNULL_BEGIN

@interface BUDCustomPlayerAdView : UIView

@property(nonatomic, strong, readonly) BUDVideoView *videoView;

@property(nonatomic, strong, readonly) id<BUVideoAdReportor> videoAdReportor;

- (void)refreshUIWithModel:(BUNativeAd *)model;

@end

NS_ASSUME_NONNULL_END
