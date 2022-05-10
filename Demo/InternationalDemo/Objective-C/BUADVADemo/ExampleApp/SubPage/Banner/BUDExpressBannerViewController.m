//
//  BUDExpressBannerViewController.m
//  BUDemo
//
//  Created by xxx on 2019/5/15.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressBannerViewController.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDExpressBannerViewController ()<BUNativeExpressBannerViewDelegate>
@property (nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;

@end

@implementation BUDExpressBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _statusLabel = [[UILabel alloc]init];
    [_statusLabel setFont:[UIFont systemFontOfSize:16]];
    [_statusLabel setTextColor:[UIColor redColor]];
    [_statusLabel setTextAlignment:NSTextAlignmentCenter];
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _statusLabel.text = @"Tap left button to load Ad";
    [self.view addSubview:_statusLabel];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_statusLabel]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[_statusLabel(25)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    
    UIButton *load320x50Ad = [UIButton buttonWithType:UIButtonTypeSystem];
    load320x50Ad.layer.borderWidth = 0.5;
    load320x50Ad.layer.cornerRadius = 8;
    load320x50Ad.layer.borderColor = [UIColor lightGrayColor].CGColor;
    load320x50Ad.translatesAutoresizingMaskIntoConstraints = NO;
    [load320x50Ad addTarget:self action:@selector(load320x50Ad:) forControlEvents:UIControlEventTouchUpInside];
    [load320x50Ad setTitle:@"Load 320X50 Banner" forState:UIControlStateNormal];
    [load320x50Ad setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:load320x50Ad];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[load320x50Ad]-170-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(load320x50Ad)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_statusLabel]-20-[load320x50Ad(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel,load320x50Ad)]];
    
    UIButton *load300x250Ad = [UIButton buttonWithType:UIButtonTypeSystem];
    load300x250Ad.layer.borderWidth = 0.5;
    load300x250Ad.layer.cornerRadius = 8;
    load300x250Ad.layer.borderColor = [UIColor lightGrayColor].CGColor;
    load300x250Ad.translatesAutoresizingMaskIntoConstraints = NO;
    [load300x250Ad addTarget:self action:@selector(load300x250Ad:) forControlEvents:UIControlEventTouchUpInside];
    [load300x250Ad setTitle:@"Load 300x250 Banner" forState:UIControlStateNormal];
    [load300x250Ad setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:load300x250Ad];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[load300x250Ad]-170-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(load300x250Ad)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[load320x50Ad]-20-[load300x250Ad(45)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(load320x50Ad,load300x250Ad)]];
    
    UIButton *showAd = [UIButton buttonWithType:UIButtonTypeSystem];
    showAd.layer.cornerRadius = 8;
    showAd.translatesAutoresizingMaskIntoConstraints = NO;
    [showAd addTarget:self action:@selector(showAd:) forControlEvents:UIControlEventTouchUpInside];
    [showAd setTitle:@"showAd" forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showAd setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [showAd setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:showAd];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[showAd(80)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(showAd)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[showAd(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(showAd)]];
}

- (void)load320x50Ad:(UIButton *)sender {
    [self loadBannerWithSlotID:@"980099802" size:CGSizeMake(320, 50)];
}

- (void)load300x250Ad:(UIButton *)sender {
    [self loadBannerWithSlotID:@"980088196" size:CGSizeMake(300, 250)];
}

- (void)showAd:(UIButton *)sender {
    [self.view addSubview:self.bannerView];
    self.statusLabel.text = @"Tap left button to load Ad";
}

/***important:
 When the AD loads successfully, WKWebView will be rendered immediately.
 If you want to pre-load, it is recommended to pre-load up to three ads at a time. If more than three ads are pre-loaded, there is a high probability that the RENDERING of WKWebview will fail.
 */
- (void)loadBannerWithSlotID:(NSString *)slotID size:(CGSize)size {
    [self.bannerView removeFromSuperview];
    
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
       window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
       window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
       window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    CGFloat bottom = 0.0;
    if (@available(iOS 11.0, *)) {
       bottom = window.safeAreaInsets.bottom;
    } else {
       // Fallback on earlier versions
    }

    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotID rootViewController:self adSize:size];
    self.bannerView.frame = CGRectMake((self.view.frame.size.width-size.width)/2.0, self.view.frame.size.height-size.height-bottom, size.width, size.height);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
    self.statusLabel.text = @"Loading......";
}

#pragma BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    self.statusLabel.text = @"Ad loaded fail";
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    self.statusLabel.text = @"Ad loaded";
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    self.statusLabel.text = @"Ad loaded fail";
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
    }];
    self.statusLabel.text = @"Tap left button to load Ad";
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
}

@end
