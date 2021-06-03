//
//  BUDPersonalPromptsWebViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/12/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDPersonalPromptsWebViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import <WebKit/WebKit.h>

@interface BUDPersonalPromptsWebViewController () <WKNavigationDelegate>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) id<BUDislikeReportorDelegate> dislikeReportor;
@end

@implementation BUDPersonalPromptsWebViewController

- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.nativeAd = nativeAd;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (![self.nativeAd.data.personalPrompts validPersonalPrompts]) {
        return;
    }
    
    self.title = self.nativeAd.data.personalPrompts.personalizationName;
    
    WKWebViewConfiguration *configure = [[WKWebViewConfiguration alloc] init];
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configure];
    wkWebView.navigationDelegate = self;
    [self.view addSubview:wkWebView];
    NSURL *personalPromptsURL = [NSURL URLWithString:self.nativeAd.data.personalPrompts.personalizationUrl];
    [wkWebView loadRequest:[NSURLRequest requestWithURL:personalPromptsURL]];
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.dislikeReportor dislikeDidLoadPersonalizationPromptsURL:self.nativeAd.data.personalPrompts];
}


#pragma mark - getter
- (id<BUDislikeReportorDelegate>)dislikeReportor {
    if (_dislikeReportor == nil) {
        _dislikeReportor = [[BUDislikeReportor alloc] initWithNativeAd:self.nativeAd];
    }
    return _dislikeReportor;
}
@end
