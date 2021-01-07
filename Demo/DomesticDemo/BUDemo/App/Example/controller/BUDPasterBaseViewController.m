//
//  BUDPasterCustomPlayerViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/9/27.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDPasterBaseViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDVideoView.h"
#import "BUDPasterContentView.h"
#import "BUDSlotID.h"
@interface BUDPasterBaseViewController () <BUNativeAdsManagerDelegate, BUNativeAdDelegate, BUVideoAdViewDelegate>

@property (nonatomic, strong) NSTimer *changeTimer;

@property (nonatomic, strong) UILabel *toastLabel;

@property (nonatomic, strong) BUDPasterContentView *currentPasterContentView;
/// 是否继续播放，对自定义播放器有效 playerStyle == BUDPasterPlayerStyleCustom
@property (nonatomic, assign) BOOL shouldResume;
/// 剩余时长，在播放器遮挡时倒计时剩余时间，用于下次继续倒计时
@property (nonatomic, assign) NSTimeInterval remainingTime;
/// 定时器初始化时刻，在定时器暂停时计算剩余时间
@property (nonatomic, strong) NSDate *timerScheduleDate;
@end

@implementation BUDPasterBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self changeVideoAd];
    
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
    
    self.currentAds = [NSMutableArray array];
    self.adViews = [NSMutableArray array];
}

/// load ads from Pangle
- (void)loadAdData {
    self.currentAdIndex = 0;
    
    BUNativeAdsManager *nad = [BUNativeAdsManager new];
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.viewModel.slotID;
    slot.AdType = BUAdSlotAdTypePaster;
    slot.position = BUAdSlotPositionTop;
    slot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388]; // 690*388
    nad.adslot = slot;
    nad.delegate = self;
    [nad loadAdDataWithCount:3];
}

/// build views display in view controller
- (void)showAd {
    if (self.currentAdIndex >= self.currentAds.count) {
        return;
    }
    
    UIEdgeInsets safeEdge = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeEdge = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    } else {
        // Fallback on earlier versions
    }
    
    CGFloat topY = 0.0;
    
    BUNativeAd *ad = self.currentAds[self.currentAdIndex];
    BUDPasterContentView *currentAdView = self.adViews[self.currentAdIndex];
    self.currentPasterContentView = currentAdView;
    currentAdView.frame = CGRectMake(0, topY, self.view.frame.size.width, 0);
    [self.view addSubview:currentAdView];
    
    ad.delegate = self;
    if (self.playerStyle == BUDPasterPlayerStylePangle) {
        // SDK播放器的代理，此示例中用于定时器的resume
        self.currentPasterContentView.pangleVideoView.delegate = self;
    }
    // 注册点击事件
    [ad registerContainer:currentAdView withClickableViews:@[currentAdView.creativeBtn]];
    ad.rootViewController = self;
    // 核心代码
    [currentAdView refreshUIWithModel:ad];
    [currentAdView sizeToFit];
    
    // 监听播放状态
    [self pbu_addObserver];
    
    // 播放视频
    [self playAction:nil];
    
    [self timerFire];
}

#pragma mark - observer
- (void)pbu_addObserver {
    // 自定义播放器监听了播放状态
    if ([self.currentPasterContentView isVideoAd] && self.playerStyle == BUDPasterPlayerStyleCustom) {
        [self.currentPasterContentView.customVideoView addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)pbu_removeObserver {
    // 移除自定义播放器对播放状态的监听
    if (self.playerStyle == BUDPasterPlayerStyleCustom && [self.currentPasterContentView isVideoAd]) {
        [self.currentPasterContentView.customVideoView removeObserver:self forKeyPath:@"status"];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if (self.currentAdIndex >= self.currentAds.count) {
        return;
    }
    
    // observer the status change of video player, reporting infos to Pangle
    BUDVideoView *videoView = self.adViews[self.currentAdIndex].customVideoView;
    BOOL isVideoStatusChanged = object == videoView && [keyPath isEqualToString:@"status"];
    if (!isVideoStatusChanged) return;

    BUDVideoViewStatus status = (BUDVideoViewStatus)[change[NSKeyValueChangeNewKey] integerValue];
    // 状态改变是上传埋点
    // 开发者根据情况决定
    [self reportPangleWithStatus:status];
}

// 在子类中实现了此方法
- (void)reportPangleWithStatus:(BUDVideoViewStatus)status {
    
}

#pragma mark - Timer
- (void)timerFire {
    if (self.adViews.count == 0) {
        return;
    }

    NSTimeInterval interval = [self.currentPasterContentView pasterViewTimerInterval];
    self.remainingTime = interval;
    BUTimerWeakProxy *timerProxy = [BUTimerWeakProxy proxyWithTarget:self];
    self.changeTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:interval] interval:interval target:timerProxy selector:@selector(pasterTimerAction) userInfo:nil repeats:NO];
    self.timerScheduleDate = [NSDate date];
    [[NSRunLoop currentRunLoop] addTimer:self.changeTimer forMode:NSRunLoopCommonModes];
}

- (void)timerPause {
    if ([self.changeTimer isValid]) {
        [self.changeTimer invalidate];
        self.changeTimer = nil;
    }
}

- (void)timerResume {
    BUTimerWeakProxy *timerProxy = [BUTimerWeakProxy proxyWithTarget:self];
    self.changeTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:self.remainingTime] interval:self.remainingTime target:timerProxy selector:@selector(pasterTimerAction) userInfo:nil repeats:NO];
    self.timerScheduleDate = [NSDate date];
    [[NSRunLoop currentRunLoop] addTimer:self.changeTimer forMode:NSRunLoopCommonModes];
}

