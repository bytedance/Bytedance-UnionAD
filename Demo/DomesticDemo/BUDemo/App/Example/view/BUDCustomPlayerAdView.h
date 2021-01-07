//
//  BUDCustomPlayerAdView.h
//  BUDemo
//
//  Created by bytedance on 2020/8/18.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUVideoAdReportor.h>

@class BUDVideoView;

NS_ASSUME_NONNULL_BEGIN

@interface BUDCustomPlayerAdView : UIView

@property(nonatomic, strong, readonly) BUDVideoView *videoView;

@property(nonatomic, strong, readonly) id<BUVideoAdReportor> videoAdReportor;

- (void)refreshUIWithModel:(BUNativeAd *)model;

@end

NS_ASSUME_NONNULL_END
