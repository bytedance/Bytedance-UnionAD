//
//  BUDCustomVideoPlayerViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/8/6.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDCustomVideoPlayerViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDVideoView.h"
#import "BUDCustomPlayerAdView.h"

@interface BUDCustomVideoPlayerViewController () <BUNativeAdsManagerDelegate>

@property(nonatomic, strong) UILabel *toastLabel;

@property(nonatomic, strong) BUNativeAd *currentAd;

@property(nonatomic, strong) BUDCustomPlayerAdView *adView;

@end

@implementation BUDCustomVideoPlayerViewController

- (void)dealloc {
    [self.adView.videoView removeObserver:self forKeyPath:@"status"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
    [self changeVideoAd];
}

/// load ads from Pangle
- (void)loadAdData {
    BUNativeAdsManager *nad = [BUNativeAdsManager new];
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.viewModel.slotID;
    slot.AdType = BUAdSlotAdTypeFeed;
    slot.position = BUAdSlotPositionTop;
    slot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388]; // 690*388
    nad.adslot = slot;
    nad.delegate = self;
    [nad loadAdDataWithCount:1];
}

/// build views display in view controller
- (void)setupViews {
    CGFloat width = self.view.frame.size.width;

    // 控制按钮
    NSArray<NSString *> *btnInfos = @[@"change", @"play", @"pause", @"resume"];
    CGFloat btnWidth = width / btnInfos.count;
    int btnIndex = 0;
    for (NSString *string in btnInfos) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:string forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithWhite:btnIndex * 1.f / btnInfos.count alpha:1]];
        btn.frame = CGRectMake(btnIndex * btnWidth, 0, btnWidth, 44);
        [self.view addSubview:btn];
        NSString *action = [NSString stringWithFormat:@"%@Action:", string];
        SEL sel = NSSelectorFromString(action);
        [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        btnIndex++;
    }
    // 创建广告视图
    BUDCustomPlayerAdView *adView = [[BUDCustomPlayerAdView alloc] initWithFrame:CGRectMake(0, 44.0, width, 0)];
    [self.view addSubview:adView];
    self.adView = adView;
    [self.adView.videoView addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    // 创建Toast视图
    UILabel *label = [[UILabel alloc] init];
    label.alpha = 0;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.layer.cornerRadius = 4.f;
    label.clipsToBounds = YES;
    [self.view addSubview:label];
    self.toastLabel = label;
}

- (void)showAd {
    BUNativeAd *ad = self.currentAd;
    if (!ad) {
        [self showToastWithMessage:@"NOT VIDEO AD"];
        return;
    }
    [ad registerContainer:self.adView withClickableViews:nil];
    ad.rootViewController = self;
    // 核心代码
    NSString *url = ad.data.videoUrl;
    if (url.length) {
        [self.adView refreshUIWithModel:ad];
        [self.adView sizeToFit];
    } else {
        [self showToastWithMessage:@"NOT ALLOWED"];
    }
}

/// change other video ad.
- (void)changeVideoAd {
    [self loadAdData];
}

#pragma mark - Report

- (void)reportPangleWithStatus:(BUDVideoViewStatus)status {
    id <BUVideoAdReportor> reportor = self.adView.videoAdReportor;
    NSString *slotId = self.currentAd.adslot.ID;
    BUDVideoView *view = self.adView.videoView;
    switch (status) {
        case BUDVideoViewStatusPlaying: {
            NSTimeInterval duration = view.durationOfCurrentItem;
            [reportor didStartPlayVideoWithVideoDuration:duration];
            [self showToastWithMessage:[NSString stringWithFormat:@"REPORT PLAY:%@ %.0lfs", slotId, duration]];
        }
            break;
        case BUDVideoViewStatusPaused: {
            NSTimeInterval duration = view.watchedDurationOfCurrentItem;
            [reportor didPauseVideoWithCurrentDuration:duration];
            [self showToastWithMessage:[NSString stringWithFormat:@"REPORT PAUSE:%@ %.0lfs", slotId, duration]];
        }
            break;
        case BUDVideoViewStatusStopped: {
            [reportor didFinishVideo];
            [self showToastWithMessage:[NSString stringWithFormat:@"REPORT STOP:%@", slotId]];
        }
            break;
        case BUDVideoViewStatusResumed: {
            NSTimeInterval duration = view.watchedDurationOfCurrentItem;
            [reportor didResumeVideoWithCurrentDuration:duration];
            [self showToastWithMessage:[NSString stringWithFormat:@"REPORT RESUME:%@ %.0lfs", slotId, duration]];
        }
            break;
        case BUDVideoViewStatusAbort: {
            NSTimeInterval duration = view.watchedDurationOfCurrentItem;
            [reportor didBreakVideoWithCurrentDuration:duration];
            [self showToastWithMessage:[NSString stringWithFormat:@"REPORT BREAK:%@ %.0lfs", slotId, duration]];
        }
        default:
            break;
    }
}

#pragma mark - BUNativeAdsManagerDelegate

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    // 上面只配置一个，所有只处理一个
    BUNativeAd *ad = nativeAdDataArray.firstObject;
    self.currentAd = [self isVideoAd:ad] ? ad : nil;
    [self showAd];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    [self showToastWithMessage:@"LOAD ERROR"];
}

#pragma mark - observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    // observer the status change of video player, reporting infos to Pangle
    BOOL isVideoStatusChanged = object == self.adView.videoView && [keyPath isEqualToString:@"status"];
    if (!isVideoStatusChanged) return;

    BUDVideoViewStatus status = (BUDVideoViewStatus)[change[NSKeyValueChangeNewKey] integerValue];
    [self reportPangleWithStatus:status];
}

#pragma mark - Toast

/// show toast in bottom of this page, duration 3 seconds, this section is not important to you.
- (void)showToastWithMessage:(NSString *)message {
    self.toastLabel.text = message;
    CGRect frame = self.toastLabel.frame;
    frame.size.width = self.view.frame.size.width - 40;
    self.toastLabel.frame = frame;
    [self.toastLabel sizeToFit];
    frame = self.toastLabel.frame;
    frame.size.width += 20;
    frame.size.height += 20;
    self.toastLabel.frame = frame;
    frame = self.toastLabel.bounds;
    frame = CGRectOffset(frame, (self.view.frame.size.width - frame.size.width) * 0.5f, self.view.frame.size.height - 30 - frame.size.height);
    self.toastLabel.frame = frame;
    self.toastLabel.alpha = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([message isEqualToString:self.toastLabel.text]) {
            self.toastLabel.alpha = 0;
        }
    });
}

#pragma mark - Actions

- (void)changeAction:(UIButton *)sender {
    [self changeVideoAd];
}

- (void)playAction:(UIButton *)sender {
    [self.adView.videoView play];
}

- (void)pauseAction:(UIButton *)sender {
    [self.adView.videoView pause];
}

- (void)resumeAction:(UIButton *)sender {
    [self.adView.videoView resume];
}

#pragma mark - Getter & Setter

- (BOOL)isVideoAd:(BUNativeAd *)ad {
    return ad.data.imageMode == BUFeedVideoAdModeImage || ad.data.imageMode == BUFeedVideoAdModePortrait || ad.data.imageMode == BUFeedADModeSquareVideo;
}

@end
