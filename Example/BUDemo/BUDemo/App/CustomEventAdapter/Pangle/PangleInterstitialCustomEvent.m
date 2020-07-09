#import "PangleInterstitialCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>
#import "PangleAdapterConfiguration.h"
#if __has_include("MoPub.h")
    #import "MPError.h"
    #import "MPLogging.h"
    #import "MoPub.h"
#endif

static const CGFloat PangleInterstitialRatio3to2 = 3.f / 2.f;
static const CGFloat PangleInterstitialRatio2to3 = 2.f / 3.f;

@interface PangleInterstitialCustomEvent () <BUNativeAdDelegate,BUNativeExpresInterstitialAdDelegate,BUFullscreenVideoAdDelegate,PangleNativeInterstitialViewDelegate>
@property (nonatomic, strong) BUNativeAd *nativeInterstitialAd;
@property (nonatomic, strong) PangleNativeInterstitialView *nativeInterstitialView;
@property (nonatomic, strong) BUNativeExpressInterstitialAd *expressInterstitialAd;
@property (nonatomic, strong) BUFullscreenVideoAd *fullScreenVideo;
@property (nonatomic, assign) BUAdSlotAdType adType;
@property (nonatomic, assign) PangleRenderMethod renderType;
@property (nonatomic, copy) NSString *adPlacementId;
@property (nonatomic, copy) NSString *appId;
@end

@implementation PangleInterstitialCustomEvent
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BOOL hasAdMarkup = adMarkup.length > 0;
    NSDictionary *renderInfo;
    self.appId = [info objectForKey:kPangleAppIdKey];
    if (BUCheckValidString(self.appId)) {
        [PangleAdapterConfiguration updateInitializationParameters:info];
    }
    self.adPlacementId = [info objectForKey:@"ad_placement_id"];
    if ([self.localExtras objectForKey:@"ad_placement_id"]) {
        self.adPlacementId = [self.localExtras objectForKey:@"ad_placement_id"];
    }
    self.adPlacementId = [info objectForKey:kPanglePlacementIdKey];
    if (!BUCheckValidString(self.adPlacementId)) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                             code:BUErrorCodeAdSlotEmpty userInfo:
                          @{NSLocalizedDescriptionKey: @"Invalid Pangle placement ID. Failing ad request. Ensure the ad placement id is valid on the MoPub dashboard."}];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    NSError *error = nil;
    renderInfo = [BUAdSDKManager AdTypeWithRit:self.adPlacementId error:&error];
    if (error) {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    
    self.adType = [[renderInfo objectForKey:@"adSlotType"] integerValue];
    self.renderType = [[renderInfo objectForKey:@"renderType"] integerValue];
    if (self.adType == BUAdSlotAdTypeInterstitial) {
        if (self.renderType == PangleRenderMethodExpress) {
            NSInteger width = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            self.expressInterstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.adPlacementId adSize:CGSizeMake(width, 0)];
            self.expressInterstitialAd.delegate = self;
            if (hasAdMarkup) {
                MPLogInfo(@"Loading Pangle express interstiital ad markup for Advanced Bidding");
                [self.expressInterstitialAd setMopubAdMarkUp:adMarkup];
            }else{
                MPLogInfo(@"Loading Pangle express interstiital ad");
                [self.expressInterstitialAd loadAdData];
            }
        } else {
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            CGFloat ratio;
            if (screenSize.height > screenSize.width) {
                ratio = PangleInterstitialRatio3to2;
            } else {
                ratio = PangleInterstitialRatio2to3;
            }
            BUSize *imgSize = [[BUSize alloc] init];
            imgSize.width = [UIScreen mainScreen].bounds.size.width;
            imgSize.height = imgSize.width * ratio;
            
            BUAdSlot *slot = [[BUAdSlot alloc] init];
            slot.ID = self.adPlacementId;
            slot.AdType = BUAdSlotAdTypeInterstitial;
            slot.position = BUAdSlotPositionTop;
            slot.imgSize = imgSize;
            slot.isSupportDeepLink = YES;
            slot.isOriginAd = YES;
            
            self.nativeInterstitialView = [[PangleNativeInterstitialView alloc] init];

            BUNativeAd *ad = [[BUNativeAd alloc] initWithSlot:slot];
            ad.delegate = self;
            self.nativeInterstitialAd = ad;
            if (hasAdMarkup) {
                MPLogInfo(@"Loading Pangle traditional interstiital ad markup for Advanced Bidding");
                [ad setMopubAdMarkUp:adMarkup];
            } else {
                MPLogInfo(@"Loading Pangle traditional interstiital ad");
                [ad loadAdData];
            }
        }
    } else if (self.adType == BUAdSlotAdTypeFullscreenVideo){
        self.fullScreenVideo = [[BUFullscreenVideoAd alloc] initWithSlotID:self.adPlacementId];
        self.fullScreenVideo.delegate = self;
        if (hasAdMarkup) {
            MPLogInfo(@"Loading Pangle full screen video ad markup for Advanced Bidding");
            [self.fullScreenVideo setMopubAdMarkUp:adMarkup];
        } else {
            MPLogInfo(@"Loading Pangle full screen video ad");
            [self.fullScreenVideo loadAdData];
        }
    }
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    if (self.adType == BUAdSlotAdTypeInterstitial) {
        if (self.renderType == PangleRenderMethodExpress) {
            if (!self.expressInterstitialAd || !self.expressInterstitialAd.adValid) {
                NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                                     code:BUErrorCodeNERenderResultError
                                                 userInfo:@{NSLocalizedDescriptionKey: @"Render error in showing Pangle express Interstitial."}];
            
                MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
                [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
            } else {
                MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
                [self.expressInterstitialAd showAdFromRootViewController:rootViewController];
            }
        } else {
            if (!self.nativeInterstitialView) {
                NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                                     code:BUErrorCodeNERenderResultError
                                                 userInfo:@{NSLocalizedDescriptionKey: @"Render error in showing Pangle traditional Interstitial."}];
                
                MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
                [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
            } else {
                MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
                [self.nativeInterstitialView showAdFromRootViewController:rootViewController delegate:self];
            }
        }
    } else if (self.adType == BUAdSlotAdTypeFullscreenVideo){
        if (!self.fullScreenVideo || !self.fullScreenVideo.adValid) {
            NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                                 code:BUErrorCodeNERenderResultError
                                             userInfo:@{NSLocalizedDescriptionKey: @"Render error in showing Pangle Full Screen Video."}];
            MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
            [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
        } else {
            MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
            [self.fullScreenVideo showAdFromRootViewController:rootViewController ritSceneDescribe:nil];
        }
    }
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

