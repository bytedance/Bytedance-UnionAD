//
//  BUDExpressSplashViewController.m
//  BUDemo
//
//  Created by cuiyanan on 2019/10/17.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressSplashViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"

@interface BUDExpressSplashViewController ()<BUNativeExpressSplashViewDelegate>
@property (nonatomic, strong) BUNativeExpressSplashView *splashView;
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUDNormalButton *button1;

@property (nonatomic, strong) UITextField *textFieldWidth;
@property (nonatomic, strong) UITextField *textFieldHeight;
@property (nonatomic, assign) CGRect splashFrame;
@end

@implementation BUDExpressSplashViewController

- (void)dealloc {}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildView];
    
    self.textFieldWidth.text = [NSString stringWithFormat:@"  %.0f",self.view.bounds.size.width];
    self.textFieldHeight.text = [NSString stringWithFormat:@"  %.0f",self.view.bounds.size.height];
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
    UILabel *lableWidth = [[UILabel alloc] initWithFrame:CGRectMake(20, NavigationBarHeight + 20, 40, 30)];
    lableWidth.text = [NSString localizedStringForKey:Width];
    lableWidth.textAlignment = NSTextAlignmentLeft;
    lableWidth.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lableWidth];
    self.textFieldWidth = [[UITextField alloc] init];
    self.textFieldWidth.frame = CGRectMake(CGRectGetMaxX(lableWidth.frame), NavigationBarHeight + 20, 100, 30);
    [self.textFieldWidth.layer setBorderWidth:1.0];
    [self.textFieldWidth.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:self.textFieldWidth];
    // 高
    UILabel *lableHeight = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lableWidth.frame) + 10, 80, 30)];
    lableHeight.text = [NSString localizedStringForKey:Height];
    lableHeight.textAlignment = NSTextAlignmentLeft;
    lableHeight.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lableHeight];
    self.textFieldHeight = [[UITextField alloc] init];
    self.textFieldHeight.frame = CGRectMake(CGRectGetMaxX(lableWidth.frame), CGRectGetMinY(lableHeight.frame), 100, 30);
    [self.textFieldHeight.layer setBorderWidth:1.0];
    [self.textFieldHeight.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:self.textFieldHeight];
    
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

- (void)buildupDefaultSplashView {
    if (self.textFieldWidth.text.length && self.textFieldHeight.text.length) {
        CGFloat width = [self.textFieldWidth.text doubleValue];
        CGFloat height = [self.textFieldHeight.text doubleValue];
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    
    self.splashView = [[BUNativeExpressSplashView alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size rootViewController:self];
    self.splashView.delegate = self;
    
    [self.splashView loadAdData];
    [self.navigationController.view addSubview:self.splashView];
}

- (void)buildupHideSkipButtonSplashView {
    CGRect frame = self.navigationController.view.bounds;
    self.splashView = [[BUNativeExpressSplashView alloc] initWithSlotID:self.viewModel.slotID adSize:frame.size rootViewController:self];
    self.splashView.hideSkipButton = YES;
    self.splashView.delegate = self;
    
    UIButton *custormSkipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [custormSkipButton setTitle:[NSString localizedStringForKey:Skip] forState:UIControlStateNormal];
    [custormSkipButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [custormSkipButton addTarget:self action:@selector(skipButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
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

@end
