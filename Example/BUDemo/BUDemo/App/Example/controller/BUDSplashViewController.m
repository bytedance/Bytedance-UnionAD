//
//  BUDSplashViewController.m
//  BUDemo
//
//  Created by carl on 2017/8/7.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDSplashViewController.h"
#import <BUAdSDK/BUSplashAdView.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"

@interface BUDSplashViewController () <BUSplashAdDelegate>

@property (nonatomic, strong) BUSplashAdView *splashView;
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUDNormalButton *button1;

@property (nonatomic, strong) UITextField *textFieldWidth;
@property (nonatomic, strong) UITextField *textFieldHeight;
@property (nonatomic, assign) CGRect splashFrame;

@end

@implementation BUDSplashViewController

- (void)dealloc {}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:self.viewModel.slotID frame:self.splashFrame];
    splashView.delegate = self;
    splashView.rootViewController = self;
    
    [splashView loadAdData];
    [self.navigationController.view addSubview:splashView];
    self.splashView = splashView;
}

- (void)buildupHideSkipButtonSplashView {
    CGRect frame = self.navigationController.view.bounds;
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:self.viewModel.slotID frame:frame];
    splashView.hideSkipButton = YES;
    splashView.delegate = self;
    splashView.rootViewController = self;

    UIButton *custormSkipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [custormSkipButton setTitle:[NSString localizedStringForKey:Skip] forState:UIControlStateNormal];
    [custormSkipButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [custormSkipButton addTarget:self action:@selector(skipButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    custormSkipButton.frame = CGRectMake(width - 56 - 12, height - 36 - 12, 56, 36);
    [splashView addSubview:custormSkipButton];
    
    
    [splashView loadAdData];
    [self.navigationController.view addSubview:splashView];
    self.splashView = splashView;
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

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    BUD_Log(@"splashAdView AdDidClose");
    [splashAd removeFromSuperview];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    BUD_Log(@"splashAdView load data fail");
    [splashAd removeFromSuperview];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
