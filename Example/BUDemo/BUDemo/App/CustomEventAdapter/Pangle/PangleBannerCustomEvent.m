#import "PangleBannerCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>
#import "PangleAdapterConfiguration.h"

#if __has_include("MoPub.h")
    #import "MPError.h"
    #import "MPLogging.h"
    #import "MoPub.h"
#endif

@interface PangleBannerCustomEvent ()<BUNativeExpressBannerViewDelegate,BUNativeAdDelegate>
@property (nonatomic, strong) BUNativeExpressBannerView *expressBannerView;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) PangleNativeBannerView *nativeBannerView;
@property (nonatomic, copy) NSString *adPlacementId;
@property (nonatomic, copy) NSString *appId;
@end

@implementation PangleBannerCustomEvent

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
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
                                             code:BUErrorCodeAdSlotEmpty
                                         userInfo:@{NSLocalizedDescriptionKey:
                                                        @"Invalid Pangle placement ID. Failing ad request. Ensure the ad placement id is valid on the MoPub dashboard."}];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    NSError *error = nil;
    renderInfo = [BUAdSDKManager AdTypeWithRit:self.adPlacementId error:&error];
    if (error) {
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }

    PangleRenderMethod renderType = [[renderInfo objectForKey:@"renderType"] integerValue];
    if (renderType == PangleRenderMethodExpress) {
        CGSize expressRequestSize = [self sizeForCustomEventInfo:size];
        self.expressBannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:self.adPlacementId rootViewController:self.delegate.viewControllerForPresentingModalView adSize:expressRequestSize IsSupportDeepLink:YES];
        self.expressBannerView.frame = CGRectMake(0, 0, expressRequestSize.width, expressRequestSize.height);
        self.expressBannerView.delegate = self;
        if (hasAdMarkup) {
            MPLogInfo(@"Loading Pangle express banner ad markup for Advanced Bidding");
            [self.expressBannerView setMopubAdMarkUp:adMarkup];
        } else {
            MPLogInfo(@"Loading Pangle express banner ad");
            [self.expressBannerView loadAdData];
        }
    } else {
        BUSize *imageSize = [[BUSize alloc] init];
        CGSize nativeRequestSize = [self sizeForCustomEventInfo:size];
        imageSize.width = nativeRequestSize.width;
        imageSize.height = nativeRequestSize.height;
        
        BUAdSlot *slot = [[BUAdSlot alloc] init];
        slot.ID = self.adPlacementId;
        slot.AdType = BUAdSlotAdTypeBanner;
        slot.position = BUAdSlotPositionTop;
        slot.imgSize = imageSize;
        slot.isSupportDeepLink = YES;
        slot.isOriginAd = YES;
        
        BUNativeAd *ad = [[BUNativeAd alloc] initWithSlot:slot];
        ad.rootViewController = self.delegate.viewControllerForPresentingModalView;
        ad.delegate = self;
        self.nativeAd = ad;
        self.nativeBannerView = [[PangleNativeBannerView alloc] initWithSize:size];
        if (hasAdMarkup) {
            MPLogInfo(@"Loading Pangle traditional banner ad markup for Advanced Bidding");
            [self.nativeAd setMopubAdMarkUp:adMarkup];
        }else{
            MPLogInfo(@"Loading Pangle traditional banner ad");
            [self.nativeAd loadAdData];
        }
    }
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

- (NSString *) getAdNetworkId {
    return (BUCheckValidString(self.adPlacementId)) ? self.adPlacementId : @"";
}

- (CGSize)sizeForCustomEventInfo:(CGSize)size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat renderRatio = height * 1.0 / width;
    if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner600_500].height * 1.0 /
        [BUSize sizeBy:BUProposalSize_Banner600_500].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner600_500].height /
                          [BUSize sizeBy:BUProposalSize_Banner600_500].width);//0.83
    } else if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner600_400].height * 1.0  /
               [BUSize sizeBy:BUProposalSize_Banner600_400].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner600_400].height /
                          [BUSize sizeBy:BUProposalSize_Banner600_400].width);//0.67
    } else if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner690_388].height * 1.0  /
               [BUSize sizeBy:BUProposalSize_Banner690_388].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner690_388].height /
                          [BUSize sizeBy:BUProposalSize_Banner690_388].width);//0.56
    } else if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner600_300].height * 1.0  /
               [BUSize sizeBy:BUProposalSize_Banner600_300].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner600_300].height /
                          [BUSize sizeBy:BUProposalSize_Banner600_300].width);//0.5
    } else if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner600_260].height * 1.0  /
               [BUSize sizeBy:BUProposalSize_Banner600_260].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner600_260].height /
                          [BUSize sizeBy:BUProposalSize_Banner600_260].width);//0.43
    } else if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner600_150].height * 1.0  /
              [BUSize sizeBy:BUProposalSize_Banner600_150].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner600_150].height /
                          [BUSize sizeBy:BUProposalSize_Banner600_150].width);//0.25
    } else if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner640_100].height * 1.0  /
              [BUSize sizeBy:BUProposalSize_Banner640_100].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner640_100].height /
                          [BUSize sizeBy:BUProposalSize_Banner640_100].width);//0.16
    } else if (renderRatio >= [BUSize sizeBy:BUProposalSize_Banner600_90].height * 1.0  /
              [BUSize sizeBy:BUProposalSize_Banner600_90].width) {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner600_90].height /
                          [BUSize sizeBy:BUProposalSize_Banner600_90].width);//0.15
    } else {
        return CGSizeMake(width, width *
                          [BUSize sizeBy:BUProposalSize_Banner600_90].height /
                          [BUSize sizeBy:BUProposalSize_Banner600_90].width);//0.15
    }
}

- (void)handleInvalidIdError{
    [BUAdSDKManager setAppID:self.appId];
}

#pragma mark - BUNativeExpressBannerViewDelegate - Express Banner

- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    // The express banner instance need to attach to the view before fire the ad is loaded event.
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate bannerCustomEvent:self didLoadAd:bannerAdView];
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error {
    MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self.delegate trackImpression];
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate trackClick];
    [self.delegate bannerCustomEventWillLeaveApplication:self];
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords {
    [bannerAdView removeFromSuperview];
}

#pragma mark - BUNativeAdDelegate - Traditional Banner

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    if (!nativeAd.data || !(nativeAd == self.nativeAd)){
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:BUErrorCodeNOAdError userInfo:@{NSLocalizedDescriptionKey: @"Invalid Pangle Data. Failing ad request."}];
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    self.nativeAd = nil;
    [self.nativeBannerView refreshUIWithAd:nativeAd];
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate bannerCustomEvent:self didLoadAd:self.nativeBannerView];
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    if (BUCheckValidString(self.appId) && error.code == BUUnionAppSiteRelError) {
        [self handleInvalidIdError];
    }
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate trackClick];
    [self.delegate bannerCustomEventWillLeaveApplication:self];
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    [self.delegate trackImpression];
}

- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)nativeAd:(BUNativeAd *)nativeAd  dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [self.nativeBannerView removeFromSuperview];
}

@end
