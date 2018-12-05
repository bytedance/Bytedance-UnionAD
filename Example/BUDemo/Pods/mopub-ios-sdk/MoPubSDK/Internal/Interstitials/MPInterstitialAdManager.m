//
//  MPInterstitialAdManager.m
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <objc/runtime.h>

#import "MPInterstitialAdManager.h"

#import "MPAdServerURLBuilder.h"
#import "MPAdTargeting.h"
#import "MPInterstitialAdController.h"
#import "MPInterstitialCustomEventAdapter.h"
#import "MPCoreInstanceProvider.h"
#import "MPInterstitialAdManagerDelegate.h"
#import "MPLogging.h"
#import "MPError.h"
#import "NSMutableArray+MPAdditions.h"
#import "NSDate+MPAdditions.h"
#import "NSError+MPAdditions.h"

@interface MPInterstitialAdManager ()

@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign, readwrite) BOOL ready;
@property (nonatomic, strong) MPBaseInterstitialAdapter *adapter;
@property (nonatomic, strong) MPAdServerCommunicator *communicator;
@property (nonatomic, strong) MPAdConfiguration *requestingConfiguration;
@property (nonatomic, strong) NSMutableArray<MPAdConfiguration *> *remainingConfigurations;
@property (nonatomic, assign) NSTimeInterval adapterLoadStartTimestamp;
@property (nonatomic, strong) MPAdTargeting * targeting;

- (void)setUpAdapterWithConfiguration:(MPAdConfiguration *)configuration;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation MPInterstitialAdManager

@synthesize loading = _loading;
@synthesize ready = _ready;
@synthesize delegate = _delegate;
@synthesize communicator = _communicator;
@synthesize adapter = _adapter;
@synthesize requestingConfiguration = _requestingConfiguration;

- (id)initWithDelegate:(id<MPInterstitialAdManagerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.communicator = [[MPAdServerCommunicator alloc] initWithDelegate:self];
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    [self.communicator cancel];
    [self.communicator setDelegate:nil];

    self.adapter = nil;
}

- (void)setAdapter:(MPBaseInterstitialAdapter *)adapter
{
    if (self.adapter != adapter) {
        [self.adapter unregisterDelegate];
        _adapter = adapter;
    }
}

#pragma mark - Public

- (void)loadAdWithURL:(NSURL *)URL
{
    if (self.loading) {
        MPLogWarn(@"Interstitial controller is already loading an ad. "
                  @"Wait for previous load to finish.");
        return;
    }

    self.loading = YES;
    [self.communicator loadURL:URL];
}


- (void)loadInterstitialWithAdUnitID:(NSString *)ID targeting:(MPAdTargeting *)targeting
{
    if (self.ready) {
        [self.delegate managerDidLoadInterstitial:self];
    } else {
        self.targeting = targeting;
        [self loadAdWithURL:[MPAdServerURLBuilder URLWithAdUnitID:ID
                                                         keywords:targeting.keywords
                                                 userDataKeywords:targeting.userDataKeywords
                                                         location:targeting.location]];
    }
}

- (void)presentInterstitialFromViewController:(UIViewController *)controller
{
    // Don't allow the ad to be shown if it isn't ready.
    if (!self.ready) {
        // We don't want to remotely log this event -- it's simply for publisher troubleshooting -- so use NSLog
        // rather than MPLog.
        NSLog(@"Interstitial ad view is not ready to be shown");
        return;
    }

    [self.adapter showInterstitialFromViewController:controller];
}

- (CLLocation *)location
{
    return [self.delegate location];
}

- (MPInterstitialAdController *)interstitialAdController
{
    return [self.delegate interstitialAdController];
}

- (id)interstitialDelegate
{
    return [self.delegate interstitialDelegate];
}

#pragma mark - MPAdServerCommunicatorDelegate

- (void)communicatorDidReceiveAdConfigurations:(NSArray<MPAdConfiguration *> *)configurations {
    self.remainingConfigurations = [NSMutableArray arrayWithArray:configurations];
    self.requestingConfiguration = [self.remainingConfigurations removeFirst];

    // There are no configurations to try. Consider this a clear response by the server.
    if (self.remainingConfigurations.count == 0 && self.requestingConfiguration == nil) {
        MPLogInfo(kMPClearErrorLogFormatWithAdUnitID, self.delegate.interstitialAdController.adUnitId);
        self.loading = NO;
        [self.delegate manager:self didFailToLoadInterstitialWithError:[MOPUBError errorWithCode:MOPUBErrorNoInventory]];
        return;
    }

    [self fetchAdWithConfiguration:self.requestingConfiguration];
}

