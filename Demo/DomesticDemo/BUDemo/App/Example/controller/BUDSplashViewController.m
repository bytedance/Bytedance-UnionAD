//
//  BUDSplashViewController.m
//  BUDemo
//
//  Created by carl on 2017/8/7.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDSplashViewController.h"
#import "BUDSplashContainerViewController.h"
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "UIView+Draw.h"
#import "BUDAnimationTool.h"
#import "UIColor+DarkMode.h"


@interface BUDSplashViewController () <BUSplashAdDelegate, BUSplashCardDelegate, BUSplashZoomOutDelegate>

@property (nonatomic, strong) BUSplashAd *splashAd;
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUDNormalButton *button1;
@property (nonatomic, strong) BUDNormalButton *button2;
@property (nonatomic, strong) BUDNormalButton *button3;

@property (strong, nonatomic) UISlider *widthSlider;
@property (strong, nonatomic) UISlider *heightSlider;
@property (strong, nonatomic) UILabel *widthLabel;
@property (strong, nonatomic) UILabel *heightLabel;
@property (nonatomic, assign) CGRect splashFrame;
@property (nonatomic, assign) BOOL showBottomView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) BUDSplashContainerViewController *customSplashVC;
@property (nonatomic, strong) BUSplashZoomOutView *zoomOutView;

@end

@implementation BUDSplashViewController

- (void)dealloc {}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildView];

    self.splashFrame = self.view.bounds;
    self.rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y * 0.8);
    self.button1.center = CGPointMake(self.view.center.x, self.button.center.y + 80);
    self.button2.center = CGPointMake(self.view.center.x, self.button.center.y + 160);
    self.button3.center = CGPointMake(self.view.center.x, self.button.center.y + 240);
}

- (void)buildView {
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    // 宽
    UILabel *lableWidth = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 60, 30)];
    lableWidth.textAlignment = NSTextAlignmentLeft;
    lableWidth.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lableWidth];
    self.widthLabel =lableWidth;
    self.widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(lableWidth.right+10, lableWidth.top, self.view.width-lableWidth.right-10-lableWidth.left, 31)];
    self.widthSlider.maximumValue = CGRectGetWidth(self.view.frame);
    self.widthSlider.tintColor = mainColor;
    self.widthSlider.value = self.widthSlider.maximumValue;
    [self.view addSubview:self.widthSlider];
    // 高
    UILabel *lableHeight = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lableWidth.frame) + 10, 60, 30)];
    lableHeight.textAlignment = NSTextAlignmentLeft;
    lableHeight.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lableHeight];
    self.heightLabel = lableHeight;
    self.heightSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.widthSlider.left, lableHeight.top, self.widthSlider.width, 31)];
    self.heightSlider.maximumValue = CGRectGetHeight(self.view.frame);
    self.heightSlider.tintColor = mainColor;
    self.heightSlider.value = self.heightSlider.maximumValue;
    [self.view addSubview:self.heightSlider];
    
    lableWidth.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Width],self.widthSlider.value];
    lableHeight.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Height],self.heightSlider.value];
    [self.widthSlider addTarget:self action:@selector(sliderPositionWChanged) forControlEvents:UIControlEventValueChanged];
    [self.heightSlider addTarget:self action:@selector(sliderPositionHChanged) forControlEvents:UIControlEventValueChanged];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    //
    self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.button.showRefreshIncon = YES;
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:[NSString localizedStringForKey:Splash]  forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    self.button1 = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.6, 0, 0)];
    self.button1.showRefreshIncon = YES;
    [self.button1 addTarget:self action:@selector(button1Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 setTitle:[NSString localizedStringForKey:SplashContainer]  forState:UIControlStateNormal];
    [self.view addSubview:self.button1];

    self.button2 = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.6, 0, 0)];
    self.button2.showRefreshIncon = YES;
    [self.button2 addTarget:self action:@selector(button2Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 setTitle:[NSString localizedStringForKey:CustomCloseBtn]  forState:UIControlStateNormal];
    [self.view addSubview:self.button2];
    
    self.button3 = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.6, 0, 0)];
    self.button3.showRefreshIncon = YES;
    [self.button3 addTarget:self action:@selector(button3Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 setTitle:[NSString localizedStringForKey:@"显示底部bottomView"]  forState:UIControlStateNormal];
    [self.view addSubview:self.button3];
}

- (void)sliderPositionWChanged {
    self.widthLabel.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Width],self.widthSlider.value];
}

- (void)sliderPositionHChanged {
    self.heightLabel.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Height],self.heightSlider.value];
}

- (void)buildupDefaultSplashView {
    _showBottomView = NO;
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    
    // 创建splashAd对象
    _splashAd = [[BUSplashAd alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size];
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    _splashAd.delegate = self;
    _splashAd.cardDelegate = self;
    _splashAd.zoomOutDelegate = self;
    
    _splashAd.supportCardView = YES;
    _splashAd.supportZoomOutView = YES;
    _splashAd.tolerateTimeout = 3.0;

    // 加载广告
    [_splashAd loadAdData];
}

// 半屏样式
- (void)buildupSplashViewWithBottomView {
    _showBottomView = YES;

    self.splashFrame = CGRectMake(0, 0, _rootViewController.view.size.width, _rootViewController.view.size.height - 100);
    
    _splashAd = [[BUSplashAd alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size];
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    _splashAd.delegate = self;
    _splashAd.cardDelegate = self;
    _splashAd.zoomOutDelegate = self;
    
    _splashAd.supportCardView = YES;
    _splashAd.supportZoomOutView = YES;
    _splashAd.tolerateTimeout = 3;

    [_splashAd loadAdData];
    
    // 自定义底部视图
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.splashFrame.size.height, self.splashFrame.size.width, 100)];
    _bottomView.backgroundColor = [UIColor brownColor];
}

