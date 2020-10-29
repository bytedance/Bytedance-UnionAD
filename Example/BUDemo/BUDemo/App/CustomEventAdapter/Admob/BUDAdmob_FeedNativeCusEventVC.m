//
//  BUDAdmob_FeedNativeCusEventVC.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_FeedNativeCusEventVC.h"
#import "NSString+Json.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDSlotID.h"
#import <GoogleMobileAds/GADAdLoader.h>
#import <GoogleMobileAds/GADAdLoaderDelegate.h>
#import <GoogleMobileAds/GADUnifiedNativeAdDelegate.h>
#import <GoogleMobileAds/GADUnifiedNativeAd.h>

@interface BUDAdmob_FeedNativeCusEventVC () <GADAdLoaderDelegate,GADUnifiedNativeAdDelegate,GADVideoControllerDelegate,GADUnifiedNativeAdLoaderDelegate>

@property (nonatomic, strong, getter=getAdLoader) GADAdLoader *adLoader;
@property (nonatomic, strong) GADUnifiedNativeAdView *adView;
@end

@implementation BUDAdmob_FeedNativeCusEventVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setAdView];
    // load ads
    GADRequest *req = [GADRequest request];
    // this is set test device
    //req.testDevices = @[@"a71ad56d46ccbcd77254f4f0f5f2f80d"];
    [self.adLoader loadRequest:req];
}

- (void)setAdView {
    _adView = [[NSBundle mainBundle]loadNibNamed:@"UnifiedNativeAdView" owner:nil options:nil].lastObject;
    _adView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
    _adView.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 350)];
    [container addSubview:_adView];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_adView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_adView)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_adView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_adView)]];
    [self.view addSubview:container];
}

- (GADAdLoader *)getAdLoader {
    if (_adLoader == nil) {
        GADMultipleAdsAdLoaderOptions *multipleAdsOptions =
            [[GADMultipleAdsAdLoaderOptions alloc] init];
        GADNativeMuteThisAdLoaderOptions *muteOptions = [GADNativeMuteThisAdLoaderOptions new];
        multipleAdsOptions.numberOfAds = 1;
        _adLoader = [[GADAdLoader alloc] initWithAdUnitID:admob_native_UnitID rootViewController:self adTypes:@[kGADAdLoaderAdTypeUnifiedNative] options:@[multipleAdsOptions,muteOptions]];
        _adLoader.delegate = self;
    }
    return _adLoader;
}

#pragma mark - GADAdLoaderDelegate
- (void)adLoaderDidFinishLoading:(GADAdLoader *)adLoader {
    BUD_Log(@"%s",__func__);
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
    BUD_Log(@"%s",__func__);
    BUD_Log(@"%@",error);
}

#pragma mark - GADUnifiedNativeAdDelegate
- (void)nativeAdDidRecordImpression:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdDidRecordClick:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdWillPresentScreen:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdIsMuted:(GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

#pragma mark - GADUnifiedNativeAdLoaderDelegate
- (void)adLoader:(nonnull GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
    // set delegate and rootVC of nativeAd
    nativeAd.delegate = self;
    nativeAd.rootViewController = self;
    _adView.nativeAd = nativeAd;
    
    if ([_adView.headlineView isKindOfClass:[UILabel class]]) {
        UILabel *headlineView = (UILabel *)_adView.headlineView;
        headlineView.text = nativeAd.headline;
    }

    GADMediaContent *mediaContent = nativeAd.mediaContent;
    _adView.mediaView.mediaContent = mediaContent;
    if (mediaContent.hasVideoContent) {
        mediaContent.videoController.delegate = self;
    }
    if (nativeAd.mediaContent.aspectRatio > 0) {
        [_adView addConstraint:[NSLayoutConstraint constraintWithItem:_adView.mediaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_adView.mediaView attribute:NSLayoutAttributeWidth multiplier:1.0 / nativeAd.mediaContent.aspectRatio constant:0]];
    }

    if ([_adView.bodyView isKindOfClass:[UILabel class]]) {
        UILabel *bodyView = (UILabel *)_adView.bodyView;
        bodyView.text = nativeAd.body;
        bodyView.hidden = nativeAd.body==nil;
    }
    
    if ([_adView.imageView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)_adView.imageView;
        imageView.image = [self loadImage:nativeAd.images.firstObject.imageURL];
        imageView.hidden = nativeAd.images==nil;
    }
    
    if ([_adView.callToActionView isKindOfClass:[UIButton class]]) {
        UIButton *callToActionView = (UIButton *)_adView.callToActionView;
        [callToActionView setTitle:nativeAd.callToAction forState:UIControlStateNormal];
        callToActionView.hidden = nativeAd.callToAction==nil;
    }
    
    if ([_adView.iconView isKindOfClass:[UIImageView class]]) {
        UIImageView *iconView = (UIImageView *)_adView.iconView;
        iconView.image = [self loadImage:nativeAd.icon.imageURL];
        iconView.hidden = nativeAd.icon==nil;
    }
    
    if ([_adView.storeView isKindOfClass:[UILabel class]]) {
        UILabel *storeView = (UILabel *)_adView.storeView;
        storeView.text = nativeAd.store;
        storeView.hidden = nativeAd.store==nil;
    }

    if ([_adView.priceView isKindOfClass:[UILabel class]]) {
        UILabel *priceView = (UILabel *)_adView.priceView;
        priceView.text = nativeAd.price;
        priceView.hidden = nativeAd.price==nil;
    }
    
    if ([_adView.advertiserView isKindOfClass:[UILabel class]]) {
        UILabel *advertiserView = (UILabel *)_adView.advertiserView;
        advertiserView.text = nativeAd.advertiser;
        advertiserView.hidden = nativeAd.advertiser==nil;
    }

    // In order for the SDK to process touch events properly, user interaction should be disabled.
    _adView.callToActionView.userInteractionEnabled = false;
}

- (UIImage *)loadImage:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData: data];
    return image;
}

/// Tells the delegate that the video controller has began or resumed playing a video.
- (void)videoControllerDidPlayVideo:(nonnull GADVideoController *)videoController {
    BUD_Log(@"%s",__func__);
}

/// Tells the delegate that the video controller has paused video.
- (void)videoControllerDidPauseVideo:(nonnull GADVideoController *)videoController {
    BUD_Log(@"%s",__func__);
}

/// Tells the delegate that the video controller's video playback has ended.
- (void)videoControllerDidEndVideoPlayback:(nonnull GADVideoController *)videoController {
    BUD_Log(@"%s",__func__);
}

/// Tells the delegate that the video controller has muted video.
- (void)videoControllerDidMuteVideo:(nonnull GADVideoController *)videoController {
    BUD_Log(@"%s",__func__);
}

/// Tells the delegate that the video controller has unmuted video.
- (void)videoControllerDidUnmuteVideo:(nonnull GADVideoController *)videoController {
    BUD_Log(@"%s",__func__);
}

@end
