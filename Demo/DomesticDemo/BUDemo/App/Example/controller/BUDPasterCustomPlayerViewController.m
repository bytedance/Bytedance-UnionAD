//
//  BUDPasterCustomPlayerViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/9/27.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDPasterCustomPlayerViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDVideoView.h"
#import "BUDPasterContentView.h"
@interface BUDPasterCustomPlayerViewController ()

@end

@implementation BUDPasterCustomPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

}

#pragma mark - override
- (BUDPasterPlayerStyle)playerStyle {
    return BUDPasterPlayerStyleCustom;
}

#pragma mark - Report

- (void)reportPangleWithStatus:(BUDVideoViewStatus)status {
    [super reportPangleWithStatus:status];
    if (self.currentAdIndex >= self.currentAds.count) {
        return;
    }
    
    BUDPasterContentView *currentAdView  = self.adViews[self.currentAdIndex];
    id <BUVideoAdReportor> reportor = currentAdView.videoAdReportor;
    BUDVideoView *view = currentAdView.customVideoView;
    switch (status) {
        case BUDVideoViewStatusPlaying: {
            NSTimeInterval duration = view.durationOfCurrentItem;
            [reportor didStartPlayVideoWithVideoDuration:duration];
        }
            break;
        case BUDVideoViewStatusPaused: {
            NSTimeInterval duration = view.watchedDurationOfCurrentItem;
            [reportor didPauseVideoWithCurrentDuration:duration];
        }
            break;
        case BUDVideoViewStatusStopped: {
            [reportor didFinishVideo];
        }
            break;
        case BUDVideoViewStatusResumed: {
            NSTimeInterval duration = view.watchedDurationOfCurrentItem;
            [reportor didResumeVideoWithCurrentDuration:duration];
        }
            break;
        case BUDVideoViewStatusAbort: {
            NSTimeInterval duration = view.watchedDurationOfCurrentItem;
            [reportor didBreakVideoWithCurrentDuration:duration];
        }
        default:
            break;
    }
}

- (void)dealloc
{
    
}
@end