- (void)buildupHideSkipButtonSplashView {
    _showBottomView = NO;
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    
    _splashAd = [[BUSplashAd alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size];
    _splashAd.delegate = self;
    _splashAd.cardDelegate = self;
    _splashAd.zoomOutDelegate = self;
    
    _splashAd.supportCardView = YES;
    _splashAd.supportZoomOutView = YES;
    _splashAd.hideSkipButton = YES;
    _splashAd.tolerateTimeout = 3;
    [_splashAd loadAdData];
}

- (UIButton *)p_custormSkipButton {
    UIButton *custormSkipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [custormSkipButton setTitle:[NSString localizedStringForKey:Skip] forState:UIControlStateNormal];
    [custormSkipButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [custormSkipButton addTarget:self action:@selector(skipButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = CGRectGetWidth(self.splashFrame);
    CGFloat height = CGRectGetHeight(self.splashFrame);
    CGFloat safeBottomMargin = 12.0;
    if (@available(iOS 11.0, *)) {
        safeBottomMargin = self.view.safeAreaInsets.bottom;
    }
    custormSkipButton.frame = CGRectMake(width - 56 - 12, height - 36 - safeBottomMargin, 56, 36);
    
    return custormSkipButton;
}

- (void)skipButtonTapped:(UIButton *)sender {
    
    if (self.splashAd.hideSkipButton) {
        //
        UIView *splashViewSnapshot = [self.splashAd.splashView snapshotViewAfterScreenUpdates:YES];
        [self.splashAd removeSplashView];
        // 展示点睛
        if (self.splashAd.zoomOutView) {
            self.splashAd.zoomOutView.rootViewController = self.navigationController;
            [self.navigationController.view addSubview:self.splashAd.zoomOutView];
            [self.navigationController.view addSubview:splashViewSnapshot];
            [[BUDAnimationTool sharedInstance] transitionFromView:splashViewSnapshot toView:self.splashAd.zoomOutView splashCompletion:^{
                [splashViewSnapshot removeFromSuperview];
            }];
        }
        // 展示卡片
        if (self.splashAd.cardView) {
            [self.splashAd showCardViewInRootViewController:self.navigationController];
        }
    } else {
        [self.splashAd removeSplashView];
    }
}

- (void)buttonTapped:(UIButton *)sender {
    [self buildupDefaultSplashView];
}

- (void)button1Tapped:(UIButton *)sender {
    _customSplashVC = [[BUDSplashContainerViewController alloc] init];
    [_customSplashVC loadSplashAd];
}

- (void)button2Tapped:(UIButton *)sender {
    [self buildupHideSkipButtonSplashView];
}

- (void)button3Tapped:(UIButton *)sender {
    [self buildupSplashViewWithBottomView];
}

- (void)setUpSplashZoomOutAd:(BUSplashAd *)splashAd {
    if (!splashAd.zoomOutView) {
        return;
    }
    [self.navigationController.view addSubview:splashAd.zoomOutView];
    [self.navigationController.view addSubview:splashAd.splashViewSnapshot];
    splashAd.zoomOutView.rootViewController = self;
    [[BUDAnimationTool sharedInstance] transitionFromView:splashAd.splashViewSnapshot toView:splashAd.zoomOutView splashCompletion:^{
        [splashAd.splashViewSnapshot removeFromSuperview];
    }];
}

#pragma mark - BUSplashAdDelegate

- (void)splashAdLoadSuccess:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    // 使用应用keyWindow的rootViewController（接入简单，推荐）
    [splashAd showSplashViewInRootViewController:_rootViewController];
    
}

- (void)splashAdLoadFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbud_logWithSEL:_cmd msg:@""];
 
}

- (void)splashAdRenderSuccess:(nonnull BUSplashAd *)splashAd {
    
    [self pbud_logWithSEL:_cmd msg:@""];
    
    if (splashAd.hideSkipButton) { // 自定义跳过按钮
        [splashAd.splashView addSubview:[self p_custormSkipButton]];
    }
    
    if (self.showBottomView) { // 自定义底部视图
        [splashAd.splashRootViewController.view addSubview:_bottomView];
    }
}

- (void)splashAdRenderFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillShow:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidShow:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(nonnull BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    [self pbud_logWithSEL:_cmd msg:@""];
    
    if (self.showBottomView) {
        [self.bottomView removeFromSuperview];
    }
}

- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nonnull NSError *)error {
    [self pbud_logWithSEL:_cmd msg:@""];
}


#pragma mark - BUSplashCardDelegate
- (void)splashCardReadyToShow:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    [splashAd showCardViewInRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
}

- (void)splashCardViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

#pragma mark - BUSplashZoomOutDelegate

- (void)splashZoomOutReadyToShow:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    // 接入方法一：使用SDK提供动画接入
     if (splashAd.zoomOutView) {
         [splashAd showZoomOutViewInRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
     }
    
    // 接入方法二：自定义动画接入
//    if (splashAd.zoomOutView) {
//        __weak typeof(self) weakSelf = self;
//        UIViewController *rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
//        splashAd.zoomOutView.rootViewController = rootViewController;
//        [rootViewController.view addSubview:splashAd.zoomOutView];
//        [rootViewController.view addSubview:splashAd.splashViewSnapshot];
//        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd.splashViewSnapshot toView:splashAd.zoomOutView splashCompletion:^{
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            [strongSelf.splashAd.splashViewSnapshot removeFromSuperview];
//        }];
//    }
}

- (void)splashZoomOutViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}



- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUSplashAdView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