- (void)handleInvalidIdError{
    [BUAdSDKManager setAppID:self.appId];
}

#pragma mark - BUNativeAdDelegate - Traditional Interstitial

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    [self.nativeInterstitialView refreshUIWithAd:nativeAd];
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didLoadAd:self.nativeInterstitialAd];
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
    [self.delegate trackImpression];
}

#pragma mark PangleNativeInterstitialViewDelegate - Traditional Interstitial

- (void)nativeInterstitialAdWillClose:(BUNativeAd *)nativeAd {
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)nativeInterstitialAdDidClose:(BUNativeAd *)nativeAd {
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventDidDisappear:self];
}

#pragma mark BUNativeExpresInterstitialAdDelegate - Express Interstitial

- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    // The express interstitialAd instance need to attach to the view before fire the ad is loaded event.
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitialAd];
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
    [self.delegate trackImpression];
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillDisappear:self];
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventDidDisappear:self];
}

#pragma mark - BUFullscreenVideoAdDelegate - Full Screen Video

- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didLoadAd:fullscreenVideoAd];
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd {
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillAppear:self];
}

- (void)fullscreenVideoAdDidVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventDidAppear:self];
    [self.delegate trackImpression];
}

- (void)fullscreenVideoAdWillClose:(BUFullscreenVideoAd *)fullscreenVideoAd{
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    [self.delegate trackClick];
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    if (error) {
        MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    }
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {

}

- (NSString *) getAdNetworkId {
    return (BUCheckValidString(self.adPlacementId)) ? self.adPlacementId : @"";
}

@end
