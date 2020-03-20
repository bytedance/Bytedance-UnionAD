//
//  BUDExpressSplashViewController.m
//  BUDemo
//
//  Created by Bytedance on 2019/10/17.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressSplashViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "UIView+Draw.h"
#import "NSString+LocalizedString.h"

@interface BUDExpressSplashViewController ()<BUNativeExpressSplashViewDelegate>
@property (nonatomic, strong) BUNativeExpressSplashView *splashView;
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUDNormalButton *button1;

@property (strong, nonatomic) UISlider *widthSlider;
@property (strong, nonatomic) UISlider *heightSlider;
@property (strong, nonatomic) UILabel *widthLabel;
@property (strong, nonatomic) UILabel *heightLabel;
@property (nonatomic, assign) CGRect splashFrame;
@end

@implementation BUDExpressSplashViewController

- (void)dealloc {}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildView];
    
    self.splashFrame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*0.8);
    self.button1.center = CGPointMake(self.view.center.x, self.view.center.y*1.2);
}

- (void)buildView {
    // 宽
    UILabel *lableWidth = [[UILabel alloc] initWithFrame:CGRectMake(20, NavigationBarHeight + 20, 60, 30)];
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
    [self.button1 setTitle:[NSString localizedStringForKey:CustomCloseBtn]  forState:UIControlStateNormal];
    [self.view addSubview:self.button1];
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
    
    self.splashView = [[BUNativeExpressSplashView alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size rootViewController:self];
    self.splashView.delegate = self;
    self.splashView.tolerateTimeout = 3;
    [self.splashView loadAdData];
    [self.navigationController.view addSubview:self.splashView];
}

- (void)buildupHideSkipButtonSplashView {
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    
    self.splashView = [[BUNativeExpressSplashView alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size rootViewController:self];
    self.splashView.hideSkipButton = YES;
    self.splashView.delegate = self;
    
    UIButton *custormSkipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [custormSkipButton setTitle:[NSString localizedStringForKey:Skip] forState:UIControlStateNormal];
    [custormSkipButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [custormSkipButton addTarget:self action:@selector(skipButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = CGRectGetWidth(self.splashFrame);
    CGFloat height = CGRectGetHeight(self.splashFrame);
    custormSkipButton.frame = CGRectMake(width - 56 - 12, height - 36 - 12, 56, 36);
    [self.splashView addSubview:custormSkipButton];
    
    
    [self.splashView loadAdData];
    [self.navigationController.view addSubview:self.splashView];
}

- (void)skipButtonTapped:(UIButton *)sender {
    [self.splashView removeFromSuperview];
}

- (void)buttonTapped:(UIButton *)sender {
    [self buildupDefaultSplashView];
}

- (void)button1Tapped:(UIButton *)sender {
    [self buildupHideSkipButtonSplashView];
}

#pragma mark BUNativeExpressSplashViewDelegate
- (void)nativeExpressSplashViewDidLoad:(nonnull BUNativeExpressSplashView *)splashAdView {
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashView:(nonnull BUNativeExpressSplashView *)splashAdView didFailWithError:(NSError * _Nullable)error {
    [self.splashView removeSplashView];//记得在remove广告视图前调用remove方法，否则可能出现倒计时有问题或者视频播放有问题
    [self.splashView removeFromSuperview];
    NSLog(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressSplashViewRenderSuccess:(nonnull BUNativeExpressSplashView *)splashAdView {
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewRenderFail:(nonnull BUNativeExpressSplashView *)splashAdView error:(NSError * _Nullable)error {
    [self.splashView removeSplashView];//记得在remove广告视图前调用remove方法，否则可能出现倒计时有问题或者视频播放有问题
    [self.splashView removeFromSuperview];
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewWillVisible:(nonnull BUNativeExpressSplashView *)splashAdView {
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewDidClick:(nonnull BUNativeExpressSplashView *)splashAdView {
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewDidClickSkip:(nonnull BUNativeExpressSplashView *)splashAdView {
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewDidClose:(nonnull BUNativeExpressSplashView *)splashAdView {
    [self.splashView removeSplashView];//记得在remove广告视图前调用remove方法，否则可能出现倒计时有问题或者视频播放有问题
    [self.splashView removeFromSuperview];
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewFinishPlayDidPlayFinish:(BUNativeExpressSplashView *)splashView didFailWithError:(NSError *)error {
    NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewDidCloseOtherController:(BUNativeExpressSplashView *)splashView interactionType:(BUInteractionType)interactionType {
    NSString *str = nil;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    BUD_Log(@"%s __ %@",__func__,str);
}

@end
