//
//  BUDPasterContentView.h
//  BUDemo
//
//  Created by bytedance on 2020/10/28.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>
@class BUDVideoView;
@class BUNativeAd;

NS_ASSUME_NONNULL_BEGIN

@interface BUDPasterContentView : UIView
@property (nonatomic, strong, readonly) UIButton *creativeBtn;
/// paster image
@property (nonatomic, strong, readonly) UIImageView *pasterImageView;
/// SDK video view
@property (nonatomic, strong, readonly) BUVideoAdView *SDKVideoView;
/// custom video view
@property (nonatomic, strong, readonly) BUDVideoView *customVideoView;

@property (nonatomic, strong, readonly) id<BUVideoAdReportor> videoAdReportor;

- (instancetype)initWithPasterContentWith:(BOOL)isCustomPlayer;

- (void)refreshUIWithModel:(BUNativeAd *)model;

- (NSTimeInterval)pasterViewTimerInterval;

- (BOOL)isVideoAd;
- (BOOL)isImageAd;
@end

@interface BUTimerWeakProxy : NSProxy
- (instancetype)initTimerProxyWithTarget:(id)target;
+ (instancetype)proxyWithTarget:(id)target;
@end
NS_ASSUME_NONNULL_END
