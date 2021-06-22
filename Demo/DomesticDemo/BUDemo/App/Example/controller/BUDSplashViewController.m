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

@interface BUDSplashViewController () <BUSplashAdDelegate,BUSplashZoomOutViewDelegate>

@property (nonatomic, strong) BUSplashAdView *splashView;
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUDNormalButton *button1;
@property (nonatomic, strong) BUDNormalButton *button2;

@property (strong, nonatomic) UISlider *widthSlider;
@property (strong, nonatomic) UISlider *heightSlider;
@property (strong, nonatomic) UILabel *widthLabel;
@property (strong, nonatomic) UILabel *heightLabel;
@property (nonatomic, assign) CGRect splashFrame;

@end

@implementation BUDSplashViewController

- (void)dealloc {}

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
    self.button2.center = CGPointMake(self.view.center.x, self.button.center.y + 160);
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
}

- (void)sliderPositionWChanged {
    self.widthLabel.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Width],self.widthSlider.value];
}

- (void)sliderPositionHChanged {
    self.heightLabel.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Height],self.heightSlider.value];
}

- (void)buildupDefaultSplashView {
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:self.viewModel.slotID frame:self.splashFrame];
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    splashView.delegate = self;
    splashView.rootViewController = self;
    splashView.tolerateTimeout = 3;
    [splashView loadAdData];
    [self.navigationController.view addSubview:splashView];
    self.splashView = splashView;
}

- (void)buildupHideSkipButtonSplashView {
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:self.viewModel.slotID frame:self.splashFrame];
    splashView.hideSkipButton = YES;
    splashView.delegate = self;
    splashView.rootViewController = self;
    
    UIButton *custormSkipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [custormSkipButton setTitle:[NSString localizedStringForKey:Skip] forState:UIControlStateNormal];
    [custormSkipButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [custormSkipButton addTarget:self action:@selector(skipButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    custormSkipButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGFloat width = CGRectGetWidth(self.splashFrame);
    CGFloat height = CGRectGetHeight(self.splashFrame);
    CGFloat safeBottom = 12;
    if (@available(iOS 11.0, *)) {
        safeBottom = self.view.safeAreaInsets.bottom;
    } else {
        // Fallback on earlier versions
    }
    custormSkipButton.frame = CGRectMake(width - 56 - 12, height - 36 - safeBottom, 56, 36);

    [splashView addSubview:custormSkipButton];
    
    
    [splashView loadAdData];
    [self.navigationController.view addSubview:splashView];
    self.splashView = splashView;
}

- (void)skipButtonTapped:(UIButton *)sender {
    [self handleSplashDimiss:self.splashView];
}

- (void)buttonTapped:(UIButton *)sender {
    [self buildupDefaultSplashView];
}

- (void)button1Tapped:(UIButton *)sender {
    BUDSplashContainerViewController *splashContainer = [[BUDSplashContainerViewController alloc] init];
    splashContainer.appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [[UIApplication sharedApplication].keyWindow setRootViewController:splashContainer];
}

- (void)button2Tapped:(UIButton *)sender {
    [self buildupHideSkipButtonSplashView];
}

- (void)handleSplashDimiss:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView splashCompletion:^{
            [splashAd removeFromSuperview];
        }];
    } else{
        [splashAd removeFromSuperview];
    }
}

- (void)removeSplashAdView {
    if (self.splashView) {
        [self.splashView removeFromSuperview];
        self.splashView = nil;
    }
}

- (void)setUpSplashZoomOutAd:(BUSplashAdView *)splashAdView {
    if (!splashAdView.zoomOutView) {
        return;
    }
    [self.navigationController.view addSubview:splashAdView.zoomOutView];
    [self.navigationController.view addSubview:splashAdView];
    splashAdView.zoomOutView.rootViewController = self;
    splashAdView.zoomOutView.delegate = self;
    [[BUDAnimationTool sharedInstance] transitionFromView:splashAdView toView:splashAdView.zoomOutView splashCompletion:^{
        [splashAdView removeFromSuperview];
        [BUDAnimationTool sharedInstance].splashContainerVC = nil;
    }];
}

#pragma mark - BUSplashAdDelegate
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"mediaExt %@",splashAd.mediaExt]];
    if (splashAd.zoomOutView) {
        // Add this view to your container
        [self.navigationController.view insertSubview:splashAd.zoomOutView belowSubview:splashAd];
        splashAd.zoomOutView.rootViewController = self;
        splashAd.zoomOutView.delegate = self;
    }
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [splashAd.zoomOutView removeFromSuperview];
    }
    [splashAd removeFromSuperview];
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    [self handleSplashDimiss:splashAd];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    [self handleSplashDimiss:splashAd];
    // 'zoomOutView' is nil, there will be no subsequent operation to completely remove splashAdView and avoid memory leak
    // 'zoomOutView' is not nil，do nothing
    if (!splashAd.zoomOutView) {
        [self removeSplashAdView];
    }
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    [self handleSplashDimiss:splashAd];
    // Display failed, no subsequent operation, completely remove 'splashAdView', avoid memory leak
    [self removeSplashAdView];
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    
    // After closing the other controllers, there will be no further action, so 'splashView' needs to be released to avoid memory leaks
    [self removeSplashAdView];
    [self pbud_logWithSEL:_cmd msg:str];
}

- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    [self handleSplashDimiss:splashAd];
    // 'zoomOutView' is nil, there will be no subsequent operation to completely remove splashAdView and avoid memory leak
    // 'zoomOutView' is not nil，do nothing
    if (!splashAd.zoomOutView) {
        [self removeSplashAdView];
    }
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUSplashAdView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd {
    [self pbud_splashzoomout_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    [self removeSplashAdView];
    [self pbud_splashzoomout_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    [self removeSplashAdView];
    [self pbud_splashzoomout_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    [self removeSplashAdView];
    [self pbud_splashzoomout_logWithSEL:_cmd msg:@""];
}

- (void)pbud_splashzoomout_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUSplashZoomOutView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
