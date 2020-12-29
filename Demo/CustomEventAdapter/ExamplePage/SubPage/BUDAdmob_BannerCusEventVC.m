//
//  BUDAdmob_BannerCusEventVC.m
//  BUADVADemo
//
//  Created by bytedance on 2020/9/28.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_BannerCusEventVC.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface BUDAdmob_BannerCusEventVC ()<GADBannerViewDelegate>
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) GADBannerView *bannerView;
@end

@implementation BUDAdmob_BannerCusEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"Banner";
    
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
    // Do any additional setup after loading the view.
}

- (void)load320x50Ad:(UIButton *)sender {
    [self loadBannerWithID:@"ca-app-pub-2547387438729744/5631782273" size:CGSizeMake(320, 50)];
}

- (void)load300x250Ad:(UIButton *)sender {
    [self loadBannerWithID:@"ca-app-pub-2547387438729744/3823584037" size:CGSizeMake(300, 250)];
}

- (void)showAd:(UIButton *)sender {
    [self.view addSubview:self.bannerView];
    self.statusLabel.text = @"Tap left button to load Ad";
}

- (void)loadBannerWithID:(NSString *)adUnitID size:(CGSize)size {
    [self.bannerView removeFromSuperview];
    self.bannerView = nil;
    
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

    _bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFromCGSize(size)];
    _bannerView.adUnitID = adUnitID;
    _bannerView.rootViewController = self;
    _bannerView.delegate = self;
    [_bannerView loadRequest:[GADRequest request]];
    
    self.bannerView.frame = CGRectMake((self.view.frame.size.width-size.width)/2.0, self.view.frame.size.height-size.height-bottom, size.width, size.height);
    self.bannerView.delegate = self;
    self.statusLabel.text = @"Loading......";
}

#pragma mark - GADBannerViewDelegate
/// Tells the delegate that an ad request successfully received an ad. The delegate may want to add
/// the banner view to the view hierarchy if it hasn't been added yet.
- (void)adViewDidReceiveAd:(nonnull GADBannerView *)bannerView {
    _statusLabel.text = @"Ad loaded.";
    _bannerView = bannerView;
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(nonnull GADBannerView *)bannerView
didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    _statusLabel.text = @"Ad loaded fail.";
}

#pragma mark Click-Time Lifecycle Notifications

/// Tells the delegate that a full screen view will be presented in response to the user clicking on
/// an ad. The delegate may want to pause animations and time sensitive interactions.
- (void)adViewWillPresentScreen:(nonnull GADBannerView *)bannerView {
    
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(nonnull GADBannerView *)bannerView {
    
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(nonnull GADBannerView *)bannerView {
    ///remove old ad
    [_bannerView removeFromSuperview];
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(nonnull GADBannerView *)bannerView {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
