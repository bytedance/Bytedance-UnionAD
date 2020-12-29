//
//  BUDAdmob_FeedNativeCusEventVC.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_FeedNativeCusEventVC.h"
#import <GoogleMobileAds/GADAdLoader.h>
#import <GoogleMobileAds/GADAdLoaderDelegate.h>
#import <GoogleMobileAds/GADUnifiedNativeAdDelegate.h>
#import <GoogleMobileAds/GADUnifiedNativeAd.h>

@interface BUDAdmob_FeedNativeCusEventVC () <GADAdLoaderDelegate,GADUnifiedNativeAdDelegate,GADVideoControllerDelegate,GADUnifiedNativeAdLoaderDelegate>

@property (nonatomic, strong, getter=getAdLoader) GADAdLoader *adLoader;
@property (nonatomic, strong) GADUnifiedNativeAdView *adView;
@property (nonatomic, strong) GADUnifiedNativeAd *nativeAd;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation BUDAdmob_FeedNativeCusEventVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Native";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self loadAd];
}

- (void)loadAd {
    _statusLabel.text = @"Loading......";
    // load ads
    GADRequest *req = [GADRequest request];
    // this is set test device
    //req.testDevices = @[@"a71ad56d46ccbcd77254f4f0f5f2f80d"];
    [self.adLoader loadRequest:req];
}

- (void)showAd {
    
    _statusLabel.text = @"Tap left button to load Ad";
    
    [self creatAdView];
}

- (UIImage *)loadImage:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData: data];
    return image;
}

- (void)creatAdView {
    _adView = [[NSBundle mainBundle]loadNibNamed:@"UnifiedNativeAdView" owner:nil options:nil].lastObject;
    [_adView.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:_scrollView];
    }
    _scrollView.contentSize = CGSizeZero;
    [_scrollView addSubview:_adView];
    
    // set delegate and rootVC of nativeAd
    _nativeAd.delegate = self;
    _nativeAd.rootViewController = self;
    _adView.nativeAd = _nativeAd;
    
    if ([_adView.headlineView isKindOfClass:[UILabel class]]) {
        UILabel *headlineView = (UILabel *)_adView.headlineView;
        headlineView.text = _nativeAd.headline;
    }

    GADMediaContent *mediaContent = _nativeAd.mediaContent;
    _adView.mediaView.mediaContent = mediaContent;
    if (mediaContent.hasVideoContent) {
        mediaContent.videoController.delegate = self;
    }
    if (_nativeAd.mediaContent.aspectRatio > 0) {
        [_adView addConstraint:[NSLayoutConstraint constraintWithItem:_adView.mediaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_adView.mediaView attribute:NSLayoutAttributeWidth multiplier:1.0 / _nativeAd.mediaContent.aspectRatio constant:0]];
    }

    if ([_adView.bodyView isKindOfClass:[UILabel class]]) {
        UILabel *bodyView = (UILabel *)_adView.bodyView;
        bodyView.text = _nativeAd.body;
        bodyView.hidden = _nativeAd.body==nil;
    }
    
    if ([_adView.imageView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)_adView.imageView;
        imageView.image = [self loadImage:_nativeAd.images.firstObject.imageURL];
        imageView.hidden = _nativeAd.images==nil;
    }
    
    if ([_adView.callToActionView isKindOfClass:[UIButton class]]) {
        UIButton *callToActionView = (UIButton *)_adView.callToActionView;
        [callToActionView setTitle:_nativeAd.callToAction forState:UIControlStateNormal];
        callToActionView.hidden = _nativeAd.callToAction==nil;
    }
    
    if ([_adView.iconView isKindOfClass:[UIImageView class]]) {
        UIImageView *iconView = (UIImageView *)_adView.iconView;
        iconView.image = [self loadImage:_nativeAd.icon.imageURL];
        iconView.hidden = _nativeAd.icon==nil;
    }
    
    if ([_adView.storeView isKindOfClass:[UILabel class]]) {
        UILabel *storeView = (UILabel *)_adView.storeView;
        storeView.text = _nativeAd.store;
        storeView.hidden = _nativeAd.store==nil;
    }

    if ([_adView.priceView isKindOfClass:[UILabel class]]) {
        UILabel *priceView = (UILabel *)_adView.priceView;
        priceView.text = _nativeAd.price;
        priceView.hidden = _nativeAd.price==nil;
    }
    
    if ([_adView.advertiserView isKindOfClass:[UILabel class]]) {
        UILabel *advertiserView = (UILabel *)_adView.advertiserView;
        advertiserView.text = _nativeAd.advertiser;
        advertiserView.hidden = _nativeAd.advertiser==nil;
    }

    // In order for the SDK to process touch events properly, user interaction should be disabled.
    _adView.callToActionView.userInteractionEnabled = false;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object==_adView.imageView) {
        UIImage * new = (UIImage *)[change objectForKey:NSKeyValueChangeNewKey];
        CGSize imageSize = new.size;
        CGSize viewSize = self.view.frame.size;
        CGFloat w = viewSize.width;
        CGFloat h = ((w-20)*(imageSize.height/imageSize.width))+120;
        _scrollView.contentSize = CGSizeMake(w, h);
        _adView.frame = CGRectMake(0, 0, w, h);
    }
}

- (GADAdLoader *)getAdLoader {
    if (_adLoader == nil) {
        GADMultipleAdsAdLoaderOptions *multipleAdsOptions =
            [[GADMultipleAdsAdLoaderOptions alloc] init];
        GADNativeMuteThisAdLoaderOptions *muteOptions = [GADNativeMuteThisAdLoaderOptions new];
        multipleAdsOptions.numberOfAds = 1;
        _adLoader = [[GADAdLoader alloc] initWithAdUnitID:@"ca-app-pub-2547387438729744/8145972422" rootViewController:self adTypes:@[kGADAdLoaderAdTypeUnifiedNative] options:@[multipleAdsOptions,muteOptions]];
        _adLoader.delegate = self;
    }
    return _adLoader;
}

#pragma mark - GADAdLoaderDelegate
- (void)adLoaderDidFinishLoading:(GADAdLoader *)adLoader {
    
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
    _statusLabel.text = @"Ad loaded fail";
}

#pragma mark - GADUnifiedNativeAdDelegate
- (void)nativeAdDidRecordImpression:(nonnull GADUnifiedNativeAd *)nativeAd {
    
}

- (void)nativeAdDidRecordClick:(nonnull GADUnifiedNativeAd *)nativeAd {
    
}

- (void)nativeAdWillPresentScreen:(nonnull GADUnifiedNativeAd *)nativeAd {
    
}

- (void)nativeAdIsMuted:(GADUnifiedNativeAd *)nativeAd {
    
}

#pragma mark - GADUnifiedNativeAdLoaderDelegate
- (void)adLoader:(nonnull GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(nonnull GADUnifiedNativeAd *)nativeAd {
    _nativeAd = nativeAd;
    _statusLabel.text = @"Ad loaded";
    
    [self showAd];
}

/// Tells the delegate that the video controller has began or resumed playing a video.
- (void)videoControllerDidPlayVideo:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller has paused video.
- (void)videoControllerDidPauseVideo:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller's video playback has ended.
- (void)videoControllerDidEndVideoPlayback:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller has muted video.
- (void)videoControllerDidMuteVideo:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller has unmuted video.
- (void)videoControllerDidUnmuteVideo:(nonnull GADVideoController *)videoController {
    
}

@end
