//
//  BUDBannerViewController.m
//  BUDemo
//
//  Created by jiacy on 2017/6/6.
//  Copyright © 2017年 chenren. All rights reserved.
//

#import "BUDBannerViewController.h"
#import <BUAdSDK/BUBannerAdView.h>
#import "BUDAdManager.h"
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "UIView+Draw.h"
#import "NSString+LocalizedString.h"

@interface BUDBannerViewController () <BUBannerAdViewDelegate>
@property(nonatomic, strong) BUBannerAdView *bannerView;
@property(nonatomic, strong) BUDNormalButton *refreshbutton;
@property (nonatomic, strong) UISwitch *isCarouselSwitch;

@end

@implementation BUDBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //是否使用轮播banner的开关
    UILabel *carouselLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, NavigationBarHeight+50, 100, 30)];
    carouselLabel.text = [NSString localizedStringForKey:IsCarousel];
    carouselLabel.textColor = [UIColor blackColor];
    carouselLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:carouselLabel];
    
    self.isCarouselSwitch = [[UISwitch alloc] init];
    self.isCarouselSwitch.onTintColor = mainColor;
    self.isCarouselSwitch.frame = CGRectMake(120, carouselLabel.top, 51, 31);
    [self.view addSubview:self.isCarouselSwitch];
    
    //refresh Button
    _refreshbutton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, carouselLabel.bottom+50, 0, 0)];
    [_refreshbutton setTitle:[NSString localizedStringForKey:ShowBanner] forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
}

- (void)refreshBanner {
    [self loadBanner];
}

- (void)loadBanner {
    [self.bannerView removeFromSuperview];
    
    BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
    if (self.isCarouselSwitch.on) {
        self.bannerView = [[BUBannerAdView alloc] initWithSlotID:normal_banner_ID size:size rootViewController:self interval:30];
    } else {
        self.bannerView = [[BUBannerAdView alloc] initWithSlotID:normal_banner_ID size:size rootViewController:self];
    }
    const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat bannerHeight = screenWidth * size.height / size.width;
    self.bannerView.frame = CGRectMake(0, self.view.height-bannerHeight, screenWidth, bannerHeight);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
    [self.view addSubview:self.bannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  BUBannerAdViewDelegate implementation
- (void)bannerAdViewDidLoad:(BUBannerAdView * _Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    BUD_Log(@"%s",__func__);
}

- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    BUD_Log(@"%s",__func__);
}

- (void)bannerAdViewDidClick:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    BUD_Log(@"%s",__func__);
}

- (void)bannerAdView:(BUBannerAdView *_Nonnull)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    BUD_Log(@"%s",__func__);
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        if (self.bannerView == bannerAdView) {
            self.bannerView = nil;
        }
    }];
}

- (void)bannerAdViewDidCloseOtherController:(BUBannerAdView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"%s",__func__);
}

@end
