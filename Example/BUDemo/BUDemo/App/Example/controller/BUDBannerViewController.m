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

@interface BUDBannerViewController () <BUBannerAdViewDelegate>
@property(nonatomic, strong) BUBannerAdView *bannerView;
@property(nonatomic, strong) BUBannerAdView *carouselBannerView;

@property(nonatomic, strong) BUDNormalButton *refreshbutton;
@property(nonatomic, strong) BUDNormalButton *refreshCarouselbutton;
@end

@implementation BUDBannerViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ScrollView as self.view
    CGRect screenRect = [UIScreen mainScreen].bounds;
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    sv.contentSize = CGSizeMake(screenRect.size.width, screenRect.size.height * 2);
    sv.backgroundColor = [UIColor whiteColor];
    self.view = sv;
    
    //refresh Button
    CGSize size = [UIScreen mainScreen].bounds.size;
    _refreshbutton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height *0.2, 0, 0)];
    _refreshbutton.showRefreshIncon = YES;
    [_refreshbutton setTitle:[NSString localizedStringForKey:ShowBanner] forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
    //refresh Button
    _refreshCarouselbutton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height *0.6, 0, 0)];
    _refreshCarouselbutton.showRefreshIncon = YES;
    [_refreshCarouselbutton setTitle:[NSString localizedStringForKey:ShowScrollBanner] forState:UIControlStateNormal];
    [_refreshCarouselbutton addTarget:self action:@selector(refreshCarouselBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshCarouselbutton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, size.height*0.4-0.5, size.width, 0.5)];
    line.backgroundColor = BUD_RGB(0xf2, 0xf2, 0xf2);
    [self.view addSubview:line];
}

//refresh按钮
-  (void)refreshBanner {
    if (self.bannerView == nil) {
        BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
        self.bannerView = [[BUBannerAdView alloc] initWithSlotID:self.viewModel.slotID size:size rootViewController:self];
        const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        
        CGFloat bannerHeight = screenWidth * size.height / size.width;
        self.bannerView.frame = CGRectMake(0, 10, screenWidth, bannerHeight);
        self.bannerView.delegate = self;
        [self.view addSubview:self.bannerView];
    }
    [self.bannerView loadAdData];
}

//refreshCarousel按钮
-  (void)refreshCarouselBanner {
    if (self.carouselBannerView == nil) {
        BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
        self.carouselBannerView = [[BUBannerAdView alloc] initWithSlotID:self.viewModel.slotID size:size rootViewController:self interval:30];
        const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        const CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
        
        BUD_Log(@"%f", [UIApplication sharedApplication].statusBarFrame.size.height);
        CGFloat bannerHeight = screenWidth * size.height / size.width;
        self.carouselBannerView.frame = CGRectMake(0, screenHeight*0.4, screenWidth, bannerHeight);
        self.carouselBannerView.delegate = self;
        [self.view addSubview:self.carouselBannerView];
    }
    [self.carouselBannerView loadAdData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  BUBannerAdViewDelegate implementation

- (void)bannerAdViewDidLoad:(BUBannerAdView * _Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    BUD_Log(@"banner data load sucess");
}

- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    BUD_Log(@"banner becomVisible");
}

- (void)bannerAdViewDidClick:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    BUD_Log(@"banner AdViewDidClick");
}

- (void)bannerAdView:(BUBannerAdView *_Nonnull)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"banner data load faiule");
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        if (self.bannerView == bannerAdView) {
            self.bannerView = nil;
        }
        if (self.carouselBannerView == bannerAdView) {
            self.carouselBannerView = nil;
        }
    }];
}

- (void)bannerAdViewDidCloseOtherController:(BUBannerAdView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSString *str = @"";
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:[NSString stringWithFormat:@"%s",__func__] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
}

@end
