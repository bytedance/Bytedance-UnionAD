//
//  MPBannerAdManager.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPBannerAdManager.h"
#import "MPAdServerURLBuilder.h"
#import "MPAdTargeting.h"
#import "MPCoreInstanceProvider.h"
#import "MPBannerAdManagerDelegate.h"
#import "MPError.h"
#import "MPTimer.h"
#import "MPConstants.h"
#import "MPLogging.h"
#import "MPBannerCustomEventAdapter.h"
#import "NSMutableArray+MPAdditions.h"
#import "NSDate+MPAdditions.h"
#import "NSError+MPAdditions.h"

@interface MPBannerAdManager ()

@property (nonatomic, strong) MPAdServerCommunicator *communicator;
@property (nonatomic, strong) MPBaseBannerAdapter *onscreenAdapter;
@property (nonatomic, strong) MPBaseBannerAdapter *requestingAdapter;
@property (nonatomic, strong) UIView *requestingAdapterAdContentView;
@property (nonatomic, strong) MPAdConfiguration *requestingConfiguration;
@property (nonatomic, strong) MPAdTargeting *targeting;
@property (nonatomic, strong) NSMutableArray<MPAdConfiguration *> *remainingConfigurations;
@property (nonatomic, strong) MPTimer *refreshTimer;
@property (nonatomic, assign) BOOL adActionInProgress;
@property (nonatomic, assign) BOOL automaticallyRefreshesContents;
@property (nonatomic, assign) BOOL hasRequestedAtLeastOneAd;
@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;
@property (nonatomic, assign) NSTimeInterval adapterLoadStartTimestamp;

- (void)loadAdWithURL:(NSURL *)URL;
- (void)applicationWillEnterForeground;
- (void)scheduleRefreshTimer;
- (void)refreshTimerDidFire;

@end

@implementation MPBannerAdManager

@synthesize delegate = _delegate;
@synthesize communicator = _communicator;
@synthesize onscreenAdapter = _onscreenAdapter;
@synthesize requestingAdapter = _requestingAdapter;
@synthesize refreshTimer = _refreshTimer;
@synthesize adActionInProgress = _adActionInProgress;
@synthesize currentOrientation = _currentOrientation;

- (id)initWithDelegate:(id<MPBannerAdManagerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;

        self.communicator = [[MPAdServerCommunicator alloc] initWithDelegate:self];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:[UIApplication sharedApplication]];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:[UIApplication sharedApplication]];

        self.automaticallyRefreshesContents = YES;
        self.currentOrientation = MPInterfaceOrientation();
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.communicator cancel];
    [self.communicator setDelegate:nil];

    [self.refreshTimer invalidate];

    [self.onscreenAdapter unregisterDelegate];

    [self.requestingAdapter unregisterDelegate];

}

- (BOOL)loading
{
    return self.communicator.loading || self.requestingAdapter;
}

- (void)loadAdWithTargeting:(MPAdTargeting *)targeting
{
    if (!self.hasRequestedAtLeastOneAd) {
        self.hasRequestedAtLeastOneAd = YES;
    }

    if (self.loading) {
        MPLogWarn(@"Banner view (%@) is already loading an ad. Wait for previous load to finish.", [self.delegate adUnitId]);
        return;
    }

    self.targeting = targeting;
    [self loadAdWithURL:nil];
}

- (void)forceRefreshAd
{
    [self loadAdWithURL:nil];
}

- (void)applicationWillEnterForeground
{
    if (self.automaticallyRefreshesContents && self.hasRequestedAtLeastOneAd) {
        [self loadAdWithURL:nil];
    }
}

- (void)applicationDidEnterBackground
{
    [self pauseRefreshTimer];
}

- (void)pauseRefreshTimer
{
    if ([self.refreshTimer isValid]) {
        [self.refreshTimer pause];
    }
}

- (void)stopAutomaticallyRefreshingContents
{
    self.automaticallyRefreshesContents = NO;

    [self pauseRefreshTimer];
}

- (void)startAutomaticallyRefreshingContents
{
    self.automaticallyRefreshesContents = YES;

    if ([self.refreshTimer isValid]) {
        [self.refreshTimer resume];
    } else if (self.refreshTimer) {
        [self scheduleRefreshTimer];
    }
}

