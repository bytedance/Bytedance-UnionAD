//
//  BUDNativeInterstitialViewController.m
//  BUAdSDKDemo
//
//  Created by 李盛 on 2018/8/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeInterstitialViewController.h"
#import <BUAdSDK/BUNativeAd.h>
#import "UIImageView+BUNetWorking.h"
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "BUDMacros.h"

static CGSize const dislikeSize = {15, 15};
static CGSize const logoSize = {20, 20};
static CGFloat const RefreshHeight = 36;

@interface BUDNativeInterstitialViewController () <BUNativeAdDelegate>
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIImageView *interstitialAdView;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) UIButton *refreshbutton;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@end

@implementation BUDNativeInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildupView];
    [self loadNativeAd];
}

- (void)buildupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    self.refreshbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.refreshbutton];
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.refreshbutton.frame = CGRectMake(0, height - RefreshHeight - BottomMargin, width, RefreshHeight);

    [self.refreshbutton setBackgroundColor:[UIColor orangeColor]];
    [self.refreshbutton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.refreshbutton setTitle:NSLocalizedString(@"刷新原生插屏广告", @"刷新原生插屏广告")  forState:UIControlStateNormal];
    [self.refreshbutton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
}

- (void)loadNativeAd {
    BUSize *imgSize1 = [[BUSize alloc] init];
    imgSize1.width = 1080;
    imgSize1.height = 1920;
    
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeInterstitial;
    slot1.position = BUAdSlotPositionTop;
    slot1.imgSize = imgSize1;
    slot1.isSupportDeepLink = YES;
    slot1.isOriginAd = YES;
    
    BUNativeAd *nad = [BUNativeAd new];
    nad.adslot = slot1;
    nad.rootViewController = self;
    nad.delegate = self;
    self.nativeAd = nad;
    [nad loadAdData];
}

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    if (!nativeAd.data) { return; }
    if (nativeAd.data.imageAry.count) {
        
        for (UIView *view in self.interstitialAdView.subviews) {
            [view removeFromSuperview];
        }
        
        BUImage *adImage = nativeAd.data.imageAry.firstObject;
        CGFloat contentWidth = CGRectGetWidth(self.view.bounds);
        CGFloat imageViewHeight = contentWidth * adImage.height/ adImage.width;
        
        self.interstitialAdView.frame = CGRectMake(0, NavigationBarHeight, contentWidth, imageViewHeight);
        self.interstitialAdView.contentMode =  UIViewContentModeScaleAspectFill;
        self.interstitialAdView.clipsToBounds = YES;
        if (adImage.imageURL.length) {
            [self.interstitialAdView setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
        }
        [self.view addSubview:self.interstitialAdView];
        
        CGFloat margin = 5;
        UIImageView *logoImageView = self.relatedView.logoImageView;
        CGFloat logoIconX = CGRectGetWidth(self.interstitialAdView.bounds) - logoSize.width - margin;
        CGFloat logoIconY = imageViewHeight - logoSize.height - margin;
        logoImageView.frame = CGRectMake(logoIconX, logoIconY, logoSize.width, logoSize.height);
        logoImageView.hidden = NO;
        [self.interstitialAdView addSubview:logoImageView];
        
        self.dislikeButton = self.relatedView.dislikeButton;
        CGFloat dislikeX = CGRectGetWidth(self.view.bounds) - dislikeSize.width - margin;
        self.dislikeButton.frame = CGRectMake(dislikeX, margin, dislikeSize.width, dislikeSize.height);
        self.dislikeButton.hidden = NO;
        [self.interstitialAdView addSubview:self.dislikeButton];
        
        [self.nativeAd registerContainer:self.interstitialAdView withClickableViews:nil];
        [self.relatedView refreshData:nativeAd];
    }
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error
{
    NSString *info = @"物料加载失败";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"native" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view
{
    NSString *str = NSStringFromClass([view class]);
    NSString *info = [NSString stringWithFormat:@"点击了 %@", str];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd
{
    NSLog(@"nativeAdDidBecomeVisible");
}

- (void)nativeAd:(BUNativeAd *)nativeAd  dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [self.interstitialAdView removeFromSuperview];
    self.dislikeButton.hidden = YES;
}

-(void)buttonTapped:(UIButton *)sender {
    [self loadNativeAd];
}


- (UIImageView *)interstitialAdView {
    if (!_interstitialAdView) {
        _interstitialAdView = [[UIImageView alloc] init];
        [self.view addSubview:_interstitialAdView];
    }
    return _interstitialAdView;
}
@end
