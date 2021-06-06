//
//  BUDNativeInterstitialViewController.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/8/10.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeInterstitialViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>
//#import "UIImageView+WebCache.h"
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "UIView+Draw.h"
#import "NSString+LocalizedString.h"
#import "BUDCustomDislikeViewController.h"
#import "UIColor+DarkMode.h"

static CGSize const dislikeSize = {15, 15};
static CGSize const logoSize = {20, 20};
#define leftEdge 20
#define titleHeight 40

@interface BUDNativeInterstitialViewController () <BUNativeAdDelegate, BUDCustomDislikeDelegate>
@property (nonatomic, strong) BUNativeAd *nativeAd;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *whiteBackgroundView;
@property (nonatomic, strong) UIImageView *interstitialAdView;

@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong) UIImageView *logoImgeView;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *describeLable;
@property (nonatomic, strong) UIButton *dowloadButton;
@property (nonatomic, strong) BUDNormalButton *refreshbutton;
// 自定义dislike
@property (nonatomic, strong) UIButton *customDislikeButton;
@end

@implementation BUDNativeInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.haveRenderSwitchView = YES;
    [self buildupView];
    [self loadNativeAd];
}

- (void)buildupView {
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.refreshbutton = [[BUDNormalButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.75, 0, 0)];
    self.refreshbutton.showRefreshIncon = YES;
    [self.refreshbutton setTitle:[NSString localizedStringForKey:NativeInterstitial] forState:UIControlStateNormal];
    [self.refreshbutton addTarget:self action:@selector(refreshbuttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.refreshbutton];
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.backgroundView.hidden = YES;
    [self.view addSubview:self.backgroundView];
    
    self.whiteBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addSubview:self.whiteBackgroundView];
    
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLable.textAlignment = NSTextAlignmentLeft;
    self.titleLable.font = [UIFont systemFontOfSize:17];
    [self.whiteBackgroundView addSubview:self.titleLable];
    
    self.describeLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.describeLable.textAlignment = NSTextAlignmentLeft;
    self.describeLable.font = [UIFont systemFontOfSize:13];
    self.describeLable.textColor = [UIColor lightGrayColor];
    [self.whiteBackgroundView addSubview:self.describeLable];
    
    self.dowloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dowloadButton.backgroundColor = mainColor;
    self.dowloadButton.layer.cornerRadius = 5;
    self.dowloadButton.clipsToBounds = YES;
    [self.whiteBackgroundView addSubview:self.dowloadButton];
    
    self.interstitialAdView = [[UIImageView alloc] init];
    _interstitialAdView.contentMode =  UIViewContentModeScaleAspectFill;
    _interstitialAdView.userInteractionEnabled = YES;
    _interstitialAdView.clipsToBounds = YES;
    [self.whiteBackgroundView addSubview:_interstitialAdView];
    
    self.relatedView = [[BUNativeAdRelatedView alloc] init];
    self.logoImgeView = self.relatedView.logoImageView;
    [self.whiteBackgroundView addSubview:self.logoImgeView];
    
    if ([self validCustomDislike]) {
        self.customDislikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.customDislikeButton setTitle:@"反馈" forState:UIControlStateNormal];
        [self.customDislikeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.customDislikeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.customDislikeButton addTarget:self action:@selector(customDislikeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteBackgroundView addSubview:self.customDislikeButton];
    } else {
        [self.relatedView.dislikeButton setImage:[UIImage new] forState:UIControlStateNormal];
        [self.relatedView.dislikeButton setTitle:@"反馈" forState:UIControlStateNormal];
        [self.relatedView.dislikeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.relatedView.dislikeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.whiteBackgroundView addSubview:self.relatedView.dislikeButton];
    }
    
    self.dislikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dislikeButton setImage:[UIImage imageNamed:@"nativeDislike.png"] forState:UIControlStateNormal];
    [self.dislikeButton addTarget:self action:@selector(dislikeButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:_dislikeButton];
}

- (void)customDislikeBtnAction {
    BUDCustomDislikeViewController *dislikeVC = [[BUDCustomDislikeViewController alloc] initWithNativeAd:self.nativeAd];
    dislikeVC.delegate = self;
    [self.nativeAd.rootViewController presentViewController:dislikeVC animated:YES completion:nil];
}


- (void)layoutViewsWithimageViewHeight:(CGFloat)imageViewHeight {
    CGFloat whiteViewHeight = titleHeight + imageViewHeight + 10 + titleHeight + 10 + 30;
    self.whiteBackgroundView.frame = CGRectMake(leftEdge, (self.view.height - whiteViewHeight)/2, self.view.width-2*leftEdge, whiteViewHeight);
    
    self.titleLable.frame = CGRectMake(13, 0, self.whiteBackgroundView.width - 2*13 , titleHeight);
    self.describeLable.frame = CGRectMake(0, 0, self.whiteBackgroundView.width - 2*13 , titleHeight);
    self.dowloadButton.frame = CGRectMake(0, 0, 200, 30);
    
    CGFloat margin = 5;
    CGFloat logoIconX = CGRectGetWidth(self.whiteBackgroundView.bounds) - logoSize.width - margin;
    CGFloat logoIconY = self.whiteBackgroundView.height - logoSize.height - margin;
    self.logoImgeView.frame = CGRectMake(logoIconX, logoIconY, logoSize.width, logoSize.height);
    if ([self validCustomDislike]) {
        self.customDislikeButton.frame = CGRectMake(5, self.whiteBackgroundView.height - 30.0, 30.0, 30.0);
    } else {
        self.relatedView.dislikeButton.frame = CGRectMake(5, self.whiteBackgroundView.height - 30.0, 30.0, 30.0);
    }
    
    self.dislikeButton.frame = CGRectMake(self.whiteBackgroundView.right-dislikeSize.width , self.whiteBackgroundView.top-dislikeSize.height-10, dislikeSize.width, dislikeSize.height);
}

