//
//  BUDVideoView.m
//  BUDemo
//
//  Created by bytedance on 2020/8/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDVideoView.h"
#import <AVKit/AVKit.h>

@interface BUDVideoView ()

@property (nonatomic, strong) AVPlayerItem *item;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, assign) BUDVideoViewStatus status;

@property (nonatomic, strong) id observer;

@end

@implementation BUDVideoView

- (void)loadURL:(NSURL *)URL {
    if (!URL || ![URL isKindOfClass:[NSURL class]]) return;
    if (_item) {
        [_item removeObserver:self forKeyPath:@"status"];
    }
    AVAsset *avasset = [AVAsset assetWithURL:URL];
    _item = [AVPlayerItem playerItemWithAsset:avasset automaticallyLoadedAssetKeys:@[@"duration"]];
    if (!_item) return;
    if (_player) {
        if (self.isPlaying) [_player pause];
        if (_observer) [_player removeTimeObserver:_observer];
        [_player removeObserver:self forKeyPath:@"rate"];
        [_player replaceCurrentItemWithPlayerItem:_item];
    } else {
        _player = [AVPlayer playerWithPlayerItem:_item];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        [self.layer addSublayer:_playerLayer];
    }
    
    CMTime time = CMTimeMake(1, 1);
    __weak __typeof(self) ws = self;
    _observer = [_player addPeriodicTimeObserverForInterval:time queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong __typeof(ws) self = ws;
        NSTimeInterval total = self.durationOfCurrentItem;
        NSTimeInterval current = self.watchedDurationOfCurrentItem;
        if (total <= 0) return;
        if (current >= total) {
            if (self.status != BUDVideoViewStatusStopped) {
                self.status = BUDVideoViewStatusStopped;
            }
        }
    }];
    
    [_item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:NULL];
    self.status = BUDVideoViewStatusDefaut;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.item && [keyPath isEqualToString:@"status"]) {
        if (self.item.status == AVPlayerItemStatusReadyToPlay) {
        } else if (self.item.status == AVPlayerItemStatusFailed) {
            self.status = BUDVideoViewStatusError;
            _error = self.item.error;
        }
    } else if(object == self.player && [keyPath isEqualToString:@"rate"]) {
        float rate = [change[NSKeyValueChangeNewKey] floatValue];
        if (rate == 1.0 && self.status == BUDVideoViewStatusReady) {
            self.status = BUDVideoViewStatusPlaying;
        }
    }
}

- (void)play {
    if (!_player || !_player.currentItem) return;
    self.status = BUDVideoViewStatusReady;
    
    [_player seekToTime:kCMTimeZero];
    [_player play];
}

- (void)pause {
    if (!_player || !_player.currentItem) return;
    [_player pause];
    self.status = BUDVideoViewStatusPaused;
}

- (void)resume {
    if (!_player || !_player.currentItem) return;
    if (_status != BUDVideoViewStatusPaused) return;
    if (_player.status == AVPlayerStatusReadyToPlay) {
        [_player play];
    }
    self.status = BUDVideoViewStatusResumed;
}

- (void)abort {
    if (!_player || !_player.currentItem) return;
    [_player pause];
    self.status = BUDVideoViewStatusAbort;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _playerLayer.frame = self.bounds;
}

- (BOOL)isPlaying {
    return _status == BUDVideoViewStatusPlaying;
}

- (void)setStatus:(BUDVideoViewStatus)status {
    if (status == _status) return;
    _status = status;
}

@end

@implementation BUDVideoView (Item)

CG_INLINE
NSTimeInterval _convertCMTimeToNSTimeInterval(CMTime time)
{
    double scale = (double)time.timescale;
    if (scale == 0) return 0;
    NSTimeInterval duration = (double)time.value / scale;
    return duration;
}

- (NSTimeInterval)durationOfCurrentItem {
    return _convertCMTimeToNSTimeInterval(self.player.currentItem.duration);
}

- (NSTimeInterval)watchedDurationOfCurrentItem {
    return _convertCMTimeToNSTimeInterval(self.player.currentTime);
}

@end