- (void)fetchAdWithConfiguration:(MPAdConfiguration *)configuration
{
    MPLogInfo(@"Interstitial ad view is fetching ad network type: %@", configuration.networkType);

    if (configuration.adUnitWarmingUp) {
        MPLogInfo(kMPWarmingUpErrorLogFormatWithAdUnitID, self.delegate.interstitialAdController.adUnitId);
        self.loading = NO;
        [self.delegate manager:self didFailToLoadInterstitialWithError:[MOPUBError errorWithCode:MOPUBErrorAdUnitWarmingUp]];
        return;
    }

    if ([configuration.networkType isEqualToString:kAdTypeClear]) {
        MPLogInfo(kMPClearErrorLogFormatWithAdUnitID, self.delegate.interstitialAdController.adUnitId);
        self.loading = NO;
        [self.delegate manager:self didFailToLoadInterstitialWithError:[MOPUBError errorWithCode:MOPUBErrorNoInventory]];
        return;
    }

    if (configuration.adType != MPAdTypeInterstitial) {
        MPLogWarn(@"Could not load ad: interstitial object received a non-interstitial ad unit ID.");
        self.loading = NO;
        [self.delegate manager:self didFailToLoadInterstitialWithError:[MOPUBError errorWithCode:MOPUBErrorAdapterInvalid]];
        return;
    }

    [self setUpAdapterWithConfiguration:configuration];
}

- (void)communicatorDidFailWithError:(NSError *)error
{
    self.ready = NO;
    self.loading = NO;

    [self.delegate manager:self didFailToLoadInterstitialWithError:error];
}

- (void)setUpAdapterWithConfiguration:(MPAdConfiguration *)configuration;
{
    // Notify Ad Server of the adapter load. This is fire and forget.
    [self.communicator sendBeforeLoadUrlWithConfiguration:configuration];

    // Record the start time of the adapter load.
    self.adapterLoadStartTimestamp = NSDate.now.timeIntervalSince1970;

    if (configuration.customEventClass == nil) {
        [self adapter:nil didFailToLoadAdWithError:nil];
        return;
    }

    MPBaseInterstitialAdapter *adapter = [[MPInterstitialCustomEventAdapter alloc] initWithDelegate:self];
    self.adapter = adapter;
    [self.adapter _getAdWithConfiguration:configuration targeting:self.targeting];
}

#pragma mark - MPInterstitialAdapterDelegate

- (void)adapterDidFinishLoadingAd:(MPBaseInterstitialAdapter *)adapter
{
    self.remainingConfigurations = nil;
    self.ready = YES;
    self.loading = NO;

    // Record the end of the adapter load and send off the fire and forget after-load-url tracker.
    NSTimeInterval duration = NSDate.now.timeIntervalSince1970 - self.adapterLoadStartTimestamp;
    [self.communicator sendAfterLoadUrlWithConfiguration:self.requestingConfiguration adapterLoadDuration:duration adapterLoadResult:MPAfterLoadResultAdLoaded];

    [self.delegate managerDidLoadInterstitial:self];
}

- (void)adapter:(MPBaseInterstitialAdapter *)adapter didFailToLoadAdWithError:(NSError *)error
{
    // Record the end of the adapter load and send off the fire and forget after-load-url tracker
    // with the appropriate error code result.
    NSTimeInterval duration = NSDate.now.timeIntervalSince1970 - self.adapterLoadStartTimestamp;
    MPAfterLoadResult result = (error.isAdRequestTimedOutError ? MPAfterLoadResultTimeout : (adapter == nil ? MPAfterLoadResultMissingAdapter : MPAfterLoadResultError));
    [self.communicator sendAfterLoadUrlWithConfiguration:self.requestingConfiguration adapterLoadDuration:duration adapterLoadResult:result];

    // There are more ad configurations to try.
    if (self.remainingConfigurations.count > 0) {
        self.requestingConfiguration = [self.remainingConfigurations removeFirst];
        [self fetchAdWithConfiguration:self.requestingConfiguration];
    }
    // No more configurations to try. Send new request to Ads server to get more Ads.
    else if (self.requestingConfiguration.nextURL != nil) {
        self.ready = NO;
        self.loading = NO;
        [self loadAdWithURL:self.requestingConfiguration.nextURL];
    }
    // No more configurations to try and no more pages to load.
    else {
        self.ready = NO;
        self.loading = NO;

        MPLogInfo(kMPClearErrorLogFormatWithAdUnitID, self.delegate.interstitialAdController.adUnitId);
        [self.delegate manager:self didFailToLoadInterstitialWithError:[MOPUBError errorWithCode:MOPUBErrorNoInventory]];
    }
}

- (void)interstitialWillAppearForAdapter:(MPBaseInterstitialAdapter *)adapter
{
    [self.delegate managerWillPresentInterstitial:self];
}

- (void)interstitialDidAppearForAdapter:(MPBaseInterstitialAdapter *)adapter
{
    [self.delegate managerDidPresentInterstitial:self];
}

- (void)interstitialWillDisappearForAdapter:(MPBaseInterstitialAdapter *)adapter
{
    [self.delegate managerWillDismissInterstitial:self];
}

- (void)interstitialDidDisappearForAdapter:(MPBaseInterstitialAdapter *)adapter
{
    self.ready = NO;
    [self.delegate managerDidDismissInterstitial:self];
}

- (void)interstitialDidExpireForAdapter:(MPBaseInterstitialAdapter *)adapter
{
    self.ready = NO;
    [self.delegate managerDidExpireInterstitial:self];
}

- (void)interstitialDidReceiveTapEventForAdapter:(MPBaseInterstitialAdapter *)adapter
{
    [self.delegate managerDidReceiveTapEventFromInterstitial:self];
}

- (void)interstitialWillLeaveApplicationForAdapter:(MPBaseInterstitialAdapter *)adapter
{
    //noop
}

@end
