//
//  BUDNativeInterstitialViewController.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/8/10.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeInterstitialViewController.h"
#import <BUAdSDK/BUNativeAd.h>
#import "UIImageView+AFNetworking.h"
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "UIView+Draw.h"

static CGSize const dislikeSize = {15, 15};
static CGSize const logoSize = {20, 20};
#define leftEdge 20

@interface BUDNativeInterstitialViewController () <BUNativeAdDelegate>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *interstitialAdView;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) BUDNormalButton *refreshbutton;
@end

@implementation BUDNativeInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildupView];
}

- (void)buildupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.refreshbutton = [[BUDNormalButton alloc]initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.refreshbutton.showRefreshIncon = YES;
    [self.refreshbutton setTitle:@"展示原生插屏" forState:UIControlStateNormal];
    [self.refreshbutton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.refreshbutton];
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.backgroundView.hidden = YES;
    [self.view addSubview:self.backgroundView];
    
    self.interstitialAdView = [[UIImageView alloc] init];
    _interstitialAdView.contentMode =  UIViewContentModeScaleAspectFill;
    _interstitialAdView.clipsToBounds = YES;
    [self.backgroundView addSubview:_interstitialAdView];
    
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    self.dislikeButton = _relatedView.dislikeButton;
    [self.backgroundView addSubview:_dislikeButton];
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
        self.backgroundView.hidden = NO;
        for (UIView *view in self.interstitialAdView.subviews) {
            [view removeFromSuperview];
        }
        
        BUImage *adImage = nativeAd.data.imageAry.firstObject;
        CGFloat contentWidth = CGRectGetWidth(self.view.bounds) - 2*leftEdge;
        CGFloat imageViewHeight = contentWidth * adImage.height/ adImage.width;
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        self.interstitialAdView.frame = CGRectMake(leftEdge, (size.height-imageViewHeight)/2, contentWidth, imageViewHeight);
        if (adImage.imageURL.length) {
            [self.interstitialAdView setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
        }
        
        CGFloat margin = 5;
        UIImageView *logoImageView = self.relatedView.logoImageView;
        CGFloat logoIconX = CGRectGetWidth(self.interstitialAdView.bounds) - logoSize.width - margin;
        CGFloat logoIconY = imageViewHeight - logoSize.height - margin;
        logoImageView.frame = CGRectMake(logoIconX, logoIconY, logoSize.width, logoSize.height);
        [self.interstitialAdView addSubview:logoImageView];
        
        _dislikeButton.frame = CGRectMake(_interstitialAdView.right - dislikeSize.width - 5, _interstitialAdView.top + 5, dislikeSize.width, dislikeSize.height);
        
        [self.nativeAd registerContainer:self.interstitialAdView withClickableViews:nil];
        [self.relatedView refreshData:nativeAd];
        
        [self addAccessibilityIdentifierForQA];
    }
}

-(void)addAccessibilityIdentifierForQA{
    self.interstitialAdView.accessibilityIdentifier = @"interaction_view";
    self.relatedView.logoImageView.accessibilityIdentifier = @"interaction_logo";
    self.relatedView.dislikeButton.accessibilityIdentifier = @"interaction_close";
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error
{
    NSString *info = @"物料加载失败";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"native" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view
{
    NSLog(@"nativeAdDidClick");
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd
{
    NSLog(@"nativeAdDidBecomeVisible");
}

- (void)nativeAd:(BUNativeAd *)nativeAd  dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [self.interstitialAdView setImageWithURL:nil];
    self.backgroundView.hidden = YES;
}

-(void)buttonTapped:(UIButton *)sender {
    [self loadNativeAd];
}

@end
