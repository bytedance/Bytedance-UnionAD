//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDAdmob_FeedNativeCusEventVC.h"
#import <GoogleMobileAds/GADAdLoader.h>
#import <GoogleMobileAds/GADAdLoaderDelegate.h>
#import <GoogleMobileAds/GADNativeAdDelegate.h>
#import <GoogleMobileAds/GADNativeAd.h>

@interface BUDAdmob_FeedNativeCusEventVC () <GADAdLoaderDelegate,GADNativeAdDelegate,GADVideoControllerDelegate,GADNativeAdLoaderDelegate>

@property (nonatomic, strong, getter=getAdLoader) GADAdLoader *adLoader;
@property (nonatomic, strong) GADNativeAdView *adView;
@property (nonatomic, strong) GADNativeAd *nativeAd;
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
        _adLoader = [[GADAdLoader alloc] initWithAdUnitID:@"ca-app-pub-5978360902462520/2635169913" rootViewController:self adTypes:@[kGADAdLoaderAdTypeNative] options:@[multipleAdsOptions,muteOptions]];
        _adLoader.delegate = self;
    }
    return _adLoader;
}

#pragma mark - GADNativeAdLoaderDelegate

/// Called when a native ad is received.
- (void)adLoader:(nonnull GADAdLoader *)adLoader didReceiveNativeAd:(nonnull GADNativeAd *)nativeAd {
    _nativeAd = nativeAd;
//    GADMediaContent *mediaContent = [[GADMediaContent alloc] init];
//    _nativeAd.mediaContent = mediaContent;
    _statusLabel.text = @"Ad loaded";
    
    
    
    
    
    
    
    _adView = [[NSBundle mainBundle]loadNibNamed:@"UnifiedNativeAdView" owner:nil options:nil].lastObject;
    [_adView.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:_scrollView];
    }
    _scrollView.contentSize = CGSizeZero;
    [_scrollView addSubview:_adView];
    
    
    _adView.mediaView.hidden = NO;
    [_adView.mediaView setMediaContent:_nativeAd.mediaContent];
    
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
        GADNativeAdImage *gadImage = _nativeAd.images.firstObject;
        if (gadImage.imageURL) {
            imageView.image = [self loadImage:gadImage.imageURL];
        } else if (gadImage.image) {
            imageView.image = gadImage.image;
        }
        imageView.hidden = _nativeAd.images==nil;
    }
    
    if ([_adView.callToActionView isKindOfClass:[UIButton class]]) {
        UIButton *callToActionView = (UIButton *)_adView.callToActionView;
        [callToActionView setTitle:_nativeAd.callToAction forState:UIControlStateNormal];
        callToActionView.hidden = _nativeAd.callToAction==nil;
    }
    
    if ([_adView.iconView isKindOfClass:[UIImageView class]]) {
        UIImageView *iconView = (UIImageView *)_adView.iconView;
        GADNativeAdImage *gadImage = _nativeAd.icon;
        if (gadImage.imageURL) {
            iconView.image = [self loadImage:gadImage.imageURL];
        } else if (gadImage.image) {
            iconView.image = gadImage.image;
        }
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

/// Called when adLoader fails to load an ad.
- (void)adLoader:(nonnull GADAdLoader *)adLoader
didFailToReceiveAdWithError:(nonnull NSError *)error {
    _statusLabel.text = @"Ad loaded fail";
}

/// Called after adLoader has finished loading.
- (void)adLoaderDidFinishLoading:(nonnull GADAdLoader *)adLoader {
    
}


@end