- (void)loadNativeAd {
    BUSize *imgSize1 = [[BUSize alloc] init];
    imgSize1.width = 1080;
    imgSize1.height = 1920;
    
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeInterstitial;
    slot1.imgSize = imgSize1;
    slot1.supportRenderControl = self.renderSwitchView.on;
    slot1.isOriginAd = YES;
    slot1.adSize = CGSizeMake(300, 300);
    
    BUNativeAd *nad = [[BUNativeAd alloc] initWithSlot:slot1];
    nad.rootViewController = self;
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    nad.delegate = self;
    self.nativeAd = nad;
    [nad loadAdData];
}

#pragma mark - BUNativeAdDelegate
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
}
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd view:(UIView *)view {

    [self bud_delegateLogWithSEL:_cmd msg:@""];
    if (nativeAd.data == nil || nativeAd.data.imageAry.count == 0) {
        return;
    }

    [self.interstitialAdView bud_removeAllSubViews];
    self.whiteBackgroundView.hidden = NO;
    self.backgroundView.hidden = NO;
    self.interstitialAdView.hidden = NO;
    
    if (view) {
        [self.interstitialAdView addSubview:view];
        CGFloat width = view.frame.size.width;
        CGFloat height = view.frame.size.height;
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - width) / 2.0f;
        CGFloat y = ([UIScreen mainScreen].bounds.size.height - height) / 2.0f;
        self.interstitialAdView.frame = CGRectMake(0, 0, width, height);
        self.whiteBackgroundView.frame = CGRectMake(x, y, width, height);
    } else {
        [self.interstitialAdView bud_removeAllSubViews];
        self.titleLable.text = nativeAd.data.AdTitle;
        
        BUImage *adImage = nativeAd.data.imageAry.firstObject;
        CGFloat contentWidth = CGRectGetWidth(self.view.bounds) - 2*leftEdge - 2*5;
        CGFloat imageViewHeight = contentWidth * adImage.height/ adImage.width;
        self.interstitialAdView.frame = CGRectMake(5, titleHeight, contentWidth, imageViewHeight);
        [self layoutViewsWithimageViewHeight:imageViewHeight];
        
        if (adImage.imageURL.length) {
            [self.interstitialAdView sd_setImageWithURL:[NSURL URLWithString:adImage.imageURL] placeholderImage:nil];
        }
        
        self.describeLable.frame = CGRectMake(13, self.interstitialAdView.bottom + 5, self.describeLable.width, self.describeLable.height);
        self.describeLable.text = nativeAd.data.AdDescription;
        
        self.dowloadButton.frame = CGRectMake((self.whiteBackgroundView.width - self.dowloadButton.width)/2, self.describeLable.bottom + 5, self.dowloadButton.width, self.dowloadButton.height);
        [self.dowloadButton setTitle:nativeAd.data.buttonText forState:UIControlStateNormal];
        
        [self.nativeAd registerContainer:self.whiteBackgroundView    withClickableViews:@[self.titleLable,self.interstitialAdView,self.describeLable,self.dowloadButton]];
        [self.relatedView refreshData:nativeAd];
        
        [self addAccessibilityIdentifier];
    }
    
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    [self bud_delegateLogWithSEL:_cmd error:error];
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
}

- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
}

- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterWords {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
    [self pbud_closeInterstitial];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
}

#pragma mark - BUDCustomDislikeDelegate
- (void)customDislike:(BUDCustomDislikeViewController *)controller withNativeAd:(BUNativeAd *)nativeAd didSelected:(BUDislikeWords *)dislikeWorkd {
    [self dislikeButtonTouchUpInside:nil];
}

#pragma mark - Action
-(void)refreshbuttonTouchUpInside:(UIButton *)sender {
    [self loadNativeAd];
}
- (void)dislikeButtonTouchUpInside:(id)sender {
    [self pbud_closeInterstitial];
}
#pragma mark - Private
- (void)pbud_closeInterstitial {
    self.backgroundView.hidden = YES;
    self.interstitialAdView.image = nil;
}

- (BOOL)validCustomDislike {
    // 是否自定义dislike面板
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"kCustomDislikeIsOn"];
}

#pragma mark addAccessibilityIdentifier
- (void)addAccessibilityIdentifier {
    self.interstitialAdView.accessibilityIdentifier = @"interaction_view";
    self.relatedView.logoImageView.accessibilityIdentifier = @"interaction_logo";
    self.dislikeButton.accessibilityIdentifier = @"interaction_close";
}


@end
