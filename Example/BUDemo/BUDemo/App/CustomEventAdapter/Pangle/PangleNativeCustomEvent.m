#import "PangleNativeCustomEvent.h"
#import "PangleNativeAdAdapter.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUAdSDK.h>
#import "PangleAdapterConfiguration.h"

#if __has_include("MoPub.h")
    #import "MoPub.h"
    #import "MPNativeAd.h"
    #import "MPLogging.h"
    #import "MPNativeAdError.h"
#endif

@interface PangleNativeCustomEvent () <BUNativeAdDelegate>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, copy) NSString *adPlacementId;
@property (nonatomic, copy) NSString *appId;
@end

@implementation PangleNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BOOL hasAdMarkup = adMarkup.length > 0;
    self.appId = [info objectForKey:kPangleAppIdKey];
    if (BUCheckValidString(self.appId)){
        [PangleAdapterConfiguration updateInitializationParameters:info];
    }
    self.adPlacementId = [info objectForKey:@"ad_placement_id"];
    if ([self.localExtras objectForKey:@"ad_placement_id"]) {
        self.adPlacementId = [self.localExtras objectForKey:@"ad_placement_id"];
    }
    self.adPlacementId = [info objectForKey:kPanglePlacementIdKey];
    if (!BUCheckValidString(self.adPlacementId)) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:BUErrorCodeAdSlotEmpty userInfo:@{NSLocalizedDescriptionKey: @"Invalid Pangle placement ID. Failing ad request. Ensure the ad placement id is valid on the MoPub dashboard."}];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.AdType = BUAdSlotAdTypeFeed;
    slot.position = BUAdSlotPositionTop;
    slot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    slot.isSupportDeepLink = YES;
    self.nativeAd = [[BUNativeAd alloc] initWithSlot:slot];
    self.nativeAd.delegate = self;
    
    self.nativeAd.adslot.ID = self.adPlacementId;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    
    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }
    self.nativeAd.rootViewController = rootViewController;
    if (hasAdMarkup) {
        MPLogInfo(@"Loading Pangle native ad markup for Advanced Bidding");
        [self.nativeAd setMopubAdMarkUp:adMarkup];
    } else {
        MPLogInfo(@"Loading Pangle native ad");
        [self.nativeAd loadAdData];
    }
}

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    [self.nativeAd loadAdData];
}

- (void)handleInvalidIdError{
    [BUAdSDKManager setAppID:self.appId];
}

#pragma mark - BUNativeAdDelegate

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    PangleNativeAdAdapter *adapter = [[PangleNativeAdAdapter alloc] initWithBUNativeAd:nativeAd placementId:self.adPlacementId];
    MPNativeAd *mp_nativeAd = [[MPNativeAd alloc] initWithAdAdapter:adapter];
    [self.delegate nativeCustomEvent:self didLoadAd:mp_nativeAd];
}

- (NSString *) getAdNetworkId {
    return BUCheckValidString(self.adPlacementId) ? self.adPlacementId : @"";
}

@end
