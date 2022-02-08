//
//  BUDAppOpenAdManager.m
//  BUDemo
//
//  Created by bytedance on 2022/1/17.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUDAppOpenAdManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDMacros.h"

@interface BUDAppOpenAdManager ()<BUAppOpenAdDelegate>

@end

@implementation BUDAppOpenAdManager
{
    // the app open ad
    BUAppOpenAd *_appOpenAd;
    // Keeps track of if an app open ad is loading.
    BOOL _isLoadingAd;
    // Keeps track of if an app open ad is showing.
    BOOL _isShowingAd;
    // Keeps track of the time when an app open ad was loaded to discard expired ad.
    NSDate *_loadTime;
    // Keeps track of app opend ad load orientation
    NSString *_slotId;
}

+ (nonnull BUDAppOpenAdManager *)sharedInstance {
  static BUDAppOpenAdManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[BUDAppOpenAdManager alloc] init];
  });
  return instance;
}

//MARK: -- public

- (void)loadAdWithSlotId:(nonnull NSString *)slotId {
    // Don't load ad if there is an unused ad or one is already loading
    if ([self _isAdAvailable] && _isLoadingAd) {
        [self _adloadComplete:nil];
        return;
    }
    _isLoadingAd = YES;
    _slotId = slotId;
    [self _logWithSEL:_cmd msg:@"start loading app open ad"];
    
    BUAdSlot *slot = BUAdSlot.new;
    slot.ID = slotId;
    BUAppOpenAd *appOpenAd = [[BUAppOpenAd alloc] initWithSlot:slot];
    appOpenAd.delegate = self;
    
    __weak typeof(self) weakself = self;
    [appOpenAd loadOpenAdWithTimeout:10
                    completionHandler:^(BUAppOpenAd * _Nullable appOpenAd, NSError * _Nullable error) {
        
        if (!weakself) {
            return;
        }
        __strong typeof(weakself) self = weakself;
        self->_isLoadingAd = NO;
        if (error) {
            self->_appOpenAd = nil;
            self->_loadTime = nil;
            [self _logWithSEL:_cmd msg:[NSString stringWithFormat:@"app open ad failed to load with error : %@",error]];
        }else {
            self->_appOpenAd = appOpenAd;
            self->_loadTime = [NSDate date];
            [self _logWithSEL:_cmd msg:@"app open ad loaded successfully"];
        }
        [self _adloadComplete:error];
    }];
}

- (void)showAdIfAvailable:(nonnull UIViewController *)viewController {
    if (_isShowingAd) {
        [self _logWithSEL:_cmd msg:@"app open ad is already showing"];
        return;
    }
    
    if (viewController.presentedViewController) {
        [self _logWithSEL:_cmd msg:@"viewController has presentedViewController"];
        return;
    }

    if (![self _isAdAvailable]) {
        [self loadAdWithSlotId:_slotId];
        [self _logWithSEL:_cmd msg:@"app open ad is not ready yet"];
        return;
    }
    
    [self _logWithSEL:_cmd msg:@"app open ad will be dispalyed"];
    _isShowingAd = YES;
    [_appOpenAd presentFromRootViewController:viewController];
}

//MARK: --BUAppOpenAdDelegate

- (void)didPresentForAppOpenAd:(BUAppOpenAd *)appOpenAd {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)didClickForAppOpenAd:(BUAppOpenAd *)appOpenAd {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)didClickSkipForAppOpenAd:(BUAppOpenAd *)appOpenAd {
    _appOpenAd = nil;
    _isShowingAd = NO;
    [self loadAdWithSlotId:_slotId];
    [self _logWithSEL:_cmd msg:nil];
}

- (void)countdownToZeroForAppOpenAd:(BUAppOpenAd *)appOpenAd {
    _appOpenAd = nil;
    _isShowingAd = NO;
    [self loadAdWithSlotId:_slotId];
    [self _logWithSEL:_cmd msg:nil];
}

//MARK: -- private
- (BOOL)_isAdAvailable {
    NSInteger timeoutHour = 24;
    NSTimeInterval timeIntervalBetweenNowAndLoadTime = [[NSDate date] timeIntervalSinceDate:_loadTime];
    double secondsPerHour = 3600.0;
    double intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour;
    BOOL isLessThanTimeoutHour = intervalInHours < timeoutHour;
    
    return _appOpenAd && isLessThanTimeoutHour;
}

- (void)_adloadComplete:(nullable NSError *)error {
    if (!_delegate) {
        return;
    }
    [_delegate adloadComplete:error];
    _delegate = nil;
}

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"BUDAppOpenAdManager | %@ | %@", NSStringFromSelector(sel), msg);
}

@end
