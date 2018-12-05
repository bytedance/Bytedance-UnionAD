//
//  BUDPlayer.m
//  BUDemo
//
//  Created by iCuiCui on 2018/10/26.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDPlayerController.h"
#import "UIView+Draw.h"

@interface BUDPlayerController()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, assign) bool isPlaying;
@end

@implementation BUDPlayerController

- (instancetype)init {
    self = [super init];
    if (self) {
        _isPlaying = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        self.player = [[AVPlayer alloc] init];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.frame = self.view.bounds;
        [self.view.layer addSublayer:_playerLayer];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"adPlay.png"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(didClickPlayBtn) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.frame = CGRectMake((self.view.frame.size.width-60)/2, (self.view.frame.size.height-60)/2, 60, 60);
        [self.view addSubview:_playBtn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickPlayBtn)];
        self.view.userInteractionEnabled = YES;
        [self.view addGestureRecognizer:tap];
    }
    return self;
}

- (void)playbackFinished:(NSNotification *)notification {
    if ([self.view inScreen]) {
        _playerItem = [notification object];
        [_playerItem seekToTime:kCMTimeZero];
        [self play];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self pause];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.playerItem = nil;
    self.playerLayer = nil;
    self.player = nil;
}

- (void)setContentURL:(NSURL *)contentURL {
    _contentURL = contentURL;
    _playerItem = [AVPlayerItem playerItemWithURL:contentURL];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
}

- (void)play {
    self.playBtn.hidden = YES;
    _isPlaying = YES;
    [_player play];
}

- (void)pause {
    self.playBtn.hidden = NO;
    _isPlaying = NO;
    [_player pause];
}

- (void)didClickPlayBtn {
    if (_isPlaying) {
        [self pause];
    }else{
        [self play];
    }
}
@end
