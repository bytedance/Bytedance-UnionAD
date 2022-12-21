//
//  BUDVideoPlayerView.m
//  BUDemo
//
//  Created by ByteDance on 2022/9/23.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUDVideoPlayerView.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDVideoView.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDFeedStyleHelper.h"

static CGFloat const margin = 15;
static UIEdgeInsets const padding = {10, 15, 10, 15};

@interface BUDVideoPlayerView ()

@property(nonatomic, strong) BUDVideoView *videoView;

@property(nonatomic, strong) UIView *bgView;

@end

@implementation BUDVideoPlayerView

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self buildUpView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUpView];
    }
    return self;
}

- (void)buildUpView {
    // Add custom button
    self.bgView = [UIView new];
    self.bgView.backgroundColor = BUD_RGB(0xf5, 0xf5, 0xf5);
    [self insertSubview:self.bgView atIndex:0];

    // 创建播放器视图
    BUDVideoView *videoView = [[BUDVideoView alloc] init];
    [self addSubview:videoView];
    self.videoView = videoView;
}

- (void)refreshUIWithUrl:(NSString *)url {

    [self.videoView loadURL:[NSURL URLWithString:url]];

    // 广告展位图
    self.videoView.frame = self.bounds;
    self.bgView.frame = self.bounds;

    //[self.videoView play];
}

@end
