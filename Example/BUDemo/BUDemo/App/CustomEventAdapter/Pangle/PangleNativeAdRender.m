#import "PangleNativeAdRender.h"

#if __has_include("MoPub.h")
    #import "MPLogging.h"
    #import "MPNativeAdAdapter.h"
    #import "MPNativeAdConstants.h"
    #import "MPNativeAdError.h"
    #import "MPNativeAdRendererConfiguration.h"
    #import "MPNativeAdRendererImageHandler.h"
    #import "MPNativeAdRendering.h"
    #import "MPNativeAdRenderingImageLoader.h"
    #import "MPNativeView.h"
    #import "MPStaticNativeAdRendererSettings.h"
    #import "MPURLRequest.h"
    #import "MPHTTPNetworkSession.h"
    #import "MPMemoryCache.h"
#endif
#import "PangleNativeAdAdapter.h"

@interface PangleNativeAdRender ()<MPNativeAdRendererImageHandlerDelegate>

@property (nonatomic, strong) UIView<MPNativeAdRendering> *adView;
@property (nonatomic, strong) PangleNativeAdAdapter *adapter;
@property (nonatomic, strong) Class renderingViewClass;
@property (nonatomic, strong) MPNativeAdRendererImageHandler *rendererImageHandler;
@property (nonatomic, assign) BOOL adViewInViewHierarchy;

@end

@implementation PangleNativeAdRender

- (instancetype)initWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings {
    if (self = [super init]) {
        MPStaticNativeAdRendererSettings *settings = (MPStaticNativeAdRendererSettings *)rendererSettings;
        _renderingViewClass = settings.renderingViewClass;
        _viewSizeHandler = [settings.viewSizeHandler copy];
        _rendererImageHandler = [MPNativeAdRendererImageHandler new];
        _rendererImageHandler.delegate = self;
    }
    
    return self;
}

+ (MPNativeAdRendererConfiguration *)rendererConfigurationWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings {
    MPNativeAdRendererConfiguration *config = [[MPNativeAdRendererConfiguration alloc] init];
    config.rendererClass = [self class];
    config.rendererSettings = rendererSettings;
    config.supportedCustomEvents = @[@"PangleNativeCustomEvent"];
    
    return config;
}

- (UIView *)retrieveViewWithAdapter:(id<MPNativeAdAdapter>)adapter error:(NSError **)error {
    if (!adapter || ![adapter isKindOfClass:[PangleNativeAdAdapter class]]) {
        if (error) {
          *error = MPNativeAdNSErrorForRenderValueTypeError();
        }
        return nil;
    }
    
    self.adapter = adapter;
    self.adapter = (PangleNativeAdAdapter *)adapter;
    if ([self.renderingViewClass respondsToSelector:@selector(nibForAd)]) {
        self.adView = (UIView<MPNativeAdRendering> *)[[[self.renderingViewClass nibForAd] instantiateWithOwner:nil options:nil] firstObject];
    } else {
        self.adView = [[self.renderingViewClass alloc] init];
    }
    self.adView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    if ([self.adView respondsToSelector:@selector(nativeMainTextLabel)]) {
        self.adView.nativeMainTextLabel.text = [adapter.properties objectForKey:kAdTextKey];
    }
    
    if ([self.adView respondsToSelector:@selector(nativeTitleTextLabel)]) {
        self.adView.nativeTitleTextLabel.text = [adapter.properties objectForKey:kAdTitleKey];
    }
    
    if ([self hasIconView]) {
        UIView *iconView = [self.adapter iconMediaView];
        UIView *iconImageView = [self.adView nativeIconImageView];
        iconView.frame = iconImageView.bounds;
        iconView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        iconImageView.userInteractionEnabled = YES;
        
        [iconImageView addSubview:iconView];
    }
    
    if ([self shouldLoadMainImageView]) {
        UIView *mediaView = [self.adapter mainMediaView];
        UIView *mainImageView = [self.adView nativeMainImageView];
        mediaView.frame = mainImageView.bounds;
        mediaView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        mainImageView.userInteractionEnabled = YES;
        [mainImageView addSubview:mediaView];
    }
    
    if ([self shouldLoadMainVideoView]) {
        UIView *mediaView = [self.adapter mainMediaView];
        UIView *mainVideoView = [self.adView nativeVideoView];
        mediaView.frame = mainVideoView.bounds;
        mediaView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        mainVideoView.userInteractionEnabled = YES;
        [mainVideoView addSubview:mediaView];
    }

    if ([self.adView respondsToSelector:@selector(nativeCallToActionTextLabel)] && self.adView.nativeCallToActionTextLabel) {
        self.adView.nativeCallToActionTextLabel.text = [adapter.properties objectForKey:kAdCTATextKey];
    }
    
    if ([self.adView respondsToSelector:@selector(nativePrivacyInformationIconImageView)]) {
        [self.adView.nativePrivacyInformationIconImageView
         addSubview:self.adapter.privacyInformationIconView];
        self.adapter.privacyInformationIconView.frame = self.adView.nativePrivacyInformationIconImageView.bounds;
        self.adapter.privacyInformationIconView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }

    // See if the ad contains a star rating and notify the view if it does.
    if ([self.adView respondsToSelector:@selector(layoutStarRating:)]) {
        NSNumber *starRatingNum = [adapter.properties objectForKey:kAdStarRatingKey];
        if ([starRatingNum isKindOfClass:[NSNumber class]] && starRatingNum.floatValue >= kStarRatingMinValue && starRatingNum.floatValue <= kStarRatingMaxValue) {
            [self.adView layoutStarRating:starRatingNum];
        }
    }
    return self.adView;
}