- (void)pasterTimerAction {
    if (self.currentAdIndex >= self.adViews.count) {
        return;
    }
    // 暂停播放
    [self pauseAction:nil];
    // 移除播放状态监听
    [self pbu_removeObserver];
    
    [self.currentPasterContentView removeFromSuperview];
    self.currentPasterContentView = nil;
    
    // 移除手势
    [self.currentAds[self.currentAdIndex] unregisterView];
    
    [self timerPause];
    self.currentAdIndex++;
    if (self.currentAdIndex >= self.currentAds.count) {
        self.currentAdIndex = 0;
    }
    [self showAd];
}

/// change other video ad.
- (void)changeVideoAd {
    [self loadAdData];
}

#pragma mark - BUVideoAdViewDelegate
// 点击SDK播放器，弹出落地页
- (void)videoAdViewDidClick:(BUVideoAdView *)videoAdView {
    [self showLandingPage];
}
// 点击SDK播放器，弹出落地页后关闭落地页
- (void)videoAdViewDidCloseOtherController:(BUVideoAdView *)videoAdView interactionType:(BUInteractionType)interactionType {
    [self hideLandingPage];
}

#pragma mark - BUNativeAdDelegate
// 点击自定义播放器，弹出落地页
- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    [self showLandingPage];
}

// 点击自定义播放器，弹出落地页后关闭落地页
- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    [self hideLandingPage];
}

- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    if (self.currentAds.count == 0 || self.currentAdIndex >= self.currentAds.count) {
        return;
    }
    
    // 移除播放器状态监听
    [self pbu_removeObserver];
    // 播放器移除
    [self.currentPasterContentView removeFromSuperview];
    self.currentPasterContentView = nil;
    [self.currentAds removeObjectAtIndex:self.currentAdIndex];
    [self.adViews removeObjectAtIndex:self.currentAdIndex];
    
    self.currentAdIndex++;
    if (self.currentAdIndex >= self.self.currentAds.count) {
        self.currentAdIndex = 0;
    }
    
    [self timerPause];
    [self showAd];
}
#pragma mark - BUNativeAdsManagerDelegate

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    
    BOOL notAllowed = NO;
    for (int i = 0; i < nativeAdDataArray.count; i++) {
        BUNativeAd *nativeAd = nativeAdDataArray[i];
        if (!nativeAd.data.allowCustomVideoPlayer && self.playerStyle == BUDPasterPlayerStyleCustom) {
            notAllowed = YES;
            continue;
        }

        BOOL isCustom = self.playerStyle == BUDPasterPlayerStyleCustom;
        BUDPasterContentView *pasterConainerView = [[BUDPasterContentView alloc] initWithPasterContentWith:isCustom];
        [self.currentAds addObject:nativeAd];
        [self.adViews addObject:pasterConainerView];
    }
    
    if (notAllowed) {
        [self showToastWithMessage:@"SOME AD NOT ALLOWED"];
    }
    
    [self showAd];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    [self showToastWithMessage:@"LOAD ERROR"];
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

#pragma mark - Landing Action
- (void)showLandingPage {
    if (self.currentAdIndex >= self.adViews.count) {
        return;
    }
    [self timerPause];
    self.remainingTime = self.remainingTime - fabs([self.timerScheduleDate timeIntervalSinceDate:[NSDate date]]);
    [self pauseAction:nil];
}

- (void)hideLandingPage {
    if (self.currentAdIndex >= self.adViews.count) {
        return;
    }
    self.shouldResume = YES;
    [self timerResume];
    [self playAction:nil];
}

#pragma mark - Actions
// 当前SDK播放器
- (BUVideoAdView *)currentPangleVideoView {
    BUVideoAdView *videoV = self.adViews[self.currentAdIndex].pangleVideoView;
    if (videoV.hidden) {
        return nil;
    }
    
    return videoV;
}
// 当前自定义播放器
- (BUDVideoView *)currentCustomVideoView {
    BUDVideoView *videoV = self.adViews[self.currentAdIndex].customVideoView;
    if (videoV.hidden) {
        return nil;
    }
    
    return videoV;
}

- (void)playAction:(UIButton *)sender {
    if (self.playerStyle == BUDPasterPlayerStyleCustom) {
        // 视频播放是否静音，媒体开发者自己决定
        if (self.shouldResume) {
            [[self currentCustomVideoView] resume];
            self.shouldResume = NO;
        } else {
            [[self currentCustomVideoView] play];
        }
    } else {
        // SDK 播放器，配置控制是否静音
        // SDK 播放器，配置控制是否自动播放
        [[self currentPangleVideoView] play];
    }
}

- (void)pauseAction:(UIButton *)sender {
    if (self.playerStyle == BUDPasterPlayerStyleCustom) {
        [[self currentCustomVideoView] pause];
    } else {
        [[self currentPangleVideoView] pause];
    }
}


- (BUDPasterPlayerStyle)playerStyle {
    return BUDPasterPlayerStyleCustom;
}


- (void)dealloc
{
    [self timerPause];
    
    [self pbu_removeObserver];
}
@end
