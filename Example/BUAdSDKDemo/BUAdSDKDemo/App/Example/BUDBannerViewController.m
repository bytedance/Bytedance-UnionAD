//
//  BUDBannerViewController.m
//  BUDemo
//
//  Created by jiacy on 2017/6/6.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDBannerViewController.h"
#import <BUAdSDK/BUBannerAdView.h>
#import "BUDAdManager.h"

@interface BUDBannerViewController () <BUBannerAdViewDelegate>
@property (nonatomic, strong) BUBannerAdView *bannerView;
@property (nonatomic, strong) UIButton *refreshbutton;

@end

@implementation BUDBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ScrollView as self.view
    CGRect screenRect = [UIScreen mainScreen].bounds;
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    sv.contentSize = CGSizeMake(screenRect.size.width, screenRect.size.height * 2);
    sv.backgroundColor = [UIColor whiteColor];
    self.view = sv;
    
    //refresh Button
    _refreshbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 50)];
    [_refreshbutton setTitle:@"刷新Banner" forState:UIControlStateNormal];
    _refreshbutton.userInteractionEnabled = YES;
    _refreshbutton.backgroundColor = [UIColor purpleColor];
    [_refreshbutton addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
    // BUBannerAdView测试
    [self refreshBanner];

}

//refresh按钮
-  (void)refreshBanner {
    if (self.bannerView == nil) {
        BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
        self.bannerView = [[BUBannerAdView alloc] initWithSlotID:self.viewModel.slotID size:size rootViewController:self];
        [self.bannerView loadAdData];
        const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        
        CGFloat bannerHeight = screenWidth * size.height / size.width;
        self.bannerView.frame = CGRectMake(0, 50, screenWidth, bannerHeight);
        self.bannerView.delegate = self;
        [self.view addSubview:self.bannerView];
    }
    [self.bannerView loadAdData];
}

#pragma mark -  BUBannerAdViewDelegate implementation

- (void)bannerAdViewDidLoad:(BUBannerAdView * _Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    NSLog(@"***********banner load**************");
    [self.refreshbutton setTitle:@"已刷新，再刷新" forState:UIControlStateNormal];
}

- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    
}

- (void)bannerAdViewDidClick:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    
}

- (void)bannerAdView:(BUBannerAdView *_Nonnull)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, error.localizedDescription);
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
