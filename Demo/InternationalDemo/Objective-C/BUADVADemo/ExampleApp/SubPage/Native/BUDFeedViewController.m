//
//  BUDFeedViewController.m
//  BUDemo
//
//  Created by chenren on 25/05/2017.
//  Copyright © 2017 chenren. All rights reserved.
//

#import "BUDFeedViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDNativeExampleView.h"

@interface BUDFeedViewController () <BUVideoAdViewDelegate,BUNativeAdDelegate>
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) BUDNativeExampleView *adView;
@end

@implementation BUDFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self creatExampleUI];
}

- (void)loadAd:(UIButton *)sender {
    if (_adView) {
        [_adView removeFromSuperview];
        _adView = nil;
    }
    
    _statusLabel.text = @"Loading......";
    
    BUAdSlot *adslot = [[BUAdSlot alloc] init];
    adslot.ID = @"980088216";
    adslot.AdType = BUAdSlotAdTypeFeed;
    adslot.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    
    _nativeAd = [[BUNativeAd alloc] initWithSlot:adslot];
    _nativeAd.delegate = self;
    _nativeAd.rootViewController = self;
    [_nativeAd loadAdData];
    
//    if you want get many ads at once reques,you can use BUNativeAdsManager
//    BUNativeAdsManager *manager = [BUNativeAdsManager new];
//    manager.adslot = adslot;
//    manager.delegate = self;
//    [manager loadAdDataWithCount:AdBumber];
}

- (void)showAd:(UIButton *)sender {
    if (!_nativeAd) {
        return;
    }
    
    if (_adView) {
        [_adView removeFromSuperview];
        _adView = nil;
    }
    
    _statusLabel.text = @"Tap left button to load Ad";

    BUDNativeExampleView *adView = [[NSBundle mainBundle]loadNibNamed:@"BUDNativeExampleView" owner:nil options:nil].firstObject;
    adView.nativeAd = _nativeAd;
    _adView = adView;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = [_adView getHeight:width];
    _adView.frame = CGRectMake(0, 0, width, height);
    _scrollView.contentSize = CGSizeMake(width, height);
    [_scrollView addSubview:_adView];
}

//#pragma mark - BUNativeAdsManagerDelegate
//
//- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
//
//}
//
//- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
//
//}
#pragma mark - BUNativeAdDelegate
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    _statusLabel.text = @"Ad loaded";
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    _statusLabel.text = @"Ad loaded fail";
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
  
}

- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
  
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
  
}

- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [_adView removeFromSuperview];
    _adView = nil;
}


#pragma mark - BUVideoAdViewDelegate

- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState {
    
  
}

- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *)error {
  
}

- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView {
  
}

- (void)videoAdViewDidClick:(BUVideoAdView *)videoAdView {
  
}

- (void)videoAdViewFinishViewDidClick:(BUVideoAdView *)videoAdView {
  
}


- (void)videoAdViewDidCloseOtherController:(BUVideoAdView *)videoAdView interactionType:(BUInteractionType)interactionType {
  
}
#pragma mark - ExampleUI
- (void)creatExampleUI {
    _statusLabel = [[UILabel alloc]init];
    [_statusLabel setFont:[UIFont systemFontOfSize:16]];
    [_statusLabel setTextColor:[UIColor redColor]];
    [_statusLabel setTextAlignment:NSTextAlignmentCenter];
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _statusLabel.text = @"Tap left button to load Ad";
    [self.view addSubview:_statusLabel];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_statusLabel]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[_statusLabel(25)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    
    UIButton *loadAd = [UIButton buttonWithType:UIButtonTypeSystem];
    loadAd.layer.borderWidth = 0.5;
    loadAd.layer.cornerRadius = 8;
    loadAd.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loadAd.translatesAutoresizingMaskIntoConstraints = NO;
    [loadAd addTarget:self action:@selector(loadAd:) forControlEvents:UIControlEventTouchUpInside];
    [loadAd setTitle:@"Load AD" forState:UIControlStateNormal];
    [loadAd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:loadAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[loadAd]-170-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loadAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_statusLabel]-20-[loadAd(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel,loadAd)]];
    
    UIButton *showAd = [UIButton buttonWithType:UIButtonTypeSystem];
    showAd.layer.cornerRadius = 8;
    showAd.translatesAutoresizingMaskIntoConstraints = NO;
    [showAd addTarget:self action:@selector(showAd:) forControlEvents:UIControlEventTouchUpInside];
    [showAd setTitle:@"showAd" forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [showAd setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:showAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[showAd(80)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(showAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_statusLabel]-20-[showAd(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel,showAd)]];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-250)];
    [self.view addSubview:_scrollView];
}

@end
