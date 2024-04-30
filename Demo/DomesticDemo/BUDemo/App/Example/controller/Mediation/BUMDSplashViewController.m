//
//  BUMDSplashViewController.m
//  BUDemo
//
//  Created by ByteDance on 2022/9/26.
//  Copyright © 2022 bytedance. All rights reserved.
//


#import "BUMDSplashViewController.h"
#import "BUDSplashContainerViewController.h"
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "UIView+Draw.h"
#import "BUDAnimationTool.h"
#import "UIColor+DarkMode.h"


@interface BUMDSplashViewController () <BUMSplashAdDelegate, BUSplashCardDelegate, BUSplashZoomOutDelegate>

@property (nonatomic, strong) BUSplashAd *splashAd;
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUDNormalButton *button1;

@property (nonatomic, assign) CGRect splashFrame;

@property (nonatomic, strong) BUSplashZoomOutView *zoomOutView;

@end

@implementation BUMDSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildView];

    self.splashFrame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y * 0.8);
    self.button1.center = CGPointMake(self.view.center.x, self.button.center.y + 80);
}

- (void)buildView {
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.button.showRefreshIncon = YES;
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:[NSString localizedStringForKey:Splash]  forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    self.button1 = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.6, 0, 0)];
    self.button1.showRefreshIncon = YES;
    [self.button1 addTarget:self action:@selector(button1Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 setTitle:[NSString localizedStringForKey:@"显示底部bottomView"]  forState:UIControlStateNormal];
    [self.view addSubview:self.button1];
}

- (void)buildupDefaultSplashView {
    // 配置广告信息项，以下仅展示部分功能
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.viewModel.slotID;
    
    // [可选]配置：兜底方案，在配置拉取失败时会按照该方案进行广告加载
    slot.mediation.splashUserData = ({
        BUMSplashUserData *splashUserData = [[BUMSplashUserData alloc] init];
        splashUserData.adnName = @"baidu";// adn的名字，请使用如下值 'pangle','baidu','gdt','ks'，其他值可能导致无法加载广告
        splashUserData.rit = @"1111111";// adn对应代码位
        splashUserData.appID = @"222222";// adn对应appID
        splashUserData.appKey = @"333333";// adn对应appKey, 没有时可不传
        splashUserData;
    });
    
    _splashAd = [[BUSplashAd alloc] initWithSlot:slot adSize:[UIScreen mainScreen].bounds.size];
    // // 配置：回调代理对象。不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    _splashAd.delegate = self;
    _splashAd.cardDelegate = self;
    _splashAd.zoomOutDelegate = self;
    
    // [可选]配置：是否展示卡片视图，默认不开启，仅支持穿山甲广告
    _splashAd.supportCardView = YES;
    // [可选]配置：是否支持ZoomOut
    _splashAd.supportZoomOutView = YES;
}

- (void)buildupSplashViewWithBottomView {
    [self buildupDefaultSplashView];
    UIView *redCustomBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    redCustomBottomView.backgroundColor = UIColor.redColor;
    // [可选]配置：自定义底部视图，可以设置LOGO等，仅部分ADN支持
    _splashAd.mediation.customBottomView = redCustomBottomView;
}

- (void)button1Tapped:(UIButton *)sender {
    [self buildupSplashViewWithBottomView];
    [_splashAd loadAdData];
}

- (void)buttonTapped:(UIButton *)sender {
    [self buildupDefaultSplashView];
    [_splashAd loadAdData];
}

- (void)_pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUSplashAdView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

- (void)logAdInfoAfterShow {
    BUMRitInfo *info = [self.splashAd.mediation getShowEcpmInfo];
    // 展示后可获取信息如下
    BUD_Log(@"ecpm:%@", info.ecpm);
    BUD_Log(@"platform:%@", info.adnName);
    BUD_Log(@"ritID:%@", info.slotID);
    BUD_Log(@"requestID:%@", info.requestID ?: @"None");

    BUD_Log(@"waterfallFillFailMessages:%@", [self.splashAd.mediation waterfallFillFailMessages]);
}

#pragma mark - BUMSplashAdDelegate

- (void)splashAdLoadSuccess:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];

    // 使用应用keyWindow的rootViewController（接入简单，推荐）
    [splashAd showSplashViewInRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
}

- (void)splashAdLoadFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillShow:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
    [self logAdInfoAfterShow];
}

- (void)splashAdDidShow:(BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    [self _pbud_logWithSEL:_cmd msg:@""];
    
    [splashAd.mediation destoryAd];
}

- (void)splashDidCloseOtherController:(BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nullable NSError *)error {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillPresentFullScreenModal:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidShowFailed:(BUSplashAd *_Nonnull)splashAd error:(NSError *)error {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

#pragma mark - BUSplashCardDelegate
- (void)splashCardReadyToShow:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
    [splashAd showCardViewInRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
}

- (void)splashCardViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

#pragma mark - BUSplashZoomOutDelegate
- (void)splashZoomOutReadyToShow:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
     if (splashAd.zoomOutView) {
         [splashAd showZoomOutViewInRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
     }
}

- (void)splashZoomOutViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self _pbud_logWithSEL:_cmd msg:@""];
}

@end

