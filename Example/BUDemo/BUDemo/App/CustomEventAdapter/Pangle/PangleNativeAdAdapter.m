#import "PangleNativeAdAdapter.h"
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import <BUFoundation/UIImageView+BUWebCache.h>
#if __has_include("MoPub.h")
    #import "MPNativeAd.h"
    #import "MPNativeAdConstants.h"
    #import "MPLogging.h"
#endif

@interface PangleNativeAdAdapter ()<BUNativeAdDelegate>
@property (nonatomic, strong) UIView *mediaView;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, copy) NSString *placementId;
@end

@implementation PangleNativeAdAdapter

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd placementId:(NSString *)placementId {
    if (self = [super init]) {
        self.properties = [self buNativeAdToDic:nativeAd];
        self.placementId = placementId;
    }
    return self;
}

- (NSDictionary *)buNativeAdToDic:(BUNativeAd *)nativeAd {
    self.nativeAd = nativeAd;
    self.nativeAd.delegate = self;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:nativeAd.data.AdTitle forKey:kAdTitleKey];
    [dict setValue:nativeAd.data.AdDescription forKey:kAdTextKey];
    [dict setValue:nativeAd.data.buttonText forKey:kAdCTATextKey];
    [dict setValue:nativeAd.data.icon.imageURL forKey:kAdIconImageKey];
    [dict setValue:@(nativeAd.data.score) forKey:kAdStarRatingKey];
    
    if (nativeAd.data.imageAry.count > 0) {
        [dict setValue:nativeAd.data.imageAry.firstObject.imageURL forKey:kAdMainImageKey];
    }
    
    self.mediaView = nil;
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    [self.relatedView refreshData:nativeAd];
    
    if (nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
        self.mediaView = self.relatedView.videoAdView;
    } else {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.mediaView = imageView;
        
        if (nativeAd.data.imageAry.count > 0) {
            BUImage *img = nativeAd.data.imageAry.firstObject;
            if (img.imageURL.length > 0) {
                [imageView sdBu_setImageWithURL:[NSURL URLWithString:img.imageURL] placeholderImage:nil];
            }
        } else {
            if (nativeAd.data.icon.imageURL.length > 0) {
                [imageView sdBu_setImageWithURL:[NSURL URLWithString:nativeAd.data.icon.imageURL] placeholderImage:nil];
            }
        }
    }
    
    [dict setValue:self.mediaView forKey:kAdMainMediaViewKey];
    [dict setValue:nativeAd forKey:@"bu_nativeAd"];
    return [dict copy];
}

#pragma mark - BUNativeAdDelegate
/**
 This method is called when native ad slot has been shown.
 */
- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    MPLogInfo(@"Pangle nativeAdDidBecomeVisible");
    if ([self.delegate respondsToSelector:@selector(nativeAdWillLogImpression:)]){
        MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], self.placementId);
        MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], self.placementId);
        [self.delegate nativeAdWillLogImpression:self];
    }
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    [self.delegate nativeAdDidDismissModalForAdapter:self];
}

/**
 This method is called when native ad is clicked.
 */
- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
    MPLogInfo(@"Pangle media nativeAdDidClick");
    if ([self.delegate respondsToSelector:@selector(nativeAdDidClick:)]) {
        MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], self.placementId);
        [self.delegate nativeAdDidClick:self];
        [self.delegate nativeAdWillPresentModalForAdapter:self];
        [self.delegate nativeAdWillLeaveApplicationFromAdapter:self];
    }
}

#pragma mark - <MPNativeAdAdapter>
- (void)willAttachToView:(UIView *)view {
    if (self.nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
        [self.nativeAd registerContainer:view withClickableViews:@[]];
    } else {
        [self.nativeAd registerContainer:view withClickableViews:@[]];
    }
}

- (void)willAttachToView:(UIView *)view withAdContentViews:(NSArray *)adContentViews {
    if (adContentViews.count > 0) {
        if (self.nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
            [self.nativeAd registerContainer:view withClickableViews:adContentViews];
        } else {
            [self.nativeAd registerContainer:view withClickableViews:adContentViews];
        }
    } else {
        [self willAttachToView:view];
    }
}

- (BOOL)enableThirdPartyClickTracking {
    return NO;
}

- (UIView *)mainMediaView {
    return self.mediaView;
}

- (UIView *)iconMediaView {
    return self.relatedView.logoImageView;
}

- (UIView *)privacyInformationIconView {
    return self.relatedView.logoADImageView;
}

@end