- (void)loadAdWithURL:(NSURL *)URL
{
    URL = [URL copy]; //if this is the URL from the requestingConfiguration, it's about to die...
    // Cancel the current request/requesting adapter
    self.requestingConfiguration = nil;
    [self.requestingAdapter unregisterDelegate];
    self.requestingAdapter = nil;
    self.requestingAdapterAdContentView = nil;

    [self.communicator cancel];

    URL = (URL) ? URL : [MPAdServerURLBuilder URLWithAdUnitID:[self.delegate adUnitId]
                                                     keywords:self.targeting.keywords
                                             userDataKeywords:self.targeting.userDataKeywords
                                                     location:self.targeting.location];

    [self.communicator loadURL:URL];
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation
{
    self.currentOrientation = orientation;
    [self.requestingAdapter rotateToOrientation:orientation];
    [self.onscreenAdapter rotateToOrientation:orientation];
}

#pragma mark - Internal

- (void)scheduleRefreshTimer
{
    [self.refreshTimer invalidate];
    NSTimeInterval timeInterval = self.requestingConfiguration ? self.requestingConfiguration.refreshInterval : DEFAULT_BANNER_REFRESH_INTERVAL;

    if (timeInterval > 0) {
        self.refreshTimer = [[MPCoreInstanceProvider sharedProvider] buildMPTimerWithTimeInterval:timeInterval
                                                                                       target:self
                                                                                     selector:@selector(refreshTimerDidFire)
                                                                                      repeats:NO];
        [self.refreshTimer scheduleNow];
        MPLogDebug(@"Scheduled the autorefresh timer to fire in %.1f seconds (%p).", timeInterval, self.refreshTimer);
    }
}

- (void)refreshTimerDidFire
{
    if (!self.loading && self.automaticallyRefreshesContents) {
        [self loadAdWithTargeting:self.targeting];
    }
}

- (BOOL)shouldScheduleTimerOnImpressionDisplay {
    // If `visibleImpressionTrackingEnabled` is set to `YES`, we
    // should schedule the timer only after the impression has fired.
    return self.requestingConfiguration.visibleImpressionTrackingEnabled;
}

- (void)fetchAdWithConfiguration:(MPAdConfiguration *)configuration {
    MPLogInfo(@"Banner ad view is fetching ad network type: %@", configuration.networkType);

    if (configuration.adType == MPAdTypeUnknown) {
        [self didFailToLoadAdapterWithError:[MOPUBError errorWithCode:MOPUBErrorServerError]];
        return;
    }

    if (configuration.adType == MPAdTypeInterstitial) {
        MPLogWarn(@"Could not load ad: banner object received an interstitial ad unit ID.");
        [self didFailToLoadAdapterWithError:[MOPUBError errorWithCode:MOPUBErrorAdapterInvalid]];
        return;
    }

    if (configuration.adUnitWarmingUp) {
        MPLogInfo(kMPWarmingUpErrorLogFormatWithAdUnitID, self.delegate.adUnitId);
        [self didFailToLoadAdapterWithError:[MOPUBError errorWithCode:MOPUBErrorAdUnitWarmingUp]];
        return;
    }

    if ([configuration.networkType isEqualToString:kAdTypeClear]) {
        MPLogInfo(kMPClearErrorLogFormatWithAdUnitID, self.delegate.adUnitId);
        [self didFailToLoadAdapterWithError:[MOPUBError errorWithCode:MOPUBErrorNoInventory]];
        return;
    }

    // Notify Ad Server of the ad fetch attempt. This is fire and forget.
    [self.communicator sendBeforeLoadUrlWithConfiguration:configuration];

    // Record the start time of the load.
    self.adapterLoadStartTimestamp = NSDate.now.timeIntervalSince1970;

    self.requestingAdapter = [[MPBannerCustomEventAdapter alloc] initWithConfiguration:configuration
                                                                              delegate:self];
    if (self.requestingAdapter == nil) {
        [self adapter:nil didFailToLoadAdWithError:nil];
        return;
    }

    [self.requestingAdapter _getAdWithConfiguration:configuration targeting:self.targeting containerSize:self.delegate.containerSize];
}

#pragma mark - <MPAdServerCommunicatorDelegate>

- (void)communicatorDidReceiveAdConfigurations:(NSArray<MPAdConfiguration *> *)configurations
{
    self.remainingConfigurations = [configurations mutableCopy];
    self.requestingConfiguration = [self.remainingConfigurations removeFirst];

    // There are no configurations to try. Consider this a clear response by the server.
    if (self.remainingConfigurations.count == 0 && self.requestingConfiguration == nil) {
        MPLogInfo(kMPClearErrorLogFormatWithAdUnitID, self.delegate.adUnitId);
        [self didFailToLoadAdapterWithError:[MOPUBError errorWithCode:MOPUBErrorNoInventory]];
        return;
    }

    [self fetchAdWithConfiguration:self.requestingConfiguration];
}

- (void)communicatorDidFailWithError:(NSError *)error
{
    [self didFailToLoadAdapterWithError:error];
}

- (void)didFailToLoadAdapterWithError:(NSError *)error
{
    [self.delegate managerDidFailToLoadAd];
    [self scheduleRefreshTimer];

    MPLogError(@"Banner view (%@) failed. Error: %@", [self.delegate adUnitId], error);
}

#pragma mark - <MPBannerAdapterDelegate>

- (MPAdView *)banner
{
    return [self.delegate banner];
}

- (id<MPAdViewDelegate>)bannerDelegate
{
    return [self.delegate bannerDelegate];
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return [self.delegate viewControllerForPresentingModalView];
}

- (MPNativeAdOrientation)allowedNativeAdsOrientation
{
    return [self.delegate allowedNativeAdsOrientation];
}

- (CLLocation *)location
{
    return self.targeting.location;
}

- (BOOL)requestingAdapterIsReadyToBePresented
{
    return !!self.requestingAdapterAdContentView;
}

- (void)presentRequestingAdapter
{
    if (!self.adActionInProgress && self.requestingAdapterIsReadyToBePresented) {
        [self.onscreenAdapter unregisterDelegate];
        self.onscreenAdapter = self.requestingAdapter;
        self.requestingAdapter = nil;

        [self.onscreenAdapter rotateToOrientation:self.currentOrientation];
        [self.delegate managerDidLoadAd:self.requestingAdapterAdContentView];
        [self.onscreenAdapter didDisplayAd];

        self.requestingAdapterAdContentView = nil;

        if (![self shouldScheduleTimerOnImpressionDisplay]) {
            [self scheduleRefreshTimer];
        }
    }
}

- (void)adapter:(MPBaseBannerAdapter *)adapter didFinishLoadingAd:(UIView *)ad
{
    if (self.requestingAdapter == adapter) {
        self.remainingConfigurations = nil;
        self.requestingAdapterAdContentView = ad;

        // Record the end of the adapter load and send off the fire and forget after-load-url tracker.
        NSTimeInterval duration = NSDate.now.timeIntervalSince1970 - self.adapterLoadStartTimestamp;
        [self.communicator sendAfterLoadUrlWithConfiguration:self.requestingConfiguration adapterLoadDuration:duration adapterLoadResult:MPAfterLoadResultAdLoaded];

        [self presentRequestingAdapter];
    }
}

- (void)adapter:(MPBaseBannerAdapter *)adapter didFailToLoadAdWithError:(NSError *)error
{
    // Record the end of the adapter load and send off the fire and forget after-load-url tracker
    // with the appropriate error code result.
    NSTimeInterval duration = NSDate.now.timeIntervalSince1970 - self.adapterLoadStartTimestamp;
    MPAfterLoadResult result = (error.isAdRequestTimedOutError ? MPAfterLoadResultTimeout : (adapter == nil ? MPAfterLoadResultMissingAdapter : MPAfterLoadResultError));
    [self.communicator sendAfterLoadUrlWithConfiguration:self.requestingConfiguration adapterLoadDuration:duration adapterLoadResult:result];

    if (self.requestingAdapter == adapter) {
        // There are more ad configurations to try.
        if (self.remainingConfigurations.count > 0) {
            self.requestingConfiguration = [self.remainingConfigurations removeFirst];
            [self fetchAdWithConfiguration:self.requestingConfiguration];
        }
        // No more configurations to try. Send new request to Ads server to get more Ads.
        else if (self.requestingConfiguration.nextURL != nil) {
            [self loadAdWithURL:self.requestingConfiguration.nextURL];
        }
        // No more configurations to try and no more pages to load.
        else {
            MPLogInfo(kMPClearErrorLogFormatWithAdUnitID, self.delegate.adUnitId);
            [self didFailToLoadAdapterWithError:[MOPUBError errorWithCode:MOPUBErrorNoInventory]];
        }
    }

    if (self.onscreenAdapter == adapter && adapter != nil) {
        // the onscreen adapter has failed.  we need to:
        // 1) remove it
        // 2) and note that there can't possibly be a modal on display any more
        [self.delegate invalidateContentView];
        [self.onscreenAdapter unregisterDelegate];
        self.onscreenAdapter = nil;
        if (self.adActionInProgress) {
            [self.delegate userActionDidFinish];
            self.adActionInProgress = NO;
        }
        if (self.requestingAdapterIsReadyToBePresented) {
            [self presentRequestingAdapter];
        } else {
            [self loadAdWithTargeting:self.targeting];
        }
    }
}

- (void)adapter:(MPBaseBannerAdapter *)adapter didTrackImpressionForAd:(UIView *)ad {
    if (self.onscreenAdapter == adapter && [self shouldScheduleTimerOnImpressionDisplay]) {
        [self scheduleRefreshTimer];
    }
}

- (void)userActionWillBeginForAdapter:(MPBaseBannerAdapter *)adapter
{
    if (self.onscreenAdapter == adapter) {
        self.adActionInProgress = YES;
        [self.delegate userActionWillBegin];
    }
}

- (void)userActionDidFinishForAdapter:(MPBaseBannerAdapter *)adapter
{
    if (self.onscreenAdapter == adapter) {
        [self.delegate userActionDidFinish];
        self.adActionInProgress = NO;
        [self presentRequestingAdapter];
    }
}

- (void)userWillLeaveApplicationFromAdapter:(MPBaseBannerAdapter *)adapter
{
    if (self.onscreenAdapter == adapter) {
        [self.delegate userWillLeaveApplication];
    }
}

@end


