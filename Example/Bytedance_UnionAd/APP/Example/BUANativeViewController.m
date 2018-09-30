//
//  BUANativeViewController.m
//  BUAemo
//
//  Created by carl on 2017/8/15.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUANativeViewController.h"

#import <WMAdSDK/WMBannerAdView.h>
#import <WMAdSDK/WMNativeAd.h>
#import "UIImageView+WMNetworking.h"

@interface BUANativeViewController () <WMNativeAdDelegate>

@property (nonatomic, strong) UIView *customview;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *urlButton;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) UILabel *adLabel;
@property (nonatomic, strong) UIView *adView;

@property (nonatomic, strong) WMNativeAd *ad;

@property (nonatomic, strong) UIButton *button;

@end

@implementation BUANativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildupView];
    [self loadNativeAd];
}

- (void)buildupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Custom 视图测试
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    _customview = [[UIView alloc] initWithFrame:CGRectMake(20, 50, swidth - 40, 200)];
    _customview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_customview];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, swidth - 60, 30)];
    _infoLabel.backgroundColor = [UIColor magentaColor];
    _infoLabel.text = @"test ads";
    [_customview addSubview:_infoLabel];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 160, 120)];
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor redColor];
    [_customview addSubview:_imageView];
    
    _phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 60, -80, 30)];
    [_phoneButton setTitle:@"打电话" forState:UIControlStateNormal];
    _phoneButton.userInteractionEnabled = YES;
    _phoneButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_phoneButton];
    
    _downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 105, -80, 30)];
    [_downloadButton setTitle:@"下载跳转" forState:UIControlStateNormal];
    _downloadButton.userInteractionEnabled = YES;
    _downloadButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_downloadButton];
    
    _urlButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 150, -80, 30)];
    [_urlButton setTitle:@"URL跳转" forState:UIControlStateNormal];
    _urlButton.userInteractionEnabled = YES;
    _urlButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_urlButton];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    const CGFloat buttonHeight = 36;
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.button.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [self.button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [self.button.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [self.button.heightAnchor constraintEqualToConstant:buttonHeight];
    } else {
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        self.button.frame = CGRectMake(0, height - buttonHeight,width , buttonHeight);
    }
    
    [self.button setBackgroundColor:[UIColor orangeColor]];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:NSLocalizedString(@"刷新Native广告", @"刷新Native广告")  forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
}

- (void)loadNativeAd {
    WMNativeAd *nad = [WMNativeAd new];
    WMAdSlot *slot1 = [[WMAdSlot alloc] init];
    WMSize *imgSize1 = [[WMSize alloc] init];
    imgSize1.width = 1080;
    imgSize1.height = 1920;
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = WMAdSlotAdTypeFeed;
    slot1.position = WMAdSlotPositionTop;
    slot1.imgSize = imgSize1;
    slot1.isSupportDeepLink = YES;
    nad.adslot = slot1;
    
    nad.delegate = self;
    nad.rootViewController = self;
    
    self.ad = nad;
    
    [nad loadAdData];
}

- (void)nativeAdDidLoad:(WMNativeAd *)nativeAd {
    self.infoLabel.text = nativeAd.data.AdTitle;
    WMMaterialMeta *adMeta = nativeAd.data;
    if (adMeta != nil) {
        if (adMeta.imageAry.count > 0) {
            WMImage *adImage = adMeta.imageAry.firstObject;
            if (adImage.imageURL.length > 0) {
                [self.imageView setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
            }
        }
    }
    
    // Register UIView with the native ad; the whole UIView will be clickable.
    [nativeAd registerViewForInteraction:self.customview withClickableViews:@[self.infoLabel]];
    [nativeAd registerViewForInteraction:self.phoneButton withInteractionType:WMInteractionTypePhone];
    [nativeAd registerViewForInteraction:self.downloadButton withInteractionType:WMInteractionTypeDownload];
    [nativeAd registerViewForInteraction:self.urlButton withInteractionType:WMInteractionTypePage];
}

- (void)nativeAd:(WMNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    
}

- (void)nativeAdDidClick:(WMNativeAd *)nativeAd withView:(UIView *)view {
    NSString *str = NSStringFromClass([view class]);
    NSString *info = [NSString stringWithFormat:@"点击了 %@", str];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)nativeAdDidBecomeVisible:(WMNativeAd *)nativeAd {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)buttonTapped:(UIButton *)sender {
    [self loadNativeAd];
}

- (void)handleSingleTap {
    
}

- (void)handleSingleTap:(UIView *)view {
    
}

#pragma mark - Banner Delegate


- (void)bannerAdViewDidLoad:(WMBannerAdView * _Nonnull)bannerAdView WithAdmodel:(WMNativeAd *_Nullable)admodel {
    NSLog(@"--------- bannerAdViewDidLoad");
}

- (void)bannerAdViewDidBecomVisible:(WMBannerAdView *_Nonnull)bannerAdView WithAdmodel:(WMNativeAd *_Nullable)admodel {
    NSLog(@"--------- bannerAdViewDidBecomVisible");
}

- (void)bannerAdViewDidClick:(WMBannerAdView *_Nonnull)bannerAdView WithAdmodel:(WMNativeAd *_Nullable)admodel {
    NSLog(@"--------- bannerAdViewDidClick");
}

- (void)bannerAdView:(WMBannerAdView *_Nonnull)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    NSLog(@"--------- didLoadFailWithError");
}

@end