- (BOOL)shouldLoadMainImageView {
    return [self.adapter respondsToSelector:@selector(mainMediaView)]
    && [self.adapter mainMediaView]
    && [self.adView respondsToSelector:@selector(nativeMainImageView)];
}

- (BOOL)shouldLoadMainVideoView {
    return [self.adapter respondsToSelector:@selector(mainMediaView)]
    && [self.adapter mainMediaView]
    && [self.adView respondsToSelector:@selector(nativeVideoView)];
}


- (BOOL)hasIconView {
    return [self.adapter respondsToSelector:@selector(iconMediaView)]
    && [self.adapter iconMediaView]
    && [self.adView respondsToSelector:@selector(nativeIconImageView)];
}

- (void)onPrivacyIconTapped {
    if ([self.adapter respondsToSelector:@selector(displayContentForDAAIconTap)]) {
        [self.adapter displayContentForDAAIconTap];
    }
}

- (void)adViewWillMoveToSuperview:(UIView *)superview {
    self.adViewInViewHierarchy = (superview != nil);
    
    if (superview) {
        // Only handle the loading of the icon image if the adapter doesn't already have a view for it.
        if (![self hasIconView] && [self.adapter.properties objectForKey:kAdIconImageKey] && [self.adView respondsToSelector:@selector(nativeIconImageView)]) {
            [self.rendererImageHandler loadImageForURL:[NSURL URLWithString:[self.adapter.properties objectForKey:kAdIconImageKey]] intoImageView:self.adView.nativeIconImageView];
        }
        
        // Only handle the loading of the main image if the adapter doesn't already have a view for it.
        if (!([self.adapter respondsToSelector:@selector(mainMediaView)] && [self.adapter mainMediaView])) {
            if ([self.adapter.properties objectForKey:kAdMainImageKey] && [self.adView respondsToSelector:@selector(nativeMainImageView)]) {
                [self.rendererImageHandler loadImageForURL:[NSURL URLWithString:[self.adapter.properties objectForKey:kAdMainImageKey]] intoImageView:self.adView.nativeMainImageView];
            }
        }
        
        // Layout custom assets here as the custom assets may contain images that need to be loaded.
        if ([self.adView respondsToSelector:@selector(layoutCustomAssetsWithProperties:imageLoader:)]) {
            // Create a simplified image loader for the ad view to use.
            MPNativeAdRenderingImageLoader *imageLoader = [[MPNativeAdRenderingImageLoader alloc] initWithImageHandler:self.rendererImageHandler];
            [self.adView layoutCustomAssetsWithProperties:self.adapter.properties imageLoader:imageLoader];
        }
    }
}

#pragma mark - MPNativeAdRendererImageHandlerDelegate

- (BOOL)nativeAdViewInViewHierarchy {
    return self.adViewInViewHierarchy;
}

@end
