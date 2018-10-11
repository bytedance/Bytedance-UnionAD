//
//  BUDnNativeBannerViewController.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/8/10.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeBannerViewController.h"
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUDislikeViewController.h>
#import "UIImageView+BUNetWorking.h"
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "BUDMacros.h"

static CGSize const dislikeSize = {15, 15};
static CGSize const logoSize = {20, 20};
static CGFloat const RefreshHeight = 36;


@interface BUDNativeBannerViewController () <BUNativeAdDelegate>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) UIButton *refreshbutton;
@property (nonatomic, strong) UIImageView *buLogoIcon;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;

@end

@implementation BUDNativeBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildupView];
    [self loadNativeAd];
}

- (void)buildupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, screenRect.size.width, screenRect.size.height - NavigationBarHeight - BottomMargin - RefreshHeight)];
    self.scrollView = sv;
    [self.view addSubview:sv];
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    self.refreshbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.refreshbutton];
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.refreshbutton.frame = CGRectMake(0, height - RefreshHeight - BottomMargin, width , RefreshHeight);
    [self.refreshbutton setBackgroundColor:[UIColor orangeColor]];
    [self.refreshbutton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.refreshbutton setTitle:NSLocalizedString(@"刷新NativeBanner广告", @"刷新NativeBanner广告")  forState:UIControlStateNormal];
    [self.refreshbutton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
}

- (void)loadNativeAd {
    
    if (!self.nativeAd) {
        BUSize *imgSize1 = [[BUSize alloc] init];
        imgSize1.width = 1080;
        imgSize1.height = 1920;
        
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        slot1.ID = self.viewModel.slotID;
        slot1.AdType = BUAdSlotAdTypeBanner;
        slot1.position = BUAdSlotPositionTop;
        slot1.imgSize = imgSize1;
        slot1.isSupportDeepLink = YES;
        slot1.isOriginAd = YES;
        
        BUNativeAd *nad = [BUNativeAd new];
        nad.adslot = slot1;
        nad.rootViewController = self;
        nad.delegate = self;
        self.nativeAd = nad;
        
        self.dislikeButton = self.relatedView.dislikeButton;
        [self.view addSubview:self.dislikeButton];
        
        self.buLogoIcon = self.relatedView.logoImageView;
    }
    [self.nativeAd loadAdData];
}

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    if (!nativeAd.data) { return; }
    if (!(nativeAd == self.nativeAd)) { return; }
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    BUMaterialMeta *materialMeta = nativeAd.data;
    [self.relatedView refreshData:nativeAd];
    CGFloat y = 0.0;
    CGFloat margin = 5;
    
    for (int i = 0; i < materialMeta.imageAry.count; i++) {
        BUImage *adImage = [materialMeta.imageAry objectAtIndex:i];
        CGFloat contentWidth = CGRectGetWidth(self.view.bounds);
        CGFloat imageViewHeight = contentWidth * adImage.height/ adImage.width;
        
        UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, contentWidth, imageViewHeight)];
        adImageView.contentMode =  UIViewContentModeScaleAspectFill;
        adImageView.clipsToBounds = YES;
        if (adImage.imageURL.length) {
            [adImageView setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
        }
        [self.scrollView addSubview:adImageView];
        
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:self.buLogoIcon.image];
        CGFloat logoIconX = CGRectGetWidth(adImageView.bounds) - logoSize.width - margin;
        CGFloat logoIconY = imageViewHeight - logoSize.height - margin;
        logoImageView.frame = CGRectMake(logoIconX, logoIconY, logoSize.width, logoSize.height);
        logoImageView.hidden = NO;
        [adImageView addSubview:logoImageView];
        
        [self.nativeAd registerContainer:adImageView withClickableViews:nil];
        
        y += imageViewHeight;
    }
    
    CGFloat dislikeX = CGRectGetWidth(self.view.bounds) - dislikeSize.width - margin;
    self.dislikeButton.frame = CGRectMake(dislikeX, NavigationBarHeight + margin, dislikeSize.width, dislikeSize.height);
    self.dislikeButton.hidden = NO;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, y);
    
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    NSString *info = @"物料加载失败";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"native" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    NSString *str = NSStringFromClass([view class]);
    NSString *info = [NSString stringWithFormat:@"点击了 %@", str];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    
}

- (void)nativeAd:(BUNativeAd *)nativeAd  dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    self.dislikeButton.hidden = YES;
}

#pragma mark - Events

- (void)buttonTapped:(UIButton *)sender {
    [self loadNativeAd];
}
@end
