//
//  BUDVideoPlayerView.h
//  BUDemo
//
//  Created by ByteDance on 2022/9/23.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUDVideoView.h"
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDVideoPlayerView : UIView

@property(nonatomic, strong, readonly) BUDVideoView *videoView;

@property(nonatomic, strong, readonly) id<BUVideoAdReportor> videoAdReportor;

- (void)refreshUIWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
